/**
 * Module dependencies.
 */

require('coffee-script');

var express = require('express')
  , http = require('http')
  , path = require('path')
  , fs = require('fs')
  , mongoose = require('mongoose')
  , MongoStore = require('connect-mongo')(express);

mongoose.connect('localhost', 'neighborchat');

var modelsPath = __dirname + '/models';

fs.readdirSync(modelsPath).forEach(function(file) {
  return require(modelsPath + "/" + file);
});

var app = express();

var routes = require('./routes')
  , thread = require('./routes/thread')
  , maxAge = 1000 * 60 * 60 * 24 * 365;

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'hbs');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser());
  app.use(express.session({
    secret: 'this is a secret',
    store: new MongoStore({
      url: 'mongodb://localhost/neighborchat'
    })
  }));
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
