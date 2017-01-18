<?php
// Recieve JSON an push it to MySQL DB
if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
  //connect to DB
  include('conf.php');
  $con = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

  if (mysqli_connect_errno()) {
    die('Connect Error (' . mysqli_connect_errno() . ') ' . mysqli_connect_error());
  }

  //parse JSON
  $json_data = file_get_contents("php://input");
  $data = json_decode($json_data, true);
  //get the details
  $ids = $data['ids'];
  //generates helper for prepare
  $clause = implode(', ', array_fill(0, count($ids), '?'));
  $query = "SELECT ID, json_parconfig, json_parvals, learner_class FROM ".DB_PREFIX."parconfigs WHERE ID in (".$clause.")";
  $stmt = $con->prepare($query);
  if (false===$stmt) {
    die('prepare() failed: ' . htmlspecialchars($con->error));
  }
  call_user_func_array(array($stmt, 'bind_param'), $ids);
  $stmt->execute();
  $rows = array();
  while(($row = $stmt->fetch_array(MYSQLI_ASSOC))) {
    $rows[] = $row;
  }
  $stmt->close();
  $con->close();

  header('Content-Type: application/json');
  echo json_encode($rows);

} else {
  echo("No IDs to townload recieved.");
}
?>