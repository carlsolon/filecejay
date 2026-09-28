<?php
    $path = "./src/";
    $menu = file($path."main-menu.txt" , FILE_IGNORE_NEW_LINES);
?>
<ul class="main_menu">
    <?php
        foreach($menu as $i){
            list($text, $link) = explode(",", $i);
    ?>
    <li><a href="<?=$link?>"><?=$text?></a></li>
    <?php
        }
    ?>
</ul>