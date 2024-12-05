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

    $btnCari = $_POST['btnCari'];

    if (!isset($btnCari)) {
        exit();
    }

    $comboCari = $_POST['comboCari'];
    $txtCari = $_POST['txtCari'];

    switch ($comboCari) {
        case 0:
            $label = "Hasil pencarian buku <u>berdasarkan judul</u> '<strong>$txtCari</strong>':";
            $str = "upper(a.buku_judul) like upper('%$txtCari%')";
            break;
        case 1:
            $label = "Hasil pencarian buku berdasarkan <u>nama pengarang</u> '<strong>$txtCari</strong>':";
            $str = "upper(c.pengarang_nama) like upper('%$txtCari%')";
            break;
        case 2:
            $label = "Hasil pencarian buku berdasarkan <u>nama penerbit</u> '<strong>$txtCari</strong>':";
            $str = "upper(b.penerbit_nama) like upper('%$txtCari%')";
            break;
    }
    ?>

    <h2>Hasil Pencarian Buku</h2>

    <p><?php echo $label ?></p>
    <br>
    <?php
    $query = "SELECT DISTINCT
        a.buku_isbn,
        a.buku_judul,
        b.penerbit_nama,
        a.buku_harga
        FROM
        buku a,
        penerbit b,
        pengarang c,
        link_buku_pengarang d
        WHERE
        a.penerbit_id = b.penerbit_id AND
        a.buku_isbn = d.buku_isbn AND
        c.pengarang_id = d.pengarang_id AND " . $str;
    
    $result = mysqli_query($link, $query);
    if ($result) {
        ?>

        <table class="buku">
            <tr>
                <th width="50">ISBN</th>
                <th width="280">Judul</th>
                <th width="150">Penerbit</th>
                <th width="100">Harga</th>
                <th>Detail</th>
            </tr>
            <?php
            while ($row = mysqli_fetch_array($result)){
                ?>
            <tr>
                <td><?= $row[0]; ?></td>
                <td align="left"><?= $row[1];?></td>
                <td align="left"><?= $row[2];?></td>
                <td align="right">
                    <?= "Rp. " . number_format($row[3],0,'','.') . ",-"; ?>
                </td>
                <td>
                    <a href="detail_buku.php?isbn=<?= $row[0]; ?>">Lihat Detail</a>
                </td>
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