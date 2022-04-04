<?php
include '../environment.php';
$servername = getenv("DATABASE_SERVER");
$username = getenv("DATABASE_USERNAME");
$password = getenv("DATABASE_PASSWORD");
$dbname = getenv("DATABASE_SCHEMA");

$passphrase = 'demo';

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT ID FROM board WHERE password = '$passphrase';";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $value = "";
    while ($row = $result->fetch_assoc()) {
        $value = $row["ID"];
    }
    setcookie("board", $value, time() + 3600 * 24 * 7);
    $_COOKIE['board'] = $value;
} else {
    header("Location: login.php");
    die();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['shuffle'])) {
    setcookie("shuffle", $_POST['shuffle'], time() + 3600 * 24 * 7, '/');
    $_COOKIE['shuffle'] = $_POST['shuffle'];
    echo "<meta http-equiv='refresh' content='0'>";
    die();
}

$shuffle = 'false';
if (isset($_COOKIE['shuffle'])) {
    $shuffle = $_COOKIE['shuffle'];
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <link rel="stylesheet" href="css/style.css">

  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
          integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
          crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
          integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
          crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
          integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
          crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/mark.js/8.11.1/jquery.mark.min.js" charset="UTF-8"></script>
  <script src="js/scripts.js"></script>

</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-12">
            <div class="d-none d-md-inline" id="isTablet"></div>

            <form action="index.php" method="POST" id="shuffleForm" class="d-inline">
                <button type="button" class="btn btn-lg btn-outline-primary mb-3 mt-3 d-none d-md-inline pt-0 pb-0"
                        id="shuffle">
                    <img src="shuffle-<?php echo $shuffle; ?>.png" class="shuffleImg">
                </button>
                <input type="hidden" name="shuffle" value="<?php echo($shuffle == 'true' ? 'false' : 'true'); ?>">
            </form>

            <button type="button" class="btn btn-lg btn-outline-primary mb-3 mt-3 d-none d-md-inline pt-0 pb-0"
                    id="refresh">
                <img src="refresh.png" class="shuffleImg">
            </button>

            <?php
            function getContent($shuffle)
            {
                $content = getContentFromDB($shuffle);
                return $content;
            }

            function getContentFromDB($shuffle)
            {
                $servername = getenv("DATABASE_SERVER");
                $username = getenv("DATABASE_USERNAME");
                $password = getenv("DATABASE_PASSWORD");
                $dbname = getenv("DATABASE_SCHEMA");

                // Create connection
                $conn = new mysqli($servername, $username, $password, $dbname);
                // Check connection
                if ($conn->connect_error) {
                    echo "fail";
                    die("Connection failed: " . $conn->connect_error);
                }
                $board = $_COOKIE['board'];

                $limit = 20;
                if ($board == 3) {
                    $limit = 300;
                }
                if ($shuffle == 'true') {
                    $sql = "SELECT id, title, text, source, datetime, sender FROM topic WHERE board_ID = $board ORDER BY RAND() DESC LIMIT $limit";
                } else {
                    $sql = "SELECT id, title, text, source, datetime, sender FROM topic WHERE board_ID = $board ORDER BY datetime DESC LIMIT $limit";
                }
                $result = $conn->query($sql);

                $feeds = array();
                if ($result->num_rows > 0) {
                    // output data of each row
                    while ($row = $result->fetch_assoc()) {
                        $title = $row["title"];
                        $text = $row["text"];
                        $source = $row["source"];
                        $name = $row["sender"];

                        if (substr($source, 0, 4) == "www.") {
                            $source = "https://" . $source;
                        }
                        if (substr($source, 0, 4) == "http") {
                            $source = "<a href='$source' class='breakAll' target='_blank'>$source</a>";
                        }

                        $datetime = $row["datetime"];
                        $myDateTime = DateTime::createFromFormat('Y-m-d H:i:s', $datetime);

                        $object = (object)['title' => $title, 'text' => $text, 'source' => $source, 'datetime' => $myDateTime, 'name' => $name];
                        array_push($feeds, $object);
                    }
                }
                $conn->close();

                $html = "";

                $current_time = time();
                $tooold_time = ($current_time - (30 * 60) + (2 * 60 * 60));
                $tooold_time2 = ($current_time - (10 * 60) + (2 * 60 * 60)); //used for sound for example, should be same as refresh rate


                $hasNews = false;
                foreach ($feeds as $news) {
                    $class = '';
                    if (strtotime($news->datetime->format('d.m.Y H:i:s')) > $tooold_time) {
                        $class = ' class="bg-warning"';
                    }
                    if (strtotime($news->datetime->format('d.m.Y H:i:s')) > $tooold_time2) {
                        $hasNews = true;
                    }
                    $html .= '<table class="table table-bordered table-sm mb-4 context">
                        <tr' . $class . '><th colspan="2"><span class="breakWord" style="float: left;">' . $news->title . '</span><span style="float: right;">' . $news->datetime->format('d.m.y H:i:s') . '</span></th></tr>
                        <tr><td colspan="2" class="breakWord">' . $news->text . '</td></tr>
                        <tr><td style="width:75%">Quelle: ' . $news->source . '</td><td style="width:25%">Von: ' . $news->name . '</td></tr></table>';
                }

                $html .= '<input type="hidden" id="hasNews" value="' . $hasNews . '">';

                return $html;
            }

            print getContent($shuffle);
            ?>
        </div>
    </div>
</div>
</body>
</html>
