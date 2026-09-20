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
<body class="signup">
    <section>
        <div class="left-image"></div>
        <div class="login-form">
            <h1 class="big-text">Create an Account</h1>

            <form action="../config/signup.php" method="POST">

            
                <div class="name-row">
                    <div>
                        <label>First Name</label>
                        <input type="text" placeholder="First Name" name="firstname" required>
                    </div>
                    <div>
                        <label>Last Name</label>
                        <input type="text" placeholder="Last Name" name="lastname" required>
                    </div>  
                </div> 
                
                <div class="contact-row">
                    <div>
                        <label>Email</label>
                        <input type="email" placeholder="Email" name="email" required>
                    </div>
                    <div>
                        <label>Phone Number</label>
                        <input type="tel" placeholder="Phone" name="phone" required>
                    </div>  
                </div> 

                <label>Password</label>
<input type="password" placeholder="Password" name="password" required>
<input type="password" placeholder="Confirm Password" name="confirmpassword" required>


                <p>By signing up I agree to the <span><a href="https://www.termsofservicegenerator.net/live.php?token=wYC2mKAGfF6YJ32SmwZkk9HUDiTBVKuO">Terms & Conditions</a></span></p>
                <input class="log-btn" type="submit" name="signup" value="Signup">
            </form>
        </div>
    </section>
</body>
</html>
