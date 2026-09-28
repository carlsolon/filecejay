<?php
include("../model/Items.php");

$list = array(
    new Items("../img/newkobe.jpg", " 𝗞𝗢𝗕𝗘 𝟴 𝗪𝗛𝗜𝗧𝗘 𝗕𝗥𝗘𝗗", " ₱𝟏𝟗𝟗𝟗"),
    new Items("../img/jordanLow.jpg", " 𝗝𝗢𝗥𝗗𝗔𝗡 𝟭 𝗟𝗢𝗪 𝗦𝗔𝗜𝗟 𝗥𝗔𝗧𝗧𝗔𝗡", " ₱𝟭𝟱𝟵𝟵"),
    new Items("../img/panda.jpg", " 𝗡𝗜𝗞𝗘 𝗦𝗕 𝗗𝗨𝗡𝗞 𝗣𝗔𝗡𝗗𝗔", " ₱𝟭𝟲𝟵𝟵"),
    new Items("../img/pre.jpg", " 𝗣𝗥𝗘𝗖𝗜𝗦𝗜𝗢𝗡 𝟲 𝗭𝗢𝗢", " ₱𝟭𝟲𝟵𝟵"),
    new Items("../img/pre2.jpg", " 𝗣𝗥𝗘𝗖𝗜𝗦𝗜𝗢𝗡 𝟲 𝗕𝗟𝗨𝗘 𝗕𝗟𝗔𝗦𝗧", " ₱𝟭𝟲𝟵𝟵"),
    new Items("../img/pre3.jpg", " 𝗣𝗥𝗘𝗖𝗜𝗦𝗜𝗢𝗡 𝟲 𝗗𝗥𝗔𝗚𝗢𝗡 𝗦𝗖𝗥𝗔𝗧𝗖𝗛", " ₱𝟭𝟲𝟵𝟵"),
    new Items("../img/pre7.jpg", " 𝐍𝐈𝐊𝐄 𝐏𝐑𝐄𝐂𝐈𝐒𝐈𝐎𝐍 𝟕 𝐁𝐋𝐀𝐂𝐊 𝐑𝐄𝐃 ", " ₱𝟏𝟗𝟗𝟗"),
    new Items("../img/pre8.jpg", " 𝐍𝐈𝐊𝐄 𝐆𝐓 𝐂𝐔𝐓 𝟑 𝐔𝐍𝐈𝐓𝐄𝐃 𝐒𝐓𝐀𝐓𝐄𝐒 ", " ₱𝟏𝟖𝟗𝟗"),
    new Items("../img/pre9.jpg", " 𝐋𝐄𝐁𝐑𝐎𝐍 𝐀𝐌𝐁𝐀𝐒𝐒𝐀𝐃𝐎𝐑 𝟏𝟑 𝐖𝐎𝐋𝐅 𝐆𝐑𝐄𝐘 ", " ₱𝟏𝟗𝟗𝟗"),
    new Items("../img/pre10.jpg", " 𝐀𝐃𝐈𝐃𝐀𝐒 𝐀𝐍𝐓𝐇𝐎𝐍𝐘 𝐄𝐃𝐖𝐀𝐑𝐃𝐒 𝐂𝐇𝐀𝐑𝐂𝐎𝐀𝐋 ", " ₱𝟐𝟏𝟗𝟗"),
    new Items("../img/pre11.jpg", " 𝐈𝐌𝐌𝐎𝐑𝐓𝐀𝐋𝐈𝐓𝐘 𝟑 𝐃𝐄𝐒𝐄𝐑𝐓 𝐁𝐄𝐑𝐑𝐘 ", " ₱𝟏𝟖𝟗𝟗"),
    new Items("../img/pre12.jpg", " 𝐍𝐈𝐊𝐄 𝐆𝐓 𝐂𝐔𝐓 𝟑 𝐏𝐈𝐂𝐀𝐍𝐓𝐄 𝐑𝐄𝐃 ", " ₱𝟏𝟖𝟗𝟗")

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

<script>// Function to add item to the cart
function addCart(itemName, price, imgUrl) {
  // Create an item object
  const item = {
    name: itemName,
    price: price,
    img: imgUrl
  };
}