<?php
$path = "./widgets/";
$nav = $path . "sho.php";
$cart = $path . "cart.php";
$header = $path . "header.php";
$feature = $path . "features.php";
$product = $path . "product.php";
$slider_one = $path . "slider_item.php";
$footer = $path . "footer.php";
$map = $path . "map.php";
$navi = $path . "main_menu.php";
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
  
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="style.css">
    <title>One Kick Away</title>
</head>
<body>
    <header class="header">
        <?php
        include($header);
        ?>
            <div class="nav">
        <?php 
        include($nav);
        ?>
    </div>
    </header>
    <main>
        <div class="slider">
            <?php
            include($slider_one);
            ?>
        </div>
        <div class="product" id="product">
            <?php
            include($product);
            ?>
        </div>
        <div class="features">
            <?php
            include($feature);
            ?>
        </div>
        <div class="map">
           <?php 
           include($map);
           ?>
        </div>
    </main>
    <footer class="footer">
        <?php
        include($footer);
        ?>
    </footer>
    <script src="./app.js"></script>
</body>
</html>