<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toko Buku Online</title>
    <link rel="stylesheet" href="layout.css">
</head>
<body>
    <div id="wrap">
        <div id="header">
            <h1>Toko Buku Online</h1>
        </div>
        <div id="nav">
            <ul>
                <li><a href="index.php">Home</a> | </li>
                <li><a href="pesan.php" target="frmMain">Prosedur Pemesanan</a> | </li>
                <li><a href="tentangkami.php" target="frmMain">Tentang Kami</a> | </li>
                <li><a href="kontak.php" target="frmMain">Kontak</a></li>
            </ul>
            <br>
            <center>
                <form action="cari.php" method="post" target="frmMain">
                    <strong>Pencarian buku:</strong>
                    <select name="comboCari" id="">
                        <option value="0">Berdasarkan Judul</option>
                        <option value="1">Berdasarkan Pengarang</option>
                        <option value="2">Berdasarkan Penerbit</option>
                    </select>
                    <input type="text" name="txtCari" size="45">
                    <input type="submit" name="btnCari" value="Go">
                </form>
            </center>
        </div>

        <div id="main">
            <iframe width="690" height="450" name="frmMain" scrolling="auto" src="welcome.php" frameborder="0">

            </iframe>
        </div>

    </div>

    <div id="sidebar">
        <h2>Kategori Buku</h2>
        <?php include "kategori.php"; ?>
    </div>

    <div id="footer">
        Copyright &copy; 2024 | Toko Buku Online
    </div>
    
</body>
</html>