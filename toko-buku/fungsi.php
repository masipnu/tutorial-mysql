<?php

include "config.php";

function getKategori($id){
    global $link;
    $query = "SELECT kategori_nama FROM kategori WHERE kategori_id = $id";

    $nama_kategori = "";
    $result = mysqli_query($link, $query);
    if ($result) {
        list($nama_kategori) = mysqli_fetch_array($result);
        mysqli_free_result($result);
    }

    return $nama_kategori;
}

?>