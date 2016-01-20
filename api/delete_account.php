 <?php

/*--------------------------------------------------------------------
*
*   delete_account.php : TxRTS add account php script.
	Deletes all data associated with the specified account
	
	Params: user_id (string), accountID (string)
	
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
	echo $userID;
	$accountID = htmlentities($_POST["accountID"]);
	$accountID = fixtags($accountID);
	echo $accountID;
try {

		// connect
		$connection = new MongoClient();
		
		// select a database
		$db = $connection->test;

        $accountCollection = $db->accounts;
		$contactCollection = $db->contacts;
		
        $accountQuery = array("userID"=>$userID);
        $accountRet = $accountCollection->remove($accountQuery);
        echo $accountRet['n']."documents deleted \n";
        var_dump($accountRet);
        
        $contactQuery = array("userID"=>$userID);
        $contactRet = $contactCollection->remove($contactQuery);
        echo $contactRet['n']."documents deleted \n";
        var_dump($contactRet);
        
        $connection->close();
        
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

