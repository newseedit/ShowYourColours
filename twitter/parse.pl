#!/usr/bin/perl

$i = 0;

@our_colours = ("393b79", "5254a3", "6b6ecf", "9c9ede", "637939", "8ca252", "b5cf6b", "cedb9c", "8c6d31", "bd9e39", "e7ba52", "e7cb94", "843c39", "ad494a", "d6616b", "e7969c", "7b4173", "a55194", "ce6dbd", "de9ed6");
@colours = qw(Black 
Navy 
DarkBlue 
MediumBlue 
Blue 
DarkGreen 
Green 
Teal 
DarkCyan 
DeepSkyBlue 
DarkTurquoise 
MediumSpringGreen 
Lime 
SpringGreen 
Aqua 
Cyan 
MidnightBlue 
DodgerBlue 
LightSeaGreen 
ForestGreen 
SeaGreen 
DarkSlateGray 
LimeGreen 
MediumSeaGreen 
Turquoise 
RoyalBlue 
SteelBlue 
DarkSlateBlue 
MediumTurquoise 
Indigo  
DarkOliveGreen 
CadetBlue 
CornflowerBlue 
MediumAquaMarine 
DimGray 
SlateBlue 
OliveDrab 
SlateGray 
LightSlateGray 
MediumSlateBlue 
LawnGreen 
Chartreuse 
Aquamarine 
Maroon 
Purple 
Olive 
Gray 
SkyBlue 
LightSkyBlue 
BlueViolet 
DarkRed 
DarkMagenta 
SaddleBrown 
DarkSeaGreen 
LightGreen 
MediumPurple 
DarkViolet 
PaleGreen 
DarkOrchid 
YellowGreen 
Sienna 
Brown 
DarkGray 
LightBlue 
GreenYellow 
PaleTurquoise 
LightSteelBlue 
PowderBlue 
FireBrick 
DarkGoldenRod 
MediumOrchid 
RosyBrown 
DarkKhaki 
Silver 
MediumVioletRed 
IndianRed  
Peru 
Chocolate 
Tan 
LightGray 
Thistle 
Orchid 
GoldenRod 
PaleVioletRed 
Crimson 
Gainsboro 
Plum 
BurlyWood 
LightCyan 
Lavender 
DarkSalmon 
Violet 
PaleGoldenRod 
LightCoral 
Khaki 
AliceBlue 
HoneyDew 
Azure 
SandyBrown 
Wheat 
Beige 
WhiteSmoke 
MintCream 
GhostWhite 
Salmon 
AntiqueWhite 
Linen 
LightGoldenRodYellow 
OldLace 
Red 
Fuchsia 
Magenta 
DeepPink 
OrangeRed 
Tomato 
HotPink 
Coral 
DarkOrange 
LightSalmon 
Orange 
LightPink 
Pink 
Gold 
PeachPuff 
NavajoWhite 
Moccasin 
Bisque 
MistyRose 
BlanchedAlmond 
PapayaWhip 
LavenderBlush 
SeaShell 
Cornsilk 
LemonChiffon 
FloralWhite 
Snow 
Yellow 
LightYellow 
Ivory 
White );
@ccolour = qw(#000000
#000080
#00008B
#0000CD
#0000FF
#006400
#008000
#008080
#008B8B
#00BFFF
#00CED1
#00FA9A
#00FF00
#00FF7F
#00FFFF
#00FFFF
#191970
#1E90FF
#20B2AA
#228B22
#2E8B57
#2F4F4F
#32CD32
#3CB371
#40E0D0
#4169E1
#4682B4
#483D8B
#48D1CC
#4B0082
#556B2F
#5F9EA0
#6495ED
#66CDAA
#696969
#6A5ACD
#6B8E23
#708090
#778899
#7B68EE
#7CFC00
#7FFF00
#7FFFD4
#800000
#800080
#808000
#808080
#87CEEB
#87CEFA
#8A2BE2
#8B0000
#8B008B
#8B4513
#8FBC8F
#90EE90
#9370DB
#9400D3
#98FB98
#9932CC
#9ACD32
#A0522D
#A52A2A
#A9A9A9
#ADD8E6
#ADFF2F
#AFEEEE
#B0C4DE
#B0E0E6
#B22222
#B8860B
#BA55D3
#BC8F8F
#BDB76B
#C0C0C0
#C71585
#CD5C5C
#CD853F
#D2691E
#D2B48C
#D3D3D3
#D8BFD8
#DA70D6
#DAA520
#DB7093
#DC143C
#DCDCDC
#DDA0DD
#DEB887
#E0FFFF
#E6E6FA
#E9967A
#EE82EE
#EEE8AA
#F08080
#F0E68C
#F0F8FF
#F0FFF0
#F0FFFF
#F4A460
#F5DEB3
#F5F5DC
#F5F5F5
#F5FFFA
#F8F8FF
#FA8072
#FAEBD7
#FAF0E6
#FAFAD2
#FDF5E6
#FF0000
#FF00FF
#FF00FF
#FF1493
#FF4500
#FF6347
#FF69B4
#FF7F50
#FF8C00
#FFA07A
#FFA500
#FFB6C1
#FFC0CB
#FFD700
#FFDAB9
#FFDEAD
#FFE4B5
#FFE4C4
#FFE4E1
#FFEBCD
#FFEFD5
#FFF0F5
#FFF5EE
#FFF8DC
#FFFACD
#FFFAF0
#FFFAFA
#FFFF00
#FFFFE0
#FFFFF0
#FFFFFF);
@hashtags = ("ebola","doctorswithoutborders","Arsenal","Arsenal","Chelsea","Mood","GoodMorning");
@hashcol  = ("000000","ff0000","ff0000","ffffff","0019D6",undef,undef);

open(OUTPUT,">dirty.sql");

for ($s=1;$s<14;$s++){
	open(JSON,"sample".$s.".json");
	while ($data = <JSON>){
		if ($data =~ /^\{"delete/){
			next;
		}
		if ($data =~ /"coordinates":\[([^,]*)\,([^\]]*)\]/ ){
			$lon = $2;
			$lat = $1;
			if ($lat =~ s/\[//g){
				next;
			}
			$hashtag = "";
			if ($data =~ /\#(\w+)/i){
				$hashtag = $1;
			}
			$c = 1;
			$colour = "";
			foreach $tmp (@colours){
				if ($data =~ /$tmp/i){
					$colour = $ccolours[$c];
					last;
				}
				$c++;
			}
			if (!$hashtag){
				$rpos = rand @hashtags;
	 			$hashtag = $hashtags[$rpos];
	 			$colour = $hashcol[$rpos];
			}
			if (!$colour){
	 			$colour = $our_colours[rand @our_colours];
			}
			if ($colour){
				@rgb = hex2rgb($colour);
				print $lon."x".$lat;
				print " H: ".$hashtag;
				print " C: ".$rgb[0];
				print "\n";
				print OUTPUT "CALL insert_opinion(123,'$hashtag',$lat,$lon,$rgb[0],$rgb[1],$rgb[2]);\n";
				$i++;
			}
			#exit;
		}
		#exit;
	}
	close(JSON);
}
print $i."\n";
close(OUTPUT);


sub hex2rgb{
	my $hex = shift;
   	if(length($hex) == 3) {
		$r = hex(substr($hex,0,1).substr($hex,0,1));
		$g = hex(substr($hex,1,1).substr($hex,1,1));
		$b = hex(substr($hex,2,1).substr($hex,2,1));
   	} else {
		$r = hex(substr($hex,0,2));
		$g = hex(substr($hex,2,2));
		$b = hex(substr($hex,4,2));
   	} 
   	return ($r,$g,$b);
}


