<?php
header('Content-Type: application/json');
$message = $_POST['message'] ?? '';

$reply = "Sorry, I don't understand.";

if($message){
    $msg = strtolower($message);
    if(strpos($msg,'hello')!==false) $reply = "Hello! How can I help you today?";
    elseif(strpos($msg,'order')!==false) $reply = "You can place an order from the Menu page.";
    elseif(strpos($msg,'menu')!==false) $reply = "Check out our menu <a href='menu.php'>here</a>!";
}

echo json_encode(['reply'=>$reply]);
