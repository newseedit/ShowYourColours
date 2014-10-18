<?php

//phpinfo();

/*** mysql hostname ***/
$hostname = 'localhost';

/*** mysql username ***/
$username = 'root';

/*** mysql password ***/
$password = '';

try {
    $dbh = new PDO("mysql:host=127.0.0.1;dbname=synesthesia", $username, $password);
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

$data = array();

if (isset($resource)){
    if ($resource == 'hashtag'){
    	if (!empty($name)){
            if ($method == 'POST'){
                $sth = $dbh->prepare('INSERT INTO t_opinion (f_tag_id,f_time,f_op_text) VALUES (1,NOW(),?)');
                $sth->execute(array($_REQUEST['colour']));
                $json[$resource]['colour'] = hex2rgb($_REQUEST['colour']);

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
                array_push($data,$tmp);
            }
            */
        }
        else{
            /* fetch a list of hashtags */
            $sth = $dbh->prepare('CALL get_tags();');
            $sth->execute();
            $json[$resource]['name'] = $resource;
            while ($row = $sth->fetch()){
                array_push($data,$row['f_tag']);
            }
            $json[$resource]['data'] = $data;

        }
    }
}

$json['DEBUG']['SERVER'] = $_SERVER;
$json['DEBUG']['REQUEST'] = $_REQUEST;
$json['DEBUG']['PATH'] = $parts;


header('Content-Type: application/json');
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



