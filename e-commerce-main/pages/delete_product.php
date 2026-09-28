<?php 
   if(isset($_GET["id"]) && $_GET["id"]){
        include_once("../model/Items.php");
        $itemId = $_GET["id"];
        $itm = Items::search($itemId);
        $itm->remove();
   }else{
    header("location:new_products.php");
    die();
   }
?>