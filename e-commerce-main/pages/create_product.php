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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
        </div>
        <div class="container mt-5">
        <?php include_once("../model/Items.php") ?>
        <?php include("new_product.php") ?>
        <div class="list">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>igmUrl</th>
                        <th>Item Name</th>
                        <th>Price</th>

                    </tr>
                </thead>
                <!-- START MAO NI ATONG E LOOP UNYA -->
                <?php
                    $result  = Items::getAll();

                    if($result->num_rows > 0){
                         while($row = $result->fetch_assoc()){
                ?>
                    <tr> 
                        <td><?=$row["ID"]?></td>
                        <td><?=$row["imgUrl"]?></td>
                        <td><?=$row["itemName"]?></td>
                        <td><?=$row["price"]?></td>
                        <td>
                        <a href="update_product.php?id=<?=$row["ID"]?>" class="btn btn-info">Edit</a>
                        </td>
                    </tr>
          
                  <?php
                        } //CLOSING SA WHILE
                    } // CLOSING SA IF
                  ?>
                <!-- END MAO NI ATONG E LOOP UNYA -->
            </table>
        </div>
    </div>
    </main>


    <footer class="footer">
        <?php
        include($footer);
        ?>
    </footer>
</body>

</html>