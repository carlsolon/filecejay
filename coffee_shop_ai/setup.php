<?php
// setup.php
$DB_HOST = '127.0.0.1';
$DB_NAME = 'mywebsite';
$DB_USER = 'root';
$DB_PASS = ''; // change if you have a password

try {
    $pdo = new PDO("mysql:host=$DB_HOST;charset=utf8mb4", $DB_USER, $DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
    ]);

    // Create database if not exists
    $pdo->exec("CREATE DATABASE IF NOT EXISTS `$DB_NAME`");
    $pdo->exec("USE `$DB_NAME`");

    // 1. Create tables
    $pdo->exec("
    CREATE TABLE IF NOT EXISTS users (
      id INT AUTO_INCREMENT PRIMARY KEY,
      name VARCHAR(100),
      email VARCHAR(100) UNIQUE,
      password VARCHAR(255),
      role ENUM('user','admin') DEFAULT 'user'
    );

    CREATE TABLE IF NOT EXISTS products (
      id INT AUTO_INCREMENT PRIMARY KEY,
      name VARCHAR(100),
      description TEXT,
      price DECIMAL(10,2),
      image VARCHAR(255),
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS orders (
      id INT AUTO_INCREMENT PRIMARY KEY,
      user_id INT,
      total DECIMAL(10,2),
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY(user_id) REFERENCES users(id)
    );

    CREATE TABLE IF NOT EXISTS order_items (
      id INT AUTO_INCREMENT PRIMARY KEY,
      order_id INT,
      product_id INT,
      quantity INT,
      FOREIGN KEY(order_id) REFERENCES orders(id),
      FOREIGN KEY(product_id) REFERENCES products(id)
    );
    ");

    echo "✅ Tables created successfully!<br>";

    // 2. Insert default admin
    $adminName = "Admin";
    $adminEmail = "admin@example.com";
    $adminPassword = "admin123"; // Change after first login
    $hashedPassword = password_hash($adminPassword, PASSWORD_DEFAULT);

    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
    $stmt->execute([$adminEmail]);
    if ($stmt->rowCount() === 0) {
        $stmt = $pdo->prepare("INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, 'admin')");
        $stmt->execute([$adminName, $adminEmail, $hashedPassword]);
        echo "✅ Admin created! Email: $adminEmail | Password: $adminPassword<br>";
    } else {
        echo "ℹ️ Admin already exists.<br>";
    }

    // 3. Insert sample products
    $sampleProducts = [
        ["Espresso", "Strong and bold coffee.", 2.99, "espresso.jpg"],
        ["Cappuccino", "Coffee with frothy milk.", 3.99, "cappuccino.jpg"],
        ["Latte", "Smooth coffee with milk.", 4.49, "latte.jpg"]
    ];

    foreach ($sampleProducts as $p) {
        $stmt = $pdo->prepare("SELECT * FROM products WHERE name=?");
        $stmt->execute([$p[0]]);
        if ($stmt->rowCount() === 0) {
            $stmt = $pdo->prepare("INSERT INTO products (name, description, price, image) VALUES (?, ?, ?, ?)");
            $stmt->execute($p);
        }
    }

    echo "✅ Sample products added!<br>";

    echo "<br>Setup complete! Delete this file (setup.php) for security.";

} catch (PDOException $e) {
    die("Error: " . $e->getMessage());
}
