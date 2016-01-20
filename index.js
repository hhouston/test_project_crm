/**********************************************************************************************************************************
 *	  
 *	index.js
 *  Node.js is an event-driven model processing at runtime. 
 *	Callbacks run asynchronously
 *	
 *	This script listens for incoming http requests on port 3000 and calls function (req, res) then returns a response to the caller
 *	
 *	
 *
 * Hunter Houston
 *********************************************************************************************************************************/
 



//require imports modules into the current file
var http = require('http'),
    express = require('express'),
    path = require('path'),
    MongoClient = require('mongodb').MongoClient,
	Server = require('mongodb').Server,
	CollectionDriver = require('./collectionDriver').CollectionDriver,
    bodyParser = require('body-parser'),
    assert = require('assert'); 

//set
var app = express();
app.set('port', process.env.PORT || 3000); 
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

//use
app.use(bodyParser.json()); 
//app.use(express.static(path.join(__dirname, 'public')));

var url = 'mongodb://localhost:27017/test';
var collectionDriver;
var mongoHost = 'localhost'; //A
var mongoPort = 27017; 

var mongoClient = new MongoClient(new Server(mongoHost, mongoPort)); //B

// Use connect method to connect to the Server
mongoClient.connect(url, function (err, db) {
	this.db = db;
  if (err) {
    console.log('Unable to connect to the mongoDB server. Error:', err);
  } else {
    //HURRAY!! We are connected. :)
    debugger;
    console.log('Connection established to', url);
    console.log('db' + this.db);
	this.db = db;
    collectionDriver = new CollectionDriver(db); 
	//console.log(collectionDriver);
	}
});

//print request type
app.use('/:collection', function(req, res, next) {
  console.log('Request URL:', req.originalUrl);
  next();
}, function (req, res, next) {
  console.log('Request Type:', req.method);
  next();
});

//get user object
/*
app.get('/user', function(req, res, next) {
	debugger;
	console.log('ID:', req.params.id);
	console.log(req.params.collection);
	var query = req.query.query; 
	console.log('query user object: '+query);
	if (query) {
			query = JSON.parse(query);
			collectionDriver.queryUser(req.params.collection, query, returnCollectionResults(req, res));

	} else {
		console.log('no user query');
	}
	
});
*/
/*
//get user object
app.get('/user/:id', function(req, res, next) {
	debugger;
	console.log('ID:', req.params.id);
	next();
}, function(req, res, next) {
	res.send('User Info');
	var query = req.query.query; 
	console.log('query: '+query);
	

});
*/

//Perform a collection query
/*
CollectionDriver.prototype.query = function(collectionName, query, callback) { 
    this.getCollection(collectionName, function(error, the_collection) { 
      if( error ) callback(error)
      else {
        the_collection.find(query).toArray(function(error, results) { 
          if( error ) callback(error)
          else callback(null, results)
        });
      }
    });
};
*/

app.get('/:collection', function(req, res, next) {  
   var params = req.params;
   var query = req.query.query; 
   console.log('query function: '+query);
   //console.log('app get' + app.get('env'));
   //console.log('next:' + next);
   if (query) {
        query = JSON.parse(query); 
        collectionDriver.query(req.params.collection, query, returnCollectionResults(req,res)); 
   } else {
        collectionDriver.findAll(req.params.collection, returnCollectionResults(req,res)); 
   }
});
 
function returnCollectionResults(req, res) {
    return function(error, objs) { 
        if (error) { res.status(400).send(error); }
	        else { 
                    if (req.accepts('html')) { 
                        res.render('data',{objects: objs, collection: req.params.collection});
                    } else {
                        res.set('Content-Type','application/json');
                        res.status(200).send(objs);
                }
        }
    }
}
 
app.get('/:collection/:entity', function(req, res) {
   var params = req.params;
   var entity = params.entity;
   var collection = params.collection;
   
/*
   	this.db.collection(''+collection).findOne({xcodeID: entity}, function(error, doc){
		console.log('doc'+doc._id);
		mongo_id = doc._id;
   
*/
   if (entity) {
       collectionDriver.get(collection, entity, function(error, objs) { 
          if (error) { res.status(400).send(error); }
          else { res.status(200).send(objs); } 
       });
   } else {
      res.status(400).send({error: 'bad url', url: req.url});
   }
   
   //});
   
});

app.post('/:collection', function(req, res) { 
    var object = req.body;
    var collection = req.params.collection;
    collectionDriver.save(collection, object, function(err,docs) {
          if (err) { res.status(400).send(err); } 
          else { res.status(201).send(docs); } 
     });
});


app.put('/:collection/:entity', function(req, res) { //A
	debugger;
    var params = req.params;
    var entity = params.entity;
    var collection = params.collection;
	console.log('entity' + entity);		
	var mongo_id;
	this.db.collection(''+collection).findOne({xcodeID: entity}, function(error, doc){
		console.log('doc'+doc._id);
		mongo_id = doc._id;
	
		console.log('index.js put mongo_id: ' + mongo_id);
    if (mongo_id) {
       collectionDriver.update(collection, req.body, mongo_id , function(error, objs) { 
          if (error) { res.status(400).send(error); }
          else { res.status(200).send(objs); } 
       });
   } else {
	   var error = { "message" : "Cannot PUT a whole collection" }
	   res.send(400, error);
   }
	
	});
});
    
app.delete('/:collection/:entity', function(req, res) {
    var params = req.params;
    var entity = params.entity;
    var collection = params.collection;
    if (entity) {
       collectionDriver.delete(collection, entity, function(error, objs) { 
          if (error) { res.status(400).send(error); }
          else { res.status(200).send(objs); } //200 b/c includes the original doc
       });
   } else {
       var error = { "message" : "Cannot DELETE a whole collection" }
       res.status(400).send(error);
   }
});

app.use(function (req,res) { 
    res.render('404', {url:req.url}); 
});

//web service that listens on port 3000 for incoming http requests
http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
