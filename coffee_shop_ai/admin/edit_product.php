<?php
require '../config.php';
if(empty($_SESSION['role'])||$_SESSION['role']!=='admin'){ header("Location: ../login.php"); exit; }

$id = (int)($_GET['id'] ?? 0);
$stmt = $pdo->prepare("SELECT * FROM products WHERE id=?"); $stmt->execute([$id]); $p = $stmt->fetch();
if(!$p) { header("Location: products.php"); exit; }

if($_SERVER['REQUEST_METHOD']==='POST'){
  $name=$_POST['name']; $price=$_POST['price']; $desc=$_POST['description'];
  if(!empty($_FILES['image']['name'])){
    $img = $_FILES['image']['name'];
    move_uploaded_file($_FILES['image']['tmp_name'], __DIR__.'/../uploads/'.$img);
  } else $img = $p['image'];
  $upd = $pdo->prepare("UPDATE products SET name=?,price=?,description=?,image=? WHERE id=?");
  $upd->execute([$name,$price,$desc,$img,$id]);
  header("Location: products.php"); exit;
}
include '../inc/header.php';
?>
<h2>Edit Product</h2>
<form method="post" enctype="multipart/form-data">
 <input name="name" value="<?=htmlspecialchars($p['name'])?>">
 <input name="price" type="number" step="0.01" value="<?=$p['price']?>">
 <textarea name="description"><?=htmlspecialchars($p['description'])?></textarea>
 <img src="/uploads/<?=htmlspecialchars($p['image'])?>" width="120"><br>
 <input type="file" name="image">
 <button>Update</button>
</form>
<?php include '../inc/footer.php'; ?>
