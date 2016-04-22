from web import app
from gevent.wsgi import WSGIServer


if __name__ == '__main__':
    http_server = WSGIServer(('', 5000), app)
    http_server.start()
    http_server.serve_forever()


