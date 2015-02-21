from controller.index import IndexHandler
from controller.insert import InsertHandler

route = [
	(r'/', IndexHandler),
	(r'/insert', InsertHandler),
]
