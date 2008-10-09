<html>
<head>

<title>Kopfgeld NPC</title>
<center><table>

<tr><td colspan=2 align=center>

<body>

<body bgcolor="#000000" text="#FFFFFF">


<?php


$hunted=$_POST["hunted"];
$character=$_POST["character"];
$hours=$_POST["hours"];

// Info zum Connecten WICHTIG!!
$username="root"; //MySQL Benutzername
$pass="8itche0e78"; //Passwort für MYSQL
$database="funtastic_world"; //Datenbank die die Bounty Hunter tabelle enthält
$accountdb="login"; //Datenbank die acc Infos enthält
$chardb="funtastic_chars"; //Datenbank die Char Infos enthält
$Host="localhost"; //Host der Datenbanken z.B. 127.0.0.1
$Port="3306"; //Verbindungs Port



if(isset($_POST['submit']))
{
//players account name, password and character name
$account = $_POST['account'];
$password = $_POST['password'];
$character = $_POST['character'];
$hunted = $_POST['hunted'];
$cost1 = $_POST['price'];
$cost = $cost1*10000;

?>
<h2><?php echo $_POST["character"]; ?> hat ein Kopfgeld auf <?php echo $_POST["hunted"]; ?> ausgesetzt, in höhe von <?php echo $cost1; ?> gold.</h2>
<?


//Connect to character database
$con = mysql_connect($Host.":".$Port, $username, $pass) or die(mysql_error());
mysql_select_db($chardb) or die(mysql_error());

//Remove bullshit characters from user entered data
$character = mysql_real_escape_string(html_entity_decode(htmlentities($character)));

//Get acct id
$query = "SELECT acct FROM characters WHERE name = '".$character."'";

$result = mysql_query($query) or die(mysql_error());
$numrows = mysql_num_rows($result);

echo "<tr><td align=center>";

//if no rows exist, the character does not exist
if($numrows == 0)
{
die("No such character exists on that account!");
}

$row = mysql_fetch_array($result);
$acct = $row[0];

mysql_close();

//Connect to accounts database
$con = mysql_connect($Host.":".$Port, $username, $pass) or die(mysql_error());
mysql_select_db($accountdb) or die(mysql_error());

//Remove bullshit characters from user entered data
$account = mysql_real_escape_string(html_entity_decode(htmlentities($account)));
$password = mysql_real_escape_string(html_entity_decode(htmlentities($password)));

$query = "SELECT login, acct, password FROM accounts WHERE login ='".$account."' AND password = '".$password."' AND acct = '".$acct."'";

$result = mysql_query($query) or die(mysql_error());
$numrows = mysql_num_rows($result);

//if no rows, user entered invalid data
if ($numrows == 0)
{
die("Account name or password is incorrect!");
}


mysql_close();


echo "</td></tr>";
}







/*

This is where we will get info about the player putting a bounty on someone's character.
This is also where we will find out some info about the player about to be hunted.
*/


//players account name, password and character name
$account = $_POST['account'];
$password = $_POST['password'];
$character = $_POST['character'];
$hunted = $_POST['hunted'];
$cost1 = $_POST['price'];
$cost = $cost1*10000;

//Connect to character database
$con = mysql_connect($Host.":".$Port, $username, $pass) or die(mysql_error());
mysql_select_db($chardb) or die(mysql_error());

//Gathering Info on the person placing the bounty.
$query="select guid,acct from characters where name like '".$character."'";
$result=mysql_query($query);
$num=mysql_numrows($result);

mysql_close();

$i=0;
while ($i < $num) {

$Eguid=mysql_result($result,$i,"guid");
$Eacct=mysql_result($result,$i,"acct");
$i++;
}


//Connect to character database
$con = mysql_connect($Host.":".$Port, $username, $pass) or die(mysql_error());
mysql_select_db($chardb) or die(mysql_error());

//Gathering info about the target
$query="select guid,name,level,acct from characters where name like '".$hunted."'";
$result=mysql_query($query);
$num=mysql_numrows($result);

mysql_close();

$i=0;
while ($i < $num) {

$Hguid=mysql_result($result,$i,"guid");
$Hname=mysql_result($result,$i,"name");
$Hlevel=mysql_result($result,$i,"level");
$Hacct=mysql_result($result,$i,"acct");
$i++;
}


/*
This is where we are inserting the bounty into the database.
First though, we have to check if the same bounty is in the database.
*/

//Connect to character database
$con = mysql_connect($Host.":".$Port, $username, $pass) or die(mysql_error());
mysql_select_db($database) or die(mysql_error());

//Inserting the job into the database
$query=("INSERT INTO bountyhunter (client, target, bounty)
VALUES
('$Eguid','$Hguid','$cost')");
$result=mysql_query($query);

//mysql_query($query) or die(mysql_error());
mysql_close();


/*
Updating the player's gold that is purchasing the bounty.
*/

//Connect to character database
$con = mysql_connect($Host.":".$Port, $username, $pass) or die(mysql_error());
mysql_select_db($chardb) or die(mysql_error());

mysql_query("UPDATE characters SET gold = (gold -'$cost')
WHERE name like '$character'");
//$result=mysql_query($query);
//mysql_query($query) or die(mysql_error());

mysql_close();

?>