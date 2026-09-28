<?php 
    $path = "./src/";
    $title = file($path."title.txt");
    
    foreach($title as $i){
?>
    <h1><?=$i?></h1>
<?php 
    }
?>