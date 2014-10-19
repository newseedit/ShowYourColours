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
$subentity = $parts[3];

$data = array();

if (isset($resource)){
    if ($resource == 'colour'){
        $sth = $dbh->prepare("CALL get_opinions(NULL,1,NULL,NULL,NULL,NULL,NULL,NULL);");
        $sth->execute(array($name));
        while ($row = $sth->fetch()){
            $tmp = array();
            $tmp['tag'] = $row['f_tag'];
            $tmp['lat'] = $row['f_lat'];
            $tmp['lon'] = $row['f_long'];
            $tmp['r'] = $row['f_op_red'];
            $tmp['g'] = $row['f_op_green'];
            $tmp['b'] = $row['f_op_blue'];
            $tmp['count'] = $row['countnum'];
            array_push($data,$tmp);
        }
        $json[$resource]['data'] = $data;
    }
    if ($resource == 'hashtag'){
    	if (!empty($name)){
            if ($method == 'POST'){
                if (!empty($subentity)){
                    try {
                        $sth = $dbh->prepare('CALL insert_opinion(NULL, ?, ?, ?, ?, ?, ?);');
                        $sth->execute(array($name, $lat, $lon, $rgb[0], $rgb[1], $rgb[2]));
                    }
                    catch(PDOException $e){
                        echo $e->getMessage();
                        exit;
                    }
                }
                else{
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
            }
            else{
                $sth = $dbh->prepare("CALL get_opinions(?,1,NULL,NULL,NULL,NULL,NULL,NULL);");
                $sth->execute(array($name));
                while ($row = $sth->fetch()){
                    $tmp = array();
                    $tmp['tag'] = $row['f_tag'];
                    $tmp['lat'] = $row['f_lat'];
                    $tmp['lon'] = $row['f_long'];
                    $tmp['r'] = $row['f_op_red'];
                    $tmp['g'] = $row['f_op_green'];
                    $tmp['b'] = $row['f_op_blue'];
                    $tmp['count'] = $row['countnum'];
                    array_push($data,$tmp);
                }
                $json[$resource]['data'] = $data;
                $json[$resource]['data'] = $data;
            }
        }
        else{
            /* fetch a list of hashtags */
            if (!empty($_REQUEST['partial'])){
                $sth = $dbh->prepare('CALL get_tags(?);');
                $sth->execute(array($_REQUEST['partial']));
            }
            else{
                $sth = $dbh->prepare("CALL get_tags('');");
                $sth->execute();
            }
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



