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
$isbn = $_GET['isbn'];
?>

<h2>Detail Buku</h2>

<?php
$query = "SELECT
a.buku_isbn,
a.buku_judul,
c.pengarang_nama,
b.penerbit_nama,
a.buku_harga,
a.buku_tglterbit,
a.buku_jmlhalaman,
a.buku_deskripsi
FROM
buku a,
penerbit b,
pengarang c,
link_buku_pengarang d
WHERE
a.penerbit_id = b.penerbit_id AND
a.buku_isbn = d.buku_isbn AND
c.pengarang_id = d.pengarang_id AND
a.buku_isbn = '$isbn'
";

$result = mysqli_query($link, $query);
if ($result) {
    list($buku_isbn, $buku_judul, $pengarang_nama, $penerbit_nama, $buku_harga,
    $buku_tglterbit, $buku_jmlhalaman, $buku_deskripsi) = mysqli_fetch_array($result);
?>

<table class="buku">
    <tr>
        <td width="200" align="left">ISBN</td>
        <td width="490" align="left">
            <strong><?php echo $buku_isbn; ?></strong>
        </td>
    </tr>
    <tr>
        <td width="200" align="left">Judul</td>
        <td width="490" align="left">
            <strong><?php echo $buku_judul; ?></strong>
        </td>
    </tr>
    
    <tr>
        <td width="200" align="left">Pengarang</td>
        <td width="490" align="left">
            <strong><?php echo $pengarang_nama; ?></strong>
        </td>
    </tr>

    <tr>
        <td width="200" align="left">Penerbit</td>
        <td width="490" align="left">
            <strong><?php echo $penerbit_nama; ?></strong>
        </td>
    </tr>

    <tr>
        <td width="200" align="left">Harga</td>
        <td width="490" align="left">
            <strong><?php echo $buku_harga; ?></strong>
        </td>
    </tr>

    <tr>
        <td width="200" align="left">Tanggal Terbit</td>
        <td width="490" align="left">
            <strong><?php echo $buku_tglterbit; ?></strong>
        </td>
    </tr>

    <tr>
        <td width="200" align="left">Jumlah Halaman</td>
        <td width="490" align="left">
            <strong><?php echo $buku_jmlhalaman; ?></strong>
        </td>
    </tr>

    <tr>
        <td width="200" align="left">Deskripsi</td>
        <td width="490" align="left">
            <strong><?php echo $buku_deskripsi; ?></strong>
        </td>
    </tr>
</table>

<?php
mysqli_free_result($result);
}
?>

<p>
    <input type="button" value="Pesan" onClick="document.location.href='pesan.php'">
</p>
</body>
</html>