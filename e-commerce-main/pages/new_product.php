<?php 
    if(isset($_POST["submit"])){
        $newEmployee = new Items($_POST["imgUrl"],$_POST["itemName"],$_POST["price"]);
        $newEmployee->save();
    }

?>

<form class="form" action="" method="POST">
  <div class="row">
    <div class="col">
      <input type="file" class="form-control" placeholder="Enter imgUrl..." name="imgUrl">
    </div>
    <div class="col">
      <input type="text" class="form-control" placeholder="Enter Item Name" name="itemName">
    </div>
    <div class="col">
      <input type="text" class="form-control" placeholder="Enter Price" name="price">
    </div>
    <div class="col">
        <input type="submit" value="Create new Product" name="submit" class="btn btn-primary">
    </div>
  </div>
</form>