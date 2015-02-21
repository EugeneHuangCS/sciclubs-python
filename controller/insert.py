import sae.const
from tornado.gen import coroutine
from tornado.web import RequestHandler
from service.mysql import MasterConnector

class InsertHandler(RequestHandler):
	@coroutine
	def get(self):
		conn = yield MasterConnector()
		cursor = conn.cursor()
		yield cursor._execute('SELECT * FROM `data`')
		allData = cursor.fetchall()
		self.write(str(allData))
