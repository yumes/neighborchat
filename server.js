/**
 * Module dependencies.
 */

require('coffee-script');

var express = require('express')
  , http = require('http')
  , path = require('path')
  , fs = require('fs')
  , mongoose = require('mongoose');

mongoose.connect('localhost', 'neighborchat');

var modelsPath = __dirname + '/models';

fs.readdirSync(modelsPath).forEach(function(file) {
  return require(modelsPath + "/" + file);
});

var app = express();

var routes = require('./routes')
  , thread = require('./routes/thread');

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'hbs');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(routes.middleware)
  app.use('/thread', thread.middleware)
  app.use(express.static(path.join(__dirname, 'public')));
});

app.configure('development', function(){
  app.use(express.errorHandler());
});


http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
