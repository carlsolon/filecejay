
<?php 
$path = "./headers/";
$title = $path."title.php";

?>
<nav id="nav">
            <div class="navTop">
                <img src="./img/logo.jpg" alt="" height="100">
                <div class="navItem one">
                <?php 
                    include($title);
                    ?>
                </div>
                <div class="navItem two">
                    <div class="search">
                        <input type="text" placeholder="Search" class="searchInput">
                        <i class="fa fa-search"></i>
                    </div>
                </div>
                <div id="addToCart" onclick="cartModal()">
                    <i class="fa fa-cart-shopping"></i>
                </div>
                <?php
                
                ?>
            </div>
            <div class="navi">
                <?php
                include($navi);
                ?>
            </div>
        </nav>