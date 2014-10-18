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


/* object to build up return info in */
$json = array();

/* figure out the request */
$path = $_SERVER['REQUEST_URI'];
$method = $_SERVER['REQUEST_METHOD'];
$parts = explode("/",$path);
$resource = $parts[2];
$name = $parts[3];
$zoom = $parts[4];
$date = $parts[5];

if (!defined($zoom)){
    // zoom 1 = max zoom, Earth level
    $zoom = 1;
}
if (!defined($date)){
    // NULL date is OK, get all data for now
}

$colour = array();

if (isset($resource)){
    if ($resource == 'hashtag'){
    	if (isset($name)){
            if ($method == 'PUT'){

            }
            $json[$resource]['name'] = $name;
            $json[$resource]['data'] = [];
            $json[$resource]['method'] = $method;
            /* TODO: 
            $sth = $dbh->prepare("functioncall ?");
            $sth->execute($name,$zoom);
            while ($row = $sth->fetch()){
                $tmp = array();
                $tmp['tag'] = $row['f_'];
                $tmp['lat'] = $row['f_'];
                $tmp['lon'] = $row['f_'];
                $tmp['time'] = $row['f_'];
                $tmp['r'] = $row['f_'];
                $tmp['g'] = $row['f_'];
                $tmp['b'] = $row['f_'];
            }
            */
        }
    }
}

$json['DEBUG']['SERVER'] = $_SERVER;
$json['DEBUG']['REQUEST'] = $_REQUEST;
$json['DEBUG']['PATH'] = $parts;


header('Content-Type: application/json');
print json_encode($json, JSON_PRETTY_PRINT);
