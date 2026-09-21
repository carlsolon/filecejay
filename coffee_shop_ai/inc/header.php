<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Drip Cafe</title>

  <link rel="stylesheet" href="assets/css/main.css">
  <link rel="icon" href="assets/img/favicon.png">
  <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;700&family=Marck+Script&display=swap" rel="stylesheet" />
</head>

<body>
<header>
  <div class="second-header">
    <div class="menu-btn">
      <span class="menu-btn__burger"></span>
    </div>

    <nav class="nav">
      <ul class="menu-nav">
        <li class="menu-nav__item">
          <a href="index.php" class="logo menu-nav__link">
            <img src="assets/img/favicon.png" />
            <span class="logo-first">Drip</span>
            <span class="logo-last">Cafe</span>
          </a>
        </li>

        <li class="menu-nav__item">
          <a href="login.php" class="sign-in menu-nav__link">Sign In</a>
          <span class="menu-nav__link" id="slash">/</span>
          <a href="signup.php" class="sign-up menu-nav__link">Sign Up</a>
        </li>

        <br />

        <li><a href="index.php" class="menu-nav__link">Home</a></li>
        <li><a href="menu.php" class="menu-nav__link">Menu</a></li>
        <li><a href="services.php" class="menu-nav__link">Services</a></li>
        <li><a href="contact.php" class="menu-nav__link">Contact</a></li>

        <li>
          <a href="#" class="menu-nav__link cart__openBtn">
            <i class="fa fa-cart-plus"></i>
          </a>
        </li>
      </ul>
    </nav>
  </div>
</header>
