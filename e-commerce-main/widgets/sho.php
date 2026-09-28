<ul>
    <?php 
        $path = "./src/";
        $nav = file( $path."sho.txt" );
        foreach($nav as $item){
    ?>
        <li class="menuItem"><a href="#" class="a"><?=$item?></a></li>
    <?php 
        }
    ?>

</ul>

