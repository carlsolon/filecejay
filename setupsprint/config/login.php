<?php 
include '../includes/database.php';
session_start();

// If already logged in → go to profile
if (isset($_SESSION["ClientID"])) {
    header('Location: ../pages/profilePage.php');
    exit();
}

// If form submitted
if (isset($_POST['email']) && isset($_POST['password'])) {

    $email = trim($_POST['email']);
    $password = trim($_POST['password']);

    // ADMIN QUICK CHECK (optional)
    if ($email === "admin@test.com" && $password === "admin123") {
        header('Location: ../admin/adminDashboard.php');
        exit();
    }

    // NORMAL USER LOGIN
    $query = 'SELECT * FROM clients WHERE Email = ? LIMIT 1';
    $statement = $connect->prepare($query);
    $statement->execute([$email]);

    if ($statement->rowCount() > 0) {

        $user = $statement->fetch(PDO::FETCH_ASSOC);

        // HASHED PASSWORD CHECK
        if (password_verify($password, $user['PasswordHash'])) {

            $_SESSION["ClientID"] = $user['ClientID'];
            $_SESSION["userFname"] = $user['FirstName'];
            $_SESSION["userLname"] = $user['LastName'];
            $_SESSION["email"] = $user['Email'];
            $_SESSION["phone"] = $user['PhoneNumber'];
            $_SESSION["address"] = $user['Address'];

            header('Location: ../pages/profilePage.php');
            exit();

        } else {
            echo "<script>alert('Incorrect password'); window.location='../pages/signinPage.php';</script>";
            exit();
        }

    } else {
        echo "<script>alert('Email not found'); window.location='../pages/signinPage.php';</script>";
        exit();
    }

} else {
    header('Location: ../pages/signinPage.php');
    exit();
}
