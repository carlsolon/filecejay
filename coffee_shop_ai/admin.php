<?php
require 'config.php';
if(!isset($_SESSION['role']) || $_SESSION['role']!=='admin'){
  header("Location: login.php"); exit;
}

include 'inc/header.php';
?>

<section class="admin-panel">
  <h2>Admin Panel</h2>

  <h3>Products</h3>
  <a href="add_product.php">Add New Product</a>
  <table>
    <tr><th>Name</th><th>Price</th><th>Actions</th></tr>
    <?php
    $stmt = $pdo->query("SELECT * FROM products");
    while($p = $stmt->fetch()):
    ?>
    <tr>
      <td><?=htmlspecialchars($p['name'])?></td>
      <td>$<?=number_format($p['price'],2)?></td>
      <td>
        <a href="edit_product.php?id=<?=$p['id']?>">Edit</a> |
        <a href="delete_product.php?id=<?=$p['id']?>" onclick="return confirm('Delete?')">Delete</a>
      </td>
    </tr>
    <?php endwhile; ?>
  </table>

  <h3>Orders</h3>
  <table>
    <tr><th>ID</th><th>User</th><th>Total</th><th>Date</th></tr>
    <?php
    $stmt = $pdo->query("SELECT o.*, u.name as user_name FROM orders o JOIN users u ON o.user_id=u.id ORDER BY o.created_at DESC");
    while($o = $stmt->fetch()):
    ?>
    <tr>
      <td><?=$o['id']?></td>
      <td><?=htmlspecialchars($o['user_name'])?></td>
      <td>$<?=number_format($o['total'],2)?></td>
      <td><?=$o['created_at']?></td>
    </tr>
    <?php endwhile; ?>
  </table>
</section>

<?php include 'inc/footer.php'; ?>
