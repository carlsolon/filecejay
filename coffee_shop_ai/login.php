<?php
require 'config.php';
if($_SERVER['REQUEST_METHOD']==='POST'){
  $email = strtolower(trim($_POST['email']));
  $pass = $_POST['password'];

  $stmt = $pdo->prepare("SELECT * FROM users WHERE email=?");
  $stmt->execute([$email]);
  $u = $stmt->fetch(PDO::FETCH_ASSOC);

  if($u && password_verify($pass, $u['password'])){
    $_SESSION['user_id'] = $u['id'];
    $_SESSION['name'] = $u['name'];
    $_SESSION['role'] = $u['role'];
    header("Location: index.php"); exit;
  } else {
    $err = "Invalid credentials.";
  }
}
include 'inc/header.php';
?>

<section class="auth">
  <h2>Sign In</h2>
  <form method="post">
    <input name="email" type="email" placeholder="Email" required>
    <input name="password" type="password" placeholder="Password" required>
    <button>Login</button>
  </form>
  <?php if(!empty($err)) echo "<p class='err'>$err</p>"; ?>
</section>

<?php include 'inc/footer.php'; ?>
