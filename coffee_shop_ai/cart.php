<?php
include 'config.php';
include 'inc/header.php';

$cart = $_SESSION['cart'] ?? [];
$total = 0;
?>

<section class="cart-page">
  <h2>Your Cart</h2>
  <?php if(empty($cart)): ?>
    <p>Your cart is empty.</p>
  <?php else: ?>
    <table>
      <tr>
        <th>Product</th>
        <th>Price</th>
        <th>Qty</th>
        <th>Total</th>
      </tr>
      <?php foreach($cart as $id=>$qty):
        $stmt = $pdo->prepare("SELECT * FROM products WHERE id=?");
        $stmt->execute([$id]);
        $p = $stmt->fetch();
        $lineTotal = $p['price']*$qty;
        $total += $lineTotal;
      ?>
      <tr>
        <td><?=htmlspecialchars($p['name'])?></td>
        <td>$<?=number_format($p['price'],2)?></td>
        <td><?=$qty?></td>
        <td>$<?=number_format($lineTotal,2)?></td>
      </tr>
      <?php endforeach; ?>
      <tr>
        <td colspan="3">Total</td>
        <td>$<?=number_format($total,2)?></td>
      </tr>
    </table>
    <a href="checkout.php" class="btn">Checkout</a>
  <?php endif; ?>
</section>

<?php include 'inc/footer.php'; ?>
