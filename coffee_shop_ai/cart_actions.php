<?php
require 'config.php';
header('Content-Type: application/json');

$action = $_POST['action'] ?? '';
$id = $_POST['id'] ?? null;
$price = $_POST['price'] ?? null;

if(!isset($_SESSION['cart'])) $_SESSION['cart'] = [];

switch($action){
    case 'add':
        if($id){
            if(isset($_SESSION['cart'][$id])) $_SESSION['cart'][$id]++;
            else $_SESSION['cart'][$id] = 1;
            echo json_encode(['ok'=>true]);
        }
        break;

    case 'remove':
        if($id && isset($_SESSION['cart'][$id])){
            unset($_SESSION['cart'][$id]);
            echo json_encode(['ok'=>true]);
        }
        break;

    case 'checkout':
        if(!isset($_SESSION['user_id'])) {
            echo json_encode(['ok'=>false,'msg'=>'not_logged']);
            exit;
        }

        $cart = $_SESSION['cart'] ?? [];
        if(empty($cart)) {
            echo json_encode(['ok'=>false,'msg'=>'empty_cart']);
            exit;
        }

        $total = 0;
        foreach($cart as $pid=>$qty){
            $stmt = $pdo->prepare("SELECT price FROM products WHERE id=?");
            $stmt->execute([$pid]);
            $p = $stmt->fetch();
            $total += $p['price'] * $qty;
        }

        // Insert order
        $stmt = $pdo->prepare("INSERT INTO orders(user_id,total,created_at) VALUES(?,?,NOW())");
        $stmt->execute([$_SESSION['user_id'],$total]);
        $order_id = $pdo->lastInsertId();

        // Insert order items
        $stmt_item = $pdo->prepare("INSERT INTO order_items(order_id,product_id,quantity) VALUES(?,?,?)");
        foreach($cart as $pid=>$qty){
            $stmt_item->execute([$order_id,$pid,$qty]);
        }

        // Clear cart
        $_SESSION['cart'] = [];
        echo json_encode(['ok'=>true]);
        break;

    default:
        echo json_encode(['ok'=>false,'msg'=>'unknown_action']);
}
