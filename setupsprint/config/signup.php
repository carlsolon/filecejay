<?php
if ($_SERVER["REQUEST_METHOD"] === "POST") {

    // 1. Get form data safely
    $firstname = $_POST["firstname"] ?? "";
    $lastname  = $_POST["lastname"] ?? "";
    $email     = $_POST["email"] ?? "";
    $phone     = $_POST["phone"] ?? "";
    $password  = $_POST["password"] ?? "";
    $confirm   = $_POST["confirmpassword"] ?? "";

    // 2. Basic validation
    if ($password === "" || $confirm === "") {
        echo "<script>alert('Password fields cannot be empty!'); window.location='../pages/SignUpPage.php';</script>";
        exit();
    }

    if ($password !== $confirm) {
        echo "<script>alert('Passwords do not match!'); window.location='../pages/SignUpPage.php';</script>";
        exit();
    }

    // 3. Include database connection
    include "../includes/database.php";

    // 4. Check if email already exists
    $check = $connect->prepare("SELECT ClientID FROM clients WHERE Email = ?");
    $check->execute([$email]);
    if ($check->fetch()) {
        echo "<script>alert('Email already registered!'); window.location='../pages/SignUpPage.php';</script>";
        exit();
    }

    // 5. Default address
    $address = "Default Address";

    // 6. Hash Password (very important)
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    // 7. Insert into database
    $query = $connect->prepare("
        INSERT INTO clients (FirstName, LastName, Email, PasswordHash, Address, PhoneNumber)
        VALUES (?, ?, ?, ?, ?, ?)
    ");

    if ($query->execute([$firstname, $lastname, $email, $hashedPassword, $address, $phone])) {
        echo "<script>alert('Account created successfully!'); window.location='../pages/signinPage.php';</script>";
        exit();
    } else {
        $error = $query->errorInfo();
        echo "Database insert error: " . $error[2];
    }

} else {
    // Redirect if accessed directly
    header("Location: ../pages/SignUpPage.php");
    exit();
}
?>
