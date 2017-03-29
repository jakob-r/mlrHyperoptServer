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
  if (is_array($data['ids'])) {
    $ids = $data['ids'];
  } else {
    $ids = array($data['ids']);
  }
  //generates helper for prepare
  $query = "SELECT json_parconfig, json_parvals, learner_class, learner_type, learner_name FROM ".DB_PREFIX."parconfigs WHERE ID=? LIMIT 1";
  $stmt = $con->prepare($query);
  if (false===$stmt) {
    die('prepare() failed: ' . htmlspecialchars($con->error));
  }
  $rows = array();
  foreach ($ids as $id) {
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $stmt->bind_result($json_parconfig, $json_parvals, $learner_class, $learner_type, $learner_name);
    $stmt->fetch();
    $rows[] = array(
      "json_parconfig" => $json_parconfig,
      "json_parvals" => $json_parvals,
      "learner_class" => $learner_class,
      "learner_type" => $learner_type,
      "learner_name" => $learner_name
      );
  }
  $stmt->close();

  //update the download count
  $query2 = "UPDATE ".DB_PREFIX."parconfigs SET download_count = download_count + 1 WHERE ID=?";
  $stmt2 = $con->prepare($query2);
  foreach ($ids as $id) {
    $stmt2->bind_param("i", $id);
    $stmt2->execute();
    if ($stmt2->errno) {
      echo "execute() failed" . $stmt2->error;
    }
  }
  $stmt2->close();

  $con->close();
  header('Content-Type: application/json');
  echo json_encode($rows);
} else {
  echo("No IDs to townload recieved.");
}

?>