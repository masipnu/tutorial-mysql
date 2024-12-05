<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toko Buku Online</title>
    <link rel="stylesheet" href="css/framelayout.css">
</head>
<body>

<?php
include "config.php";
include "fungsi.php";

$id_kategori = $_GET['kat'];
$nama_kategori = getKategori($id_kategori);
?>

<h2>Daftar Buku <?php echo "$nama_kategori"; ?></h2>

<?php
$query = "SELECT
a.buku_isbn,
a.buku_judul,
b.penerbit_nama,
a.buku_harga
FROM
buku a,
penerbit b,
link_buku_kategori c
WHERE
a.penerbit_id = b.penerbit_id AND
a.buku_isbn = c.buku_isbn AND
c.kategori_id = $id_kategori";

$result = mysqli_query($link, $query);
if ($result) { ?>

<table class="buku">
    <tr>
        <th width="100">ISBN</th>
        <th width="280">Judul</th>
        <th width="150">Penerbit</th>
        <th width="100">Harga</th>
        <th width="80">Detail</th>
    </tr>

    <?php
    while ($row = mysqli_fetch_array($result)) { ?>

    <tr>
        <td> <?php echo $row[0];?> </td>
        <td align="left"> <?php echo $row[1];?> </td>
        <td align="left"> <?php echo $row[2];?> </td>
        <td align="right"> <?php echo "Rp. " . number_format($row[3],0,'','.') . ",-" ;?> </td>
        <td > <a href="detail_buku.php?isbn=<?php echo $row[0]; ?> ">Lihat Detail</a> </td>
    </tr>
    <?php
    }
    ?>
</table>
<?php
mysqli_free_result($result);
}
?>

</body>
</html>