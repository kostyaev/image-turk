var jsonServer = require('json-server')
var db = require('./db.json')

var server = jsonServer.create()
server.use(jsonServer.defaults())

var router = jsonServer.router(db)
server.use(router)

console.log('Listening at 4000')
server.listen(4000)
