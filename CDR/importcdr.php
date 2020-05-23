<?php
header('Content-Type: text/html; charset=utf-8');
setLocale(LC_ALL,'ru_RU.UTF-8');
 
$locale_db_host = 'localhost';
$locale_db_name = 'asterisk';
$locale_db_login = 'asterisk_user';
$locale_db_pass = 'asterisk_password';
if($argc == 2) {
    $logfile = $argv[1];
} else {
    exit(0);
}

$linkmb = mysql_connect($locale_db_host, $locale_db_login, $locale_db_pass) or die("Could not connect : " . mysql_error());
mysql_select_db($locale_db_name, $linkmb) or die("Could not select database $locale_db_name");

mysql_query("SET NAMES 'utf8'");
mysql_query("SET CHARACTER SET 'utf8'");

$rows = 0;
$handle = fopen($logfile, "r");
while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
    list($accountcode,$src, $dst, $dcontext, $clid, $channel, $dstchannel, $lastapp, $lastdata, $start, $answer, $end, $duration, $billsec, $disposition, $amaflags, $uniqueid, $userfield ) = $data;
    $sql = "INSERT INTO cdr (calldate, answerdate, hangupdate, clid, src, dst, dcontext, channel, dstchannel, lastapp, lastdata, duration, billsec, disposition, amaflags, accountcode, uniqueid, userfield)
    VALUES('$start', '$answer', '$end', '".mysql_real_escape_string($clid)."', '$src', '$dst', '$dcontext', '$channel', '$dstchannel', '$lastapp', '$lastdata', '$duration', '$billsec', '$disposition', '$amaflags', '$accountcode', '$uniqueid', '$userfield')";
    if(!($result2 = mysql_query($sql, $linkmb))) {
        continue;
    }
    $rows++;
}
fclose($handle);

?>
