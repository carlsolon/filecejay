document.addEventListener('click', e=>{
  if(e.target.matches('.add-to-cart')){
    const id=e.target.dataset.id, price=e.target.dataset.price;
    fetch('/cart_actions.php',{method:'POST',body:new URLSearchParams({action:'add',id,price})})
    .then(r=>r.json()).then(()=>alert('Added to cart'));
  }
  if(e.target.matches('.remove')){
    const id=e.target.dataset.id;
    fetch('/cart_actions.php',{method:'POST',body:new URLSearchParams({action:'remove',id})})
    .then(r=>r.json()).then(()=> location.reload());
  }
});
const chk=document.getElementById('checkout-btn');
if(chk) chk.addEventListener('click', ()=>{
  fetch('/cart_actions.php',{method:'POST',body:new URLSearchParams({action:'checkout'})})
  .then(r=>r.json()).then(j=>{
    if(j.ok) { alert('Order placed!'); window.location='/index.php'; }
    else if(j.msg==='not_logged'){ alert('Please login first.'); window.location='/login.php'; }
    else alert('Error: '+(j.msg||'unknown'));
  });
});

// Chatbot
const chatToggle=document.querySelector('.ai-chatbot__toggle');
const chat=document.querySelector('.ai-chatbot');
const chatClose=document.querySelector('.ai-chatbot__close');
const chatSend=document.getElementById('chat-send');
const chatInput=document.getElementById('chat-input');
const chatMessages=document.querySelector('.ai-chatbot__messages');

if(chatToggle) chatToggle.addEventListener('click', ()=> chat.classList.toggle('active'));
if(chatClose) chatClose.addEventListener('click', ()=> chat.classList.remove('active'));
if(chatSend) chatSend.addEventListener('click', ()=>{
  const v=chatInput.value.trim(); if(!v) return;
  const um=document.createElement('div'); um.className='message user-message'; um.textContent=v; chatMessages.appendChild(um);
  chatInput.value='';
  fetch('/chatbot.php',{method:'POST',body:new URLSearchParams({message:v})})
    .then(r=>r.json()).then(j=>{
      const bm=document.createElement('div'); bm.className='message bot-message'; bm.innerHTML=j.reply; chatMessages.appendChild(bm);
      chatMessages.scrollTop = chatMessages.scrollHeight;
    });
});
