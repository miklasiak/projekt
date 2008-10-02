
<html>
<head>


<title>Kopfgeld Jäger</title>
<center><table>


<tr><td colspan=2 align=center>

<body>
<body bgcolor="#000000" text="#FFFFFF">
<h1>Willkommen auf der Kopfgeld Jäger Seite.</h1>
<h1>Benutzen auf eigene Gefahr!</h1>
<h2>Du musst dich einlogen um ein Kopfgeld auszusetzen.</h2>
<h2>Füll die entsprechenden Infomationen aus.</h2>
<h2>Du musst dich erst aus dem Spiel ausloggen damit der Kopfgeld Jäger funktuniert</h2>

<?php

echo "<form name=myform method=post action='BH_Results.php'>";
echo "<tr><td colspan=2 align=center><font size=6>Infos hier einfügen.</td></tr>";
echo "<tr><td width=125>Account: </td><td><input type=text name=account value=''></td></tr>";
echo "<tr><td width=125>Dein Charaktername: </td><td><input type=text name=character value=''></td></tr>";
echo "<tr><td width=125>Passwort: </td><td><input type=password name=password value=''></td></tr>";
echo "<tr><td></td></tr>";
echo "<tr><td colspan=2 align=center><font size=6>Füge nun das Ziel des Kopfgelds ein.</td></tr>";
echo "<tr><td width=125>Ziel(Player) </td><td><input type=text name=hunted value=''></td></tr>";
echo "<tr><td width=125>Belohnung </td><td><input type=text name=price value=''> In Gold: eg. 200 gold</td></tr>";
echo "<tr><td colspan=2 align=center><br><input type=submit name=submit value='Kopfgeld aussetzen'></td></tr>";
echo "</form>";

?>

<table border="1" cellspacing="4" cellpadding="4">
<tr>
<th><font face="Arial, Helvetica, sans-serif">Name</font></th>
<th><font face="Arial, Helvetica, sans-serif">Race</font></th>
<th><font face="Arial, Helvetica, sans-serif">Class</font></th>
<th><font face="Arial, Helvetica, sans-serif">Level</font></th>
</tr>

<h2>Player auf die man ein Kopfgeld aussetzen kann!<h2>
<?

/*////////////////////////////////////////////////////////////////////////
// Info um zu der Datenbank zu verbinden!  EDITIEREN!!!
////////////////////////////////////////////////////////////////////////*/
$username="root"; //Benutzername für MYSQL
$pass="8itche0e78"; //Passwort für MYSQL
$database="funtastic_world"; //Datenbank die die BountyHunter Tabelle enthält
$accountdb="login"; //Account Datenbank
$chardb="funtastic_chars"; //Charakter Datenbank 
$Host="localhost"; //Host der Datenbank
$Port="3306"; //Port um Verbindung zur Datenbank zu erstellen


////////////////////////////////////////////////////////////////////////
// YOU SHOULDN'T HAVE TO EDIT BELOW THIS LINE.
////////////////////////////////////////////////////////////////////////

//Connect to character database
$con = mysql_connect($Host.":".$Port, $username, $pass) or die(mysql_error());
mysql_select_db($chardb) or die(mysql_error());

$query="SELECT guid,name,race,class,gender,level FROM characters where (level) >= 10 ORDER BY level DESC";
$result=mysql_query($query);
$num=mysql_numrows($result);

mysql_close();

$i=0;
while ($i < $num) {

$guid=mysql_result($result,$i,"guid");
$name=mysql_result($result,$i,"name");
$race=mysql_result($result,$i,"race");
$class=mysql_result($result,$i,"class");
$level=mysql_result($result,$i,"level");

// Checking Race
if($race==1)
$race2="Mensch";
if($race==2)
$race2="Orc";
if($race==3)
$race2="Zwerg";
if($race==4)
$race2="Nachtelf";
if($race==5)
$race2="Untoter";
if($race==6)
$race2="Taure";
if($race==7)
$race2="Gnom";
if($race==8)
$race2="Troll";
if($race==10)
$race2="Blutelf";
if($race==11)
$race2="Draenei";

//Checking Class
if($class==1)
$class2="Krieger";
if($class==2)
$class2="Paladin";
if($class==3)
$class2="Jäger";
if($class==4)
$class2="Schurke";
if($class==5)
$class2="Priester";
if($class==7)
$class2="Shamane";
if($class==8)
$class2="Magier";
if($class==9)
$class2="Hexenmeister";
if($class==11)
$class2="Druide";

?>

<tr>
<td><font face="Arial, Helvetica, sans-serif"><? echo $name; ?></font></td>
<td><font face="Arial, Helvetica, sans-serif"><? echo $race2; ?></font></td>
<td><font face="Arial, Helvetica, sans-serif"><? echo $class2; ?></font></td>
<td><font face="Arial, Helvetica, sans-serif"><? echo $level; ?></font></td>
</tr>

<?
$i++;
}


?>

</body>
</head>
</html>