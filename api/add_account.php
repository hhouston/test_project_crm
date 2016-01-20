 <?php

/*--------------------------------------------------------------------
*
*   add_account.php : TxRTS add account php script.
    Creates an entry in the "accounts" and "contacts" tables

	Accepts the following params: user_id (string), account (JSON blob), contact (JSON blob)

	Returns a JSON blob indicating whether the operation was successful
	
	Object attributes:
	
	account
	 - accountID
	 - companyName
	 - projectName
	 - isVIP
	
	contact
	 - firstName
	 - lastName
	 - email
	 - phone
	 - phone

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
	
	$accountID = htmlentities($_POST["accountID"]);
	$accountID = fixtags($accountID);
	
	$companyName = htmlentities($_POST["companyName"]);
	$companyName = fixtags($companyName);
	
	$projectName = htmlentities($_POST["projectName"]);
	$projectName = fixtags($projectName);
	
	$isVIP = htmlentities($_POST["isVIP"]);
	$isVIP = fixtags($isVIP);
	
	$firstName = htmlentities($_POST["firstName"]);
	$firstName = fixtags($firstName);
	
	$lastName = htmlentities($_POST["lastName"]);
	$lastName = fixtags($lastName);
	
	$email = htmlentities($_POST["email"]);
	$email = fixtags($email);
	
	$phone = htmlentities($_POST["phone"]);
	$phone = fixtags($phone);
	
	$phone2 = htmlentities($_POST["phone2"]);
	$phone2 = fixtags($phone2);
	
	$accountArray = array(
							'userID' => $userID,
							'accountID' => $accountID,
							'companyName' => $companyName,
							'projectName' => $projectName,
							'isVIP' => $isVIP
	);

	$contactArray = array(
							'userID' => $userID,
							'firstName' => $firstName,
							'lastName' => $lastName,
							'email' => $email,
							'phone' => $phone,
							'phone2' => $phone2
	);

try {

		// connect
		$m = new MongoClient();
		
		// select a database
		$db = $m->test;

        // a new accounts and contact collection object
        $accountCollection = $db->accounts;
		$contactCollection = $db->contacts;
        // insert the array
        $accountCollection->insert( $accountArray );
		$contactCollection->insert( $contactArray );
		
        echo 'Account inserted with ID: ' . $accountArray['_id'] . "\n";
		echo 'Contact asdfadfinserted with ID: ' . $contactArray['_id'] . "\n";
		echo 'isVIP: ' . $accountArray['isVIP'] . "\n";


	$returnValue = "Success33";
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

