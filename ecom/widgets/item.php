<?php
include("../model/Items.php");

$list = array(
    new Items("../img/newkobe.jpg", " 𝗞𝗢𝗕𝗘 𝟴 𝗪𝗛𝗜𝗧𝗘 𝗕𝗥𝗘𝗗", " ₱𝟏𝟗𝟗𝟗"),
    new Items("../img/jordanLow.jpg", " 𝗝𝗢𝗥𝗗𝗔𝗡 𝟭 𝗟𝗢𝗪 𝗦𝗔𝗜𝗟 𝗥𝗔𝗧𝗧𝗔𝗡", " ₱𝟭𝟱𝟵𝟵"),
    new Items("../img/panda.jpg", " 𝗡𝗜𝗞𝗘 𝗦𝗕 𝗗𝗨𝗡𝗞 𝗣𝗔𝗡𝗗𝗔", " ₱𝟭𝟲𝟵𝟵"),
    new Items("../img/pre.jpg", " 𝗣𝗥𝗘𝗖𝗜𝗦𝗜𝗢𝗡 𝟲 𝗭𝗢𝗢", " ₱𝟭𝟲𝟵𝟵"),
    new Items("../img/pre2.jpg", " 𝗣𝗥𝗘𝗖𝗜𝗦𝗜𝗢𝗡 𝟲 𝗕𝗟𝗨𝗘 𝗕𝗟𝗔𝗦𝗧", " ₱𝟭𝟲𝟵𝟵"),
    new Items("../img/pre3.jpg", " 𝗣𝗥𝗘𝗖𝗜𝗦𝗜𝗢𝗡 𝟲 𝗗𝗥𝗔𝗚𝗢𝗡 𝗦𝗖𝗥𝗔𝗧𝗖𝗛", " ₱𝟭𝟲𝟵𝟵")

)
?>
<div class="productItem">
    <div class="listing">
        <?php
        foreach ($list as $item) {
            include("../widgets/item_card.php");
        }
        ?>
    </div>
</div>