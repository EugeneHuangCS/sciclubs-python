from tornado import version
from tornado.web import RequestHandler
from model.entity import Entity

class IndexHandler(RequestHandler):
	def get(self):
		self.render('index.html', entity = Entity(version))
