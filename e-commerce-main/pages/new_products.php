<?php 
    if(isset($_POST["submit"])){
        $newEmployee = new Items($_POST["imgUrl"],$_POST["itemName"],$_POST["price"]);
        $newEmployee->save();
    }

?>

