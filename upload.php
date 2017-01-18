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
  $user_email = $data['user_email'];
  $date = date("Y-m-d H:i:s");
  $json_parconfig = $data['json_parconfig'];
  $json_hash = md5($json_parconfig);
  $json_parvals = $data['json_parvals'];
  $learner_class = $data['learner_class'];

  $query = "INSERT INTO ".DB_PREFIX."parconfigs (user_email, date, json_parconfig, json_hash, json_parvals, learner_class) VALUES (?,?,?,?,?,?)";
  $stmt = $con->prepare($query);
  if (false===$stmt) {
    die('prepare() failed: ' . htmlspecialchars($con->error));
  }
  $stmt->bind_param("ssssss", $user_email, $date, $json_parconfig, $json_hash, $json_parvals, $learner_class);

  $stmt->execute();

  $stmt->close();

  //New ID
  $return['id'] = $con->insert_id;

  $con->close();

  header('Content-Type: application/json');
  echo json_encode($return);

} else {
  echo("No data recieved.");
}
?>