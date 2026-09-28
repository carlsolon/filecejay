<?php
$path = "../widgets/";
$pathTwo = "./headers/";
$content = $path . "item.php";
$header = $pathTwo . "header.php";
$navi = $path . "main_menu.php";
$footer = $pathTwo . "footer.php";
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>product</title>
    <link rel="stylesheet" href="../style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>

<body>
    <header class="header">
        <?php
        include($header);
        ?>
    </header>
    <main>
        <div class="about">
          
            <p class="ab">
            <h1>Introduce</h1>
            Your premier destination for the 
            latest and greatest in sneaker fashion. At 3SX KICKS, we pride ourselves 
            on offering a diverse selection of shoes that cater to every style and 
            preference. From classic retro designs that evoke a sense of nostalgia to
             cutting-edge contemporary styles that keep you ahead of the trend curve, our 
             collection is meticulously curated to ensure you find the perfect pair for any 
             occasion. Each shoe in our store is selected for its superior quality, comfort, 
             and unique design, guaranteeing that you'll not only look great, but feel great too.
            </p> 
            <p class="ab">
                <h1>Background</h1>
            3SX KICKS was established in the year of 2023, with our unwavering commitment to excellence and customer
            satisfaction. Our knowledgeable and passionate staff are always on hand to provide
            personalized recommendations and insights, helping you navigate our extensive 
            inventory to find the shoes that best suit your needs. Whether you're a seasoned 
            sneakerhead hunting for a rare addition to your collection or a casual shopper in
                search of reliable, stylish footwear, we strive to make your shopping experience 
                seamless and enjoyable. At 3SX KICKS, we believe in building lasting relationships 
                with our customers, ensuring that every visit leaves you more excited 
            about your purchase than the last.
            </p>
            <p class="ab">
                <h1>Mission</h1>
                3SX KICKS is dedicated to staying ahead of industry trends, 
                regularly updating our inventory with the latest releases from top brands 
                such as Nike, Adidas, Puma, and more. We also offer exclusive,
                limited-edition collaborations and drops that you won’t find anywhere else. 
                By fostering a vibrant community of sneaker enthusiasts and offering an unparalleled shopping experience both in-store and online, 3SX KICKS has become a go-to destination for those who live and breathe sneaker culture. Explore our collections today and discover why 3SX KICKS
                is the ultimate hub for all your sneaker needs.</p>
                    </div>
    </main>


    <footer class="footer">
        <?php
        include($footer);
        ?>
    </footer>
</body>

</html>