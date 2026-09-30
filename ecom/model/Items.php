<?php 
class Items{
    public $imgUrl;
    public $itemName;
    public $price;

    function __construct($imgUrl, $itemName, $price){
        $this->imgUrl = $imgUrl;
        $this->itemName = $itemName;
        $this->price = $price;
    }

}
?>