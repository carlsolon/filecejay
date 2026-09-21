<?php
require '../config.php';
if(empty($_SESSION['role']) || $_SESSION['role']!=='admin'){ header("Location: ../login.php"); exit; }
include '../inc/header.php';
?>
<h2>Admin Dashboard</h2>
<div class="admin-links">
  <a href="products.php">Manage Products</a>
  <a href="orders.php">Manage Orders</a>
  <a href="users.php">Users</a>
</div>
<?php include '../inc/footer.php'; ?>
