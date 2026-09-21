<?php
require '../config.php';
if(empty($_SESSION['role'])||$_SESSION['role']!=='admin'){ header("Location: ../login.php"); exit; }
$users = $pdo->query("SELECT id,name,email,role,created_at FROM users ORDER BY created_at DESC")->fetchAll();
include '../inc/header.php';
?>
<h2>Users</h2>
<table>
<tr><th>ID</th><th>Name</th><th>Email</th><th>Role</th><th>Joined</th></tr>
<?php foreach($users as $u): ?>
<tr>
 <td><?=$u['id']?></td>
 <td><?=htmlspecialchars($u['name'])?></td>
 <td><?=htmlspecialchars($u['email'])?></td>
 <td><?=$u['role']?></td>
 <td><?=$u['created_at']?></td>
</tr>
<?php endforeach;?>
</table>
<?php include '../inc/footer.php'; ?>
