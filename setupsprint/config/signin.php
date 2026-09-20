<?php
session_start();
include "../includes/database.php";

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    // Step 1: check if fields exist
    if (!isset($_POST["email"], $_POST["password"])) {
        header("Location: ../pages/signinPage.php");
        exit();
    }

    // Step 2: get and trim inputs
    $email = trim($_POST["email"]);
    $password = trim($_POST["password"]);

    // Step 3: fetch user by email
    $stmt = $connect->prepare("SELECT * FROM clients WHERE Email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$user) {
        echo "<script>alert('Email not found'); window.location='../pages/signinPage.php';</script>";
        exit();
    }

    // Step 4: verify hashed password
    $dbPasswordHash = $user["PasswordHash"];
 // make sure this matches your DB column

    if (!password_verify($password, $dbPasswordHash)) {
        echo "<script>alert('Incorrect password'); window.location='../pages/signinPage.php';</script>";
        exit();
    }

    // Step 5: login success → set session
    $_SESSION["ClientID"] = $user["ClientID"];
    $_SESSION["userFname"] = $user["FirstName"];
    $_SESSION["userLname"] = $user["LastName"];
    $_SESSION["email"] = $user["Email"];
    $_SESSION["phone"] = $user["PhoneNumber"];
    $_SESSION["address"] = $user["Address"];

    // Step 6: redirect to profile page
    header("Location: ../pages/profilePage.php");
    exit();
}

// Step 7: direct access → redirect to signin page
header("Location: ../pages/signinPage.php");
exit();
?>
