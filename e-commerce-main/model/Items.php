<?php 
class Items{

    public $id;
    public $imgUrl;
    public $itemName;
    public $price;

    public static $tblName = "tblshoes";

    function __construct($imgUrl=null, $itemName=null, $price=null){
        $this->imgUrl = $imgUrl;
        $this->itemName = $itemName;
        $this->price = $price;
    }

    function save(){
        require("dbconfig.php");
        
        $sql = "INSERT INTO ".self::$tblName." (imgUrl,itemName,price) 
                VALUES ('".$this->imgUrl."',
                        '".$this->itemName."',
                        '".$this->price."'
                )";

        if($conn->query($sql)===TRUE){
            echo "New record created!";
        }else{
            echo "Error while saving data.";
        }
        
        $conn->close();
    }
    public static function getAll(){
        require("../pages/dbconfig.php");

        $sql = "SELECT * FROM ".self::$tblName;
        $result = $conn->query($sql);

        $conn->close();
        return $result;
    }

    public static function search($id){
        require("dbconfig.php");

        $sql = "SELECT * FROM ".self::$tblName.
                " WHERE id=$id";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            $emp = new Items();
            while($row = $result->fetch_assoc()){
                $emp->id = $row["ID"];
                $emp->imgUrl = $row["imgUrl"];
                $emp->itemName = $row["itemName"];
                $emp->price = $row["price"];
            }
            return $emp;
        }else{
            echo "Employee not found.";
        }

        
        $conn->close();
    }

    function update(){
        require("dbconfig.php");
        $sql = "UPDATE ".self::$tblName." SET 
                lname='$this->imgUrl', 
                fname='$this->itemName',
                position='$this->price' 
                 WHERE id=$this->id";
        if($conn->query($sql) === TRUE){
            header("location:../update_product.php");
        }else{
            echo "Opps! Something went wrong while updating.";
        }

        $conn->close();
    }
    function remove(){
        require("dbconfig.php");
        $sql = "DELETE FROM ".self::$tblName." WHERE id=$this->id";

        if($conn->query($sql)===TRUE){
            header("location: ../pages/update_product.php");
        }else{
            echo "Opps! Something went while deleting data.";
        }

        $conn->close();
    }

}
?>