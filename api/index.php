<?php
	
$userID = "1";
$accountArray = array(
						'accountID' => '12',
						'companyName' => 'Sungard',
						'projectName' => 'ProjectPat',
						'isVIP' => true
);
$contactArray = array(
						'firstName' => 'Hunter',
						'lastName' => 'Houston',
						'email' => 'hmhouston7@gmail.com',
						'primaryPhone' => '7137038501',
						'secondaryPhone' => '7137038274'
);
	
// connect to mongodb
try {
        // Connect to MongoDB
        $conn = new MongoClient();

        // connect to test database
        $db = $conn->test;

        // a new accounts and contact collection object
        $accountCollection = $db->accounts;
		$contactCollection = $db->contacts;
        // insert the array
        $accountCollection->insert( $accountArray );
		$contactCollection->insert( $contactArray );
		
        echo 'Account inserted with ID: ' . $accountArray['_id'] . "<br>";
		echo 'Contact inserted with ID: ' . $contactArray['_id'] . "<br>";
		
        // close connection to MongoDB
        $conn->close();

}
catch ( MongoConnectionException $e )
{
        // if there was an error, we catch and display the problem here
        echo $e->getMessage();
}
catch ( MongoException $e )
{
        echo $e->getMessage();
}

/*
   $m = new MongoClient();
	
   echo "Connection to database successfully";
   // select a database
   $db = $m->test;
	
   echo "Database mydb selected";
   var_dump($db);
   
   echo "<br><br>";
*/
   // connect to mongodb
/*
   $connection = new MongoClient();
	
   echo "Connection to database successfully";
   
   // select a database
   $db = $connection->test;
   echo "Database local selected";

   $collection = $db->accounts;
   
   $new_task = array(
	  "task" => "do even more stuff",
	  "comment" => "this is the new task added"
	);
	
	$collection->update(
	  array("_id" => ObjectId("4d8653c027d02a6437bc89ca")), 
	  array('$push' => array("tasks" => $new_task))
	);
*/
	
	//$collection->insert( $doc );

   //var_dump("helllllo".$db);

/*
	$doc = array(
    "name" => "MongoDB",
    "type" => "database",
    "count" => 1,
    "info" => (object)array( "x" => 203, "y" => 102),
    "versions" => array("0.9.7", "0.9.8", "0.9.9")
);
*/
   //print_r($connection);

	//$collection->insert($doc);
   //echo "Database mydb selected";

?>