<?php
include 'environment.php';
$servername = getenv("DATABASE_SERVER");
$username = getenv("DATABASE_USERNAME");
$password = getenv("DATABASE_PASSWORD");
$dbname = getenv("DATABASE_SCHEMA");

$board = 1;

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    echo "fail";
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT datetime FROM topic WHERE sender = 'Demo' AND board_ID = $board ORDER BY datetime DESC LIMIT 1";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // output data of each row
    while ($row = $result->fetch_assoc()) {
        $latestNewsDT = DateTime::createFromFormat('Y-m-d H:i:s', $row["datetime"]);
        $latestNewsDT->sub(new DateInterval('PT2H'));
    }
} else {
    $latestNewsDT = DateTime::createFromFormat('Y-m-d H:i:s', '2010-07-30 12:21:38');
}

$latestNewsTS = $latestNewsDT->getTimestamp();

echo "Last entry was: " . $latestNewsDT->format('Y-m-d H:i:s') . " (GMT0, Feeds are 0, Server is 0, Berlin is +2)<br>";

$newsSource = array(
    array(
        "title" => "infranken - Würzburg",
        "url" => "https://www.infranken.de/storage/rss/rss/2.0/wuerzburg.xml"
    ),
    array(
        "title" => "Main Post - Würzburg-Stadt",
        "url" => "https://www.mainpost.de/storage/rss/rss/wuestadt.xml"
    ),
    array(
        "title" => "Main Post - Würzburg-Land",
        "url" => "https://www.mainpost.de/storage/rss/rss/wueland.xml"
    )
);

foreach ($newsSource as $feed) {
    safeContent($feed, $conn, $latestNewsTS, $board);
}


$sql = "DELETE FROM topic WHERE datetime NOT IN (SELECT * FROM (SELECT datetime FROM topic ORDER BY datetime DESC LIMIT 1000) s)"; // delete all but the latest entries
$result = $conn->query($sql);

$sql = "SELECT datetime FROM topic WHERE sender = 'Demo' AND board_ID = $board ORDER BY datetime DESC LIMIT 1";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // output data of each row
    while ($row = $result->fetch_assoc()) {
        $latestNewsDT = DateTime::createFromFormat('Y-m-d H:i:s', $row["datetime"]);
        $latestNewsDT->sub(new DateInterval('PT2H'));
    }
} else {
    $latestNewsDT = DateTime::createFromFormat('Y-m-d H:i:s', '2010-07-30 12:21:38');
}

echo "Last entry is: " . $latestNewsDT->format('Y-m-d H:i:s') . " (GMT0, Feeds are 0, Server is 0, Berlin is +2)<br>";

$conn->close();


function safeContent($feed, $conn, $latestNewsTS, $board)
{
    $rss = simplexml_load_file($feed["url"]);
    $sql = "INSERT INTO topic (board_ID, title, text, source, datetime, sender) VALUES ";

    $counter = 0;
    $hit = 0;
    $entries = 0;
    $newestItem = 0;

    foreach ($rss->channel->item as $item) {
        if ($counter == 0) {
            $newestItem = strtotime($item->pubDate);
        }
        $feedTS = strtotime($item->pubDate);

        // if an item is older than the latest news, all remaining should be too, so we can stop here.
        // sometimes they mess the date up, though, so we should check for 2 older dates.
        if ($feedTS < $latestNewsTS) {
            $hit++;
            if ($hit >= 2) {
                break;
            }
        }

        // add feed if it is newer than the latest feed,
        // but not as new as the current time (because some feeds use future dates and screw things up, also plus 2 minutes for clock variance)
        if ($feedTS > $latestNewsTS && $feedTS < (time() + 60 * 2)) {
            $entries += 1;
            $title = mysqli_real_escape_string($conn, htmlspecialchars($item->title));
            $title = strlen($title) > 150 ? substr($title, 0, 147) . "..." : $title;
            $text = mysqli_real_escape_string($conn, $item->description);
            $source = mysqli_real_escape_string($conn, htmlspecialchars($item->link));
            $datetime = date('Y-m-d H:i:s', strtotime($item->pubDate) + 2 * 60 * 60);
            $sender = "Demo";

            $sql .= "($board, '$title', '$text', '$source', '$datetime', '$sender'),";
        }

        $counter++;
    }
    $sql = substr($sql, 0, -1);
    $sql .= ";";

    if ($entries > 0) {
        if ($conn->query($sql)) {
            echo $entries . " neue Einträge von " . $feed["title"] . " (" . $feed["url"] . ") - Last entry: " . date('Y-m-d H:i:s', $newestItem + 2 * 60 * 60) . "<br>";
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }
    } else {
        echo "Keine neuen Einträge von " . $feed["title"] . " (" . $feed["url"] . ") - Last entry: " . date('Y-m-d H:i:s', $newestItem + 2 * 60 * 60) . "<br>";
    }

}

?>
