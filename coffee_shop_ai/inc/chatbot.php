<div class="ai-chatbot">
    <div class="ai-chatbot__messages"></div>
    <input id="chat-input" placeholder="Ask something..." />
    <button id="chat-send">Send</button>
    <button class="ai-chatbot__close">Close</button>
</div>
<button class="ai-chatbot__toggle">Chat</button>
<?php
header('Content-Type: application/json');
$msg = $_POST['message'] ?? '';
$reply = "Sorry, I can't answer that yet.";
if(stripos($msg,'hello')!==false) $reply = "Hello! How can I help you?";
echo json_encode(['reply'=>$reply]);
