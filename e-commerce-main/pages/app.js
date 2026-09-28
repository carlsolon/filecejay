// Function to add item to cart
function addCart() {
  // Your logic to add item to cart goes here
  // For example, you can store the item details in localStorage

  // Show modal cart
  const modalCart = document.querySelector(".modalCart");
  modalCart.style.display = "block";

  // Close modal cart after 3 seconds (adjust as needed)
  setTimeout(function() {
      modalCart.style.display = "none";
  }, 3000);
}

// Function to close modal cart
function closeModalCart() {
  const modalCart = document.querySelector(".modalCart");
  modalCart.style.display = "none";
}

// Event listener for closing modal cart
document.addEventListener("DOMContentLoaded", function() {
  const closeButton = document.querySelector(".modalCart .close");
  if (closeButton) {
      closeButton.addEventListener("click", closeModalCart);
  }
});
