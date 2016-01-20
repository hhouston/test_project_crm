 <?php

/*--------------------------------------------------------------------
*
*   delete_activity.php : TxRTS delete activity php script.
	Deletes the specified record from the "activities" table

	Params: user_id (string), activityID (string)
	
	Returns a JSON blob indicating whether the operation was successful


*
*
*---------------------------------------------------------------------*/

//require("RTS_mongoDB_connect.php");

function fixtags($text){
	$text = preg_replace("/Optional\(&quot;/","",$text);
	$text = preg_replace("/&quot;\)/","",$text);
	return $text;
}


/*----------------------------------------------------------------------*/


// get values posted and remove extraneous characters

	$userID = htmlentities($_POST["userID"]);
	$userID = fixtags($userID);
	
	$activityID = htmlentities($_POST["activityID"]);
	$activityID = fixtags($activityID);

try {

		// connect
		$m = new MongoClient();
		
		// select a database
		$db = $m->test;

        $activityCollection = $db->activities;
		
        $activityQuery = array("activityID"=>$activityID);
        $activityRet = $activityCollection->remove($activityQuery);
        var_dump($activityRet);
           
    	$returnValue = "Success";
		echo json_encode($returnValue);
		session_write_close();
		ob_flush();
		flush();


	return;
}
catch ( MongoConnectionException $e )
{
    // if there was an error, we catch and display the problem here
    echo $e->getMessage();
    	$returnValue = "fail 1";
	echo json_encode($returnValue);
}
catch ( MongoException $e )
{
    echo $e->getMessage();
    	$returnValue = "fail 2";
	echo json_encode($returnValue);
}

?>

