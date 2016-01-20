var ObjectID = require('mongodb').ObjectID;

CollectionDriver = function(db) {
  this.db = db;
};

CollectionDriver.prototype.getCollection = function(collectionName, callback) {
  this.db.collection(collectionName, function(error, the_collection) {
    if( error ) callback(error);
    else callback(null, the_collection);
  });
};

//find all objects for a collection
CollectionDriver.prototype.findAll = function(collectionName, callback) {
    this.getCollection(collectionName, function(error, the_collection) {
      if( error ) callback(error)
      else {
        the_collection.find().toArray(function(error, results) { 
          if( error ) callback(error)
          else callback(null, results)
        });
      }
    });
};

//find a specific object
CollectionDriver.prototype.get = function(collectionName, id, callback) { 
    this.getCollection(collectionName, function(error, the_collection) {
        if (error) callback(error)
        else {
            var checkForHexRegExp = new RegExp("^[0-9a-fA-F]{24}$"); 
            if (!checkForHexRegExp.test(id)) callback({error: "invalid id"});
            else the_collection.findOne({'_id':ObjectID(id)}, function(error,doc) { 
            	if (error) callback(error)
            	else callback(null, doc);
            });
        }
    });
}

//save new object
CollectionDriver.prototype.save = function(collectionName, obj, callback) {
    this.getCollection(collectionName, function(error, the_collection) { 
      if( error ) { 
	      	debugger;
	        console.log('save new object error: ' + error)
	        console.log('save new object the_collection: ' + the_collection)
	      callback(error)
      }
      else {
        //obj.created_at = new Date(); 
        the_collection.insert(obj, function() { 
          callback(null, obj);
        });
      }
    });
};

//update a specific object
CollectionDriver.prototype.update = function(collectionName, obj, entityId, callback) {
	debugger;
	console.log('collectionName input: ' + collectionName);
	    this.getCollection(collectionName, function(error, the_collection) {
        if (error) {
	        callback(error) 
	        console.log('update error: '+error)
	        console.log('the_collection: ' + the_collection)
        }
        else {
	        debugger;
	        console.log('mongoid'+entityId);
	        obj._id = ObjectID(entityId);
	        console.log('obj-id:' + obj._id);
	        //obj.updated_at = new Date(); 
            the_collection.save(obj, function(error,doc) { 
            	if (error){  
	            	callback(error)
	            	console.log('update error 2: '+error)

	            	}
            	else callback(null, doc);
            });
        }
    });
}

//Perform a collection query
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

//delete a specific object
CollectionDriver.prototype.delete = function(collectionName, entityId, callback) {
    this.getCollection(collectionName, function(error, the_collection) { 
        if (error) callback(error)
        else {
	        	debugger;
	        	console.log('delete by ' + entityId)
	        	//var mongo_id = db.collectionName.find({xcodeID: entityId}).toArray().map(function(u){return u._id; })
	            //console.log("mongo_id" + mongo_id)
	            //callback(mongo_id);
	            //console.log("mongo_id.id" + mongo_id.id)
				the_collection.remove({xcodeID : entityId}, function(error,doc) { 
            		if (error) callback(error)
					else callback(null, doc);
            	});
        }
    });
}
//Perform a user query
CollectionDriver.prototype.queryUser = function(collectionName, query, callback) { 
	debugger;
	console.log("queryUser called/");
	//console.log("this"+this.db.collection('users').find());
/*
	this.getCollection(collectionName, function(error, the_collection) { 
      if( error ) callback(error)
      else {
        the_collection.find(query).toArray(function(error, results) { 
          if( error ) callback(error)
          else callback(null, results)
        });
      }
    });
*/

/*
this.db.collection('users').aggregate([
	
	{ $match: { xcodeID : "hmhouston7" } },
	{$group: {_id:"$xcodeID", 
	:"$lastSync" } }
	
]);

*/
//this.db.collection('users').find({}, {"lastSync":1});
this.db.users.find({"xcodeID":"hmhouston7"}, {"lastSync":1})
//callback(null,this.db.users.find({}, {"lastSync":1}));
console.log(this.db.users.find({"xcodeID":"hmhouston7"}, {"lastSync":1}));
/*
	this.db.collection('users').find({"xcodeID":"hmhouston7"}, {"lastSync":1}, function(error, result) {
		if (error) callback(error)
		else { 
			console.log(result);
			callback (null, result);
		}
	});
*/


/*
	this.db.getUsers("hmhouston7",function(error, result) {
		if (error) callback(error)
		else callback(null, doc);
	});
*/
/*
    this.db.getUser(query).toArray(function(error, results) { 
        if( error ) callback(error)
        else callback(null, results)
    });
*/
};

exports.CollectionDriver = CollectionDriver;