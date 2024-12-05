<?php

$host = "localhost";
$user = "root";
$pass = "root";
$db = "buku_db";

$link = mysqli_connect($host, $user, $pass, $db);

if (mysqli_connect_errno()) {
    echo "Koneksi ke server MySQL gagal!";
    exit();
} else {
    // echo "Koneksi ke server MySQL berhasil!";
}

?>