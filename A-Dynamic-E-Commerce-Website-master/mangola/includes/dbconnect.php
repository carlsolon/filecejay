<?php
// Database connection settings
$host = "localhost";
$user = "root";
$password = "";
$database = "pc";

// Create connection
$connection = mysqli_connect($host, $user, $password, $database);

// Check connection
if (!$connection) {
    die("Database connection failed: " . mysqli_connect_error());
}

// Optional: Set character set to UTF-8
mysqli_set_charset($connection, "utf8");
?>
