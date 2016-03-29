from web import app
from gevent.wsgi import WSGIServer

http_server = WSGIServer(('', 8083), app)
http_server.start()
http_server.serve_forever()

