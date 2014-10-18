<?php

//phpinfo();

/*** mysql hostname ***/
$hostname = 'localhost';

/*** mysql username ***/
$username = 'root';

/*** mysql password ***/
$password = '';

try {
    $dbh = new PDO("mysql:host=127.0.0.1;dbname=mysql", $username, $password);
    /*** echo a message saying we have connected ***/
    /*
    echo 'Connected to database';
    $sth = $dbh->prepare("show databases");
    $sth->execute();
    $data = $sth->fetchAll();
    print_r($data);
    */
}
catch(PDOException $e){
    echo $e->getMessage();
    exit;
}


/**/


$json = array();

$json['DEBUG']['SERVER'] = $_SERVER;

if ($resource == 'hashtag'){
	
}

header('Content-Type: application/json');
print json_encode($json, JSON_PRETTY_PRINT);
