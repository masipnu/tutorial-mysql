<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toko Buku Online</title>
    <link rel="stylesheet" href="css/layout.css">
</head>
<body>
    
<?php
include "config.php";

$query = "SELECT kategori_id, kategori_nama FROM kategori ORDER BY kategori_nama";
$result = mysqli_query($link, $query);
if ($result) {
    ?>
    <ul>
        <?php

        while ($row = mysqli_fetch_array($result)) {
            ?>
            <li>
                <a href="daftar_buku.php?kat=<?php echo $row[0];?>" target="frmMain"><?php echo $row[1]; ?></a>
            </li>
            <?php
        }
        mysqli_free_result($result);
        ?>
    </ul>
    <?php
}
?>

</body>
</html>