<?php include 'config.php'; ?>
<?php include 'inc/header.php'; ?>

<section class="menu">
  <div class="flex">
    <?php
    $stmt = $pdo->query("SELECT * FROM products ORDER BY created_at DESC");
    while($p = $stmt->fetch(PDO::FETCH_ASSOC)):
    ?>
    <div class="box">
      <div class="img-container">
        <img src="/uploads/<?=htmlspecialchars($p['image'] ?? 'no-image.png')?>" alt="">
      </div>
      <h3><?=htmlspecialchars($p['name'])?></h3>
      <p><?=htmlspecialchars($p['description'])?></p>
      <p class="price">$<?=number_format($p['price'],2)?></p>
      <button class="add-to-cart" data-id="<?=$p['id']?>" data-price="<?=$p['price']?>">Add to cart</button>
    </div>
    <?php endwhile; ?>
  </div>
</section>

<?php include 'inc/footer.php'; ?>
