<?php
require '../config.php';
if(empty($_SESSION['role'])||$_SESSION['role']!=='admin'){ header("Location: ../login.php"); exit; }

if(isset($_GET['status']) && isset($_GET['id'])){
  $u = $pdo->prepare("UPDATE orders SET status=? WHERE id=?");
  $u->execute([$_GET['status'],(int)$_GET['id']]);
  header("Location: orders.php"); exit;
}

$orders = $pdo->query("SELECT o.*, u.name FROM orders o JOIN users u ON o.user_id=u.id ORDER BY o.created_at DESC")->fetchAll();
include '../inc/header.php';
?>
<h2>Orders</h2>
<table>
<tr><th>ID</th><th>User</th><th>Total</th><th>Status</th><th>Items</th><th>Actions</th></tr>
<?php foreach($orders as $o): ?>
<tr>
  <td><?=$o['id']?></td>
  <td><?=htmlspecialchars($o['name'])?></td>
  <td><?=$o['total']?></td>
  <td><?=$o['status']?></td>
  <td>
    <?php
      $it = $pdo->prepare("SELECT oi.*, p.name FROM order_items oi JOIN products p ON oi.product_id=p.id WHERE order_id=?");
      $it->execute([$o['id']]);
      foreach($it->fetchAll() as $i) echo htmlspecialchars($i['name'])." x".$i['quantity']." ($".$i['price'].")<br>";
    ?>
  </td>
  <td>
    <a href="?id=<?=$o['id']?>&status=processing">Processing</a> |
    <a href="?id=<?=$o['id']?>&status=completed">Complete</a> |
    <a href="?id=<?=$o['id']?>&status=cancelled">Cancel</a>
  </td>
</tr>
<?php endforeach;?>
</table>
<?php include '../inc/footer.php'; ?>
