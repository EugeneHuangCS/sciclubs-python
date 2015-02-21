import MySQLdb
from collections import deque
from time import time as timestamp
from tornado.concurrent import Future
from concurrent.futures import ThreadPoolExecutor
from sae.const import MYSQL_HOST, MYSQL_HOST_S, MYSQL_PORT, MYSQL_USER, MYSQL_PASS, MYSQL_DB

executor = ThreadPoolExecutor(max_workers=1)

class Connection(object):
	def __init__(self, pool, conn):
		super(Connection, self).__init__()
		self.pool = pool
		self.conn = conn
		#print("init Active: %s -> %s" % (self.pool.active, self.pool.active+1))
		self.pool.active += 1

	def __del__(self):
		#print("del Active: %s -> %s" % (self.pool.active, self.pool.active-1))
		self.pool.active -= 1
		self.pool.put(self.conn)

	def cursor(self):
		asyncCursor = self.conn.cursor()
		def _execute(sql):
			future = executor.submit(asyncCursor.execute, sql)
			return future
		asyncCursor._execute = _execute
		return asyncCursor

	def commit(self):
		self.conn.commit()

	def rollback(self):
		self.conn.rollback()

class Pool(object):
	def __init__(self, limit = 10, expire = 25, **params):
		super(Pool, self).__init__()
		self.limit = limit
		self.expire = expire
		self.params = params
		self.active = 0
		self.ready = deque()
		self.pending = deque()

	def get(self):
		future = Future()

		try:
			#print('Before filter Ready: %s' % len(self.ready))
			earliest = timestamp() - self.expire
			self.ready = deque(filter(lambda i: i[0] > earliest, self.ready))
			#print('After filter Ready: %s' % len(self.ready))
			time, conn = self.ready.popleft()
			future.set_result(Connection(self, conn))
		except IndexError as e:
			# if it is allowd to create new connections
			if self.active < self.limit:
				#print('Creating a connection')
				self.create(future)
			else:
				#print('Penging a connection')
				self.pending.append(future)

		return future

	def put(self, conn):
		try:
			future = self.pending.popleft()
			future.set_result(Connection(self, conn))
			#print('Reuse a connection')
		except IndexError as e:
			self.ready.append((timestamp(), conn))
			#print('Ready connections %s' % len(self.ready))

	def create(self, future):
		conn = MySQLdb.connect(host=MYSQL_HOST, port=int(MYSQL_PORT), user=MYSQL_USER, passwd=MYSQL_PASS, db=MYSQL_DB)
		future.set_result(Connection(self, conn))
		#print('Created a connection')
