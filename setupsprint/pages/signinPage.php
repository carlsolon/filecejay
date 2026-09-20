<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SetUpSprint</title>
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="../assets/css/style1.css">
    <link rel="icon" href="../assets/images/SetUpSprint.svg" type="image/icon type">
</head>
<body class="signin">
    <section>
        <div class="left-image"></div>

        <div class="login-form">
            <h1 class="big-text">Welcome Back!</h1>

            <form action="../config/signin.php" method="POST">


                <label>Email</label>
                <input type="email" placeholder="Email" name="email" required>

                <label>Password</label>
                <input type="password" placeholder="Password" name="password" required>

                <p>
                    Don’t have an account?
                    <a href="SignUpPage.php">Sign up</a>
                </p>

                <input class="log-btn" type="submit" name="login" value="Login">

            </form>
        </div>
    </section>
</body>
</html>
