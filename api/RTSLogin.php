<?php

/*--------------------------------------------------------------------
*
*   RTSLogin.php : TxRTS Login php script.
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

// hard-wire email "jbb" for testing only....

//$email = "jbb";
//$password = "2345";

// get values posted and remove extraneous characters

$email = htmlentities($_POST["email"]);
$email = fixtags($email);

$password = htmlentities($_POST["password"]);
$password = fixtags($password);

$returnValue = array();
//hey
// connect
$m = new MongoClient();

// select a database
$db = $m->RTSRegistrations;

// select a collection (analogous to a relational database's table)
$collection = $db->Registrations;

$user = array ("email" => "$email" );
//$user = array ("email" => "$email" , "password" => "$password" );

$userDetails=$collection->find( $user );

// iterate through the results
$registered="false";
foreach ($userDetails as $document) {
    //Xecho $document["email"] . "\n";
    if ($document["email"] == $email)
        {
                if ($document["password"] == $password)
                {
                        //Xecho "registered";
                        $registered="true";
                        // Registered - allow Login
                        $returnValue["status"] = "Success";
                        $returnValue["message"] = "User Logged-in";
                }
                else
                {
                        $registered="wrongPW";
                        $returnValue["status"] = "Error";
                        $returnValue["message"] = "User $email wrong password";
                }
        }
        else
        {
                //Xecho "not registered";
                $registered="false";
                $returnValue["status"] = "Error";
                $returnValue["message"] = "User $email not registered";
        }
}

if ($registered == "false")
{
// Not Registered
//Xecho "Not registered" . "\n";
        $returnValue["status"] = "Error";
        $returnValue["message"] = "User $email not registered";
}

        $returnValue["email"] = $email;
        $returnValue["password"] = $password;



//echo $returnValue;

echo json_encode($returnValue);

session_write_close();
ob_flush();
flush();


return;


?>

