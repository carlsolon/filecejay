<?php
$path = "../widgets/";
$pathTwo = "./headers/";
$content = $path . "item.php";
$header = $pathTwo . "header.php";
$navi = $path . "main_menu.php";
$footer = $pathTwo . "footer.php";
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>product</title>
    <link rel="stylesheet" href="../style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>

<body>
    <header class="header">
        <?php
        include($header);
        ?>
    </header>
    <main>
        <div class="productItem">
            <div class="item">
                <?php
                include($content);
                ?>
            </div>
        </div>
    </main>


    <footer class="footer">
        <?php
        include($footer);
        ?>
    </footer>
</body>

</html>