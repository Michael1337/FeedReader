<?php
if (isset($_COOKIE["board"])) {
    header("Location: index.php");
    die();
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
    <link rel="stylesheet" href="public/css/style.css">

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
    <script src="public/js/scripts.js"></script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">


            <h5>Melde dich einmalig für deine WG an.</h5>

            <form action="public/index.php" method="post" id="loginForm">
                <div class="form-group">
                    <label for="title">Dein WG-Passwort:</label>
                    <input class="form-control" type="text" id="passphrase" name="passphrase" placeholder="Das Passwort erhältst du vom Versuchsleiter.">
                </div>
                <input type="hidden" name="cookie">
                <button type="button" class="btn btn-primary" id="sendPhrase">
                    Abschicken
                </button>
            </form>


        </div>
    </div>
</div>
</body>
</html>
