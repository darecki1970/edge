<?php

echo $_SERVER['SERVER_NAME'],"\n";

$link = mysql_connect('localhost', 'demo', 'demo')
    or die('Could not connect: ' . mysql_error());
echo 'Connected successfully';
mysql_select_db('demo');

$query = 'SELECT * FROM demo';
$result = mysql_query($query);

echo "<table>\n";
while ($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
    echo "\t<tr>\n";
    foreach ($line as $col_value) {
        echo "\t\t<td>$col_value</td>\n";
    }
    echo "\t</tr>\n";
}
echo "</table>\n";

mysql_free_result($result);
mysql_close($link);

?>
