<?php
require 'config.php';
if($_SERVER['REQUEST_METHOD']==='POST'){
  $name = trim($_POST['name']);
  $email = strtolower(trim($_POST['email']));
  $pass = $_POST['password'];

  // Check if email exists
  $stmt = $pdo->prepare("SELECT id FROM users WHERE email=?");
  $stmt->execute([$email]);
  if($stmt->fetch()) {
    $err = "Email already registered.";
  } else {
    $hash = password_hash($pass, PASSWORD_DEFAULT);
    $stmt = $pdo->prepare("INSERT INTO users(name,email,password,role) VALUES(?,?,?,?)");
    $stmt->execute([$name,$email,$hash,'user']);
    header("Location: login.php"); exit;
  }
}
include 'inc/header.php';
?>

<section class="auth">
  <h2>Sign Up</h2>
  <form method="post">
    <input name="name" type="text" placeholder="Name" required>
    <input name="email" type="email" placeholder="Email" required>
    <input name="password" type="password" placeholder="Password" required>
    <button>Register</button>
  </form>
  <?php if(!empty($err)) echo "<p class='err'>$err</p>"; ?>
</section>

<?php include 'inc/footer.php'; ?>
