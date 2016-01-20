<?php
	/*   
	 *	fetch_accounts.php : TxRTS fetch accounts php script.
	 *	
	 *	Accepts the following params: user_id (string)
     *
	 *	Returns a JSON blob with the account object(s)
 	 */
 	 
 	 function fixtags($text){
 	 	$text = preg_replace("/Optional\(&quot;/","",$text);
 	 	$text = preg_replace("/&quot;\)/","",$text);
 	 	return $text;
	 }


/*----------------------------------------------------------------------*/


// get values posted and remove extraneous characters

	$userID = htmlentities($_POST["userID"]);
	$userID = fixtags($userID);
	
try {
    // a new MongoDB connection
    $conn = new MongoClient();

    // connect to test database
    $db = $conn->test;

    // a new products collection object
    $collection = $db->accounts;

    // fetch all product documents
    $cursor = $collection->find(array('userID' => $userID));

    // How many results found
    $num_docs = $cursor->count();

    if( $num_docs > 0 )
    {
        // loop over the results
        foreach ($cursor as $obj)
        {
            echo '_id: ' . $obj['_id'] . "\n";
            echo 'user ID: ' . $obj['userID'] . "\n";
            echo 'company Name: ' . $obj['companyName'] . "\n";
            echo 'project name: ' . $obj['projectName'] . "\n";
            echo 'isVIP: ' . $obj['isVIP'] . "\n";
            echo "\n";
        }
        
        $returnValue = "Success";
		echo json_encode($returnValue);
    }
    else
    {
        // if no accounts are found, we show this message
        $returnValue = "fail 1";
		echo json_encode($returnValue);
    }

    // close the connection to MongoDB 
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
?>