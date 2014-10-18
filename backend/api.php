<?php

define(DEBUG,true);

/*** mysql hostname ***/
$hostname = '10.12.75.94';

/*** mysql username ***/
$username = 'synesthesia';

/*** mysql password ***/
$password = 'synes';

try {
    $dbh = new PDO("mysql:host=$hostname;dbname=synesthesia", $username, $password);
}
catch(PDOException $e){
    echo $e->getMessage();
    exit;
}

/* object to build up return info in */
$json = array();

/* figure out the request */
$path = $_SERVER['REDIRECT_URL'];
$method = $_SERVER['REQUEST_METHOD'];
$parts = explode("/",$path);
$resource = $parts[1];
$name = $parts[2];

$data = array();

if (isset($resource)){
    if ($resource == 'hashtag'){
    	if (!empty($name)){
            if ($method == 'POST'){
                $rgb = hex2rgb($_REQUEST['colour']);
                $lat = $_REQUEST['lat'];
                $lon = $_REQUEST['lon'];
                try {
                    $sth = $dbh->prepare('CALL insert_opinion(NULL, ?, ?, ?, ?, ?, ?);');
                    $sth->execute(array($name, $lat, $lon, $rgb[0], $rgb[1], $rgb[2]));
                }
                catch(PDOException $e){
                    echo $e->getMessage();
                    exit;
                }
                $json[$resource]['colour'] = $rgb;
            }
            $json[$resource]['name'] = $name;
            $json[$resource]['data'] = [];
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
                array_push($data,$tmp);
            }
            */
            $json[$resource]['data'] = $data;
        }
        else{
            /* fetch a list of hashtags */
            $sth = $dbh->prepare('CALL get_tags(?);');
            $sth->execute(array($_REQUEST['partial']));
            while ($row = $sth->fetch()){
                array_push($data,$row['f_tag']);
            }
            $json[$resource] = $data;

        }
    }
}

if (DEBUG){
    $json['DEBUG']['SERVER'] = $_SERVER;
    $json['DEBUG']['REQUEST'] = $_REQUEST;
    $json['DEBUG']['PATH'] = $parts;
}

header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
print json_encode($json, JSON_PRETTY_PRINT);
exit;


function hex2rgb($hex){
   if(strlen($hex) == 3) {
      $r = hexdec(substr($hex,0,1).substr($hex,0,1));
      $g = hexdec(substr($hex,1,1).substr($hex,1,1));
      $b = hexdec(substr($hex,2,1).substr($hex,2,1));
   } else {
      $r = hexdec(substr($hex,0,2));
      $g = hexdec(substr($hex,2,2));
      $b = hexdec(substr($hex,4,2));
   } 
   return array($r,$g,$b);
}



