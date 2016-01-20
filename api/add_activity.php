 <?php

/*-------------------------------------------------------------------------------------------------------------------------------------------
*
*   add_account.php : TxRTS add account php script.
*
*	Inserts a record into the "activities" table
*
*	Params: user_id (string), accountID (string), activityID (string), type (int), dateCreated (timestamp), notes (string), inbound (boolean)
*
*	Returns a JSON blob indicating whether the operation was successful
*
*--------------------------------------------------------------------------------------------------------------------------------------------*/

function fixtags($text){
	$text = preg_replace("/Optional\(&quot;/","",$text);
	$text = preg_replace("/&quot;\)/","",$text);
	return $text;
}

// get values posted and remove extraneous characters

	$userID = htmlentities($_POST["userID"]);
	$userID = fixtags($userID);
	
	$activityID = htmlentities($_POST["activityID"]);
	$activityID = fixtags($activityID);
	
	$accountID = htmlentities($_POST["accountID"]);
	$accountID = fixtags($accountID);
	
	$type = htmlentities($_POST["type"]);
	$type = fixtags($type);
	
	$dateCreated = htmlentities($_POST["dateCreated"]);
	$dateCreated = fixtags($dateCreated);
	
	$notes = htmlentities($_POST["notes"]);
	$notes = fixtags($notes);
	
	$inbound = htmlentities($_POST["inbound"]);
	$inbound = fixtags($inbound);
	
	$activityArray = array(
							'userID' => $userID,
							'activityID' => $activityID,
							'accountID' => $accountID,
							'type' => $type,
							'dateCreated' => $dateCreated,
							'notes' => $notes,
							'inbound' => $inbound
	);


try {

		// connect
		$m = new MongoClient();
		
		// select a database
		$db = $m->test;

        // a new accounts and contact collection object
        $activityCollection = $db->activities;
        
        // insert the array
        $activityCollection->insert( $activityArray );
		
        echo 'Activity inserted with ID: ' . $activityArray['_id'] . "\n";

		$returnValue = "Success";
		echo json_encode($returnValue);
		
		session_write_close();
		ob_flush();
		flush();
	
	
		return $returnValue;
}
catch ( MongoConnectionException $e )
{
    // if there was an error, we catch and display the problem here
    echo $e->getMessage();
    	$returnValue = "fail 1";
	echo json_encode($returnValue);
			return $returnValue;

}
catch ( MongoException $e )
{
    echo $e->getMessage();
    	$returnValue = "fail 2";
	echo json_encode($returnValue);
			return $returnValue;

}

?>

