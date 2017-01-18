<?php
include("conf.php");
?>
<!DOCTYPE html>
<html>
<head>
  <title>mlrHyper Status Page</title>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script type="text/javascript" src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css">
  <script type="text/javascript" class = "init">
  $(document).ready(function() {
    $('#parconfigs').DataTable( {
        "processing": true,
        "serverSide": true,
        "ajax": "data_table_parconfigs.php"
    } );
} );
  </script>
</head>
<body>
<?php
echo '<h1>Status</h1>';
echo '<p>Server running with PHP Version ' . phpversion() . '</p>';

echo '<p>MySql: ';
$mysqli = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

if ($mysqli->connect_error) {
    die('Connect Error (' . $mysqli->connect_errno . ') '
            . $mysqli->connect_error);
}
echo 'Success... ' . $mysqli->host_info . "\n";
echo '</p>';
echo '<h2>Table '.DB_PREFIX.'parconfigs</h2>';
?>
<table id="parconfigs" class="display" cellspacing="0" width="100%">
  <thead>
    <tr>
      <th>id</th>
      <th>learner_class</th>
      <th>json_parconfig</th>
      <th>json_parvals</th>
      <th>upload_count</th>
      <th>download_count</th>
    </tr>
  </thead>
  <tfoot>
    <tr>
      <th>id</th>
      <th>learner_class</th>
      <th>json_parconfig</th>
      <th>json_parvals</th>
      <th>upload_count</th>
      <th>download_count</th>
    </tr>
  </tfoot>
</table>
</body>
</html>