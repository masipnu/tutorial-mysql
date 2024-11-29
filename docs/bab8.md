# Fungsi Agregasi

Fungsi Agregasi adalah fungsi di dalam MySQL yang digunakan untuk melakukan perhitungan pada *query*. Pada umumnya penggunaannya dikombinasikan dengan klausa `GROUP BY` untuk menghasilkan rangkuman nilai yang dikelompokkan berdasarkan nilai tertentu.

Berikut ini beberapa fungsi yang termasuk dalam fungsi agregasi:

  - Fungsi MIN()
  - Fungsi MAX()
  - Fungsi SUM()
  - Fungsi COUNT()
  - Fungsi AVG()
  - Fungsi GROUP_CONCAT()


## Fungsi MIN()

- `MIN()` berfungsi untuk mengembalikan nilai terkecil dari suatu kolom.
- Jika fungsi `MIN()` digunakan pada kolom bertipe numerik, maka akan mengembalikan angka terkecil, jika diterapkan pada kolom bertipe karakter, maka akan mengembalikan karakter dengan urutan alfabet paling awal. Berikut contohnya.

Menampilkan jumlah halaman paling sedikit
```sql
SELECT MIN(buku) FROM buku;
```

Menampilkan urutan abjad paling awal dari judul buku
```sql
SELECT MIN(buku_judul) FROM buku;
```

## Fungsi MAX()

- `MAX()` merupakan kebalikan dari fungsi `MIN()`.
- `MAX()` berfungsi mengembalikan nilai terbesar dari sebuah kolom.
- `MAX()` bisa diterapkan pada kolom bertipe numerik maupun teks.

Contoh, menampilkan halaman buku terbanyak.
```sql
SELECT MAX(buku_jmlhalaman) FROM buku;
```

Menampilkan buku dengan abjad paling akhir.
```sql
SELECT MAX(buku_judul) FROM buku;
```

## Fungsi SUM()

`SUM()` berguna untuk menjumlahkan nilai dari suatu kolom dalam tabel tertentu. Contoh:
```sql
SELECT SUM(buku_jmlhalaman) FROM buku;
```
Nilai yang tampil merupakan total dari semua jumlah halaman buku pada kolom `buku_jmlhalaman`.


## Fungsi COUNT()

Berbeda dengan `SUM()`, fungsi `COUNT()` akan mengembalikan jumlah baris data pada kolom dari tabel tertentu.

Contoh, menampilkan jumlah buku dari penerbit dengan `penerbit_id` = `PB06`.
```sql
SELECT COUNT(*)
FROM buku
WHERE penerbit_id = 'PB06';

```

Untuk lebih membuktikan, coba kita cek dengan cara biasa.
```sql
SELECT
    buku_isbn,
    buku_judul
FROM
    buku
WHERE
    penerbit_id = 'PB06';
```

## Fungsi AVG()

Berfungsi untuk mendapatkan nilai rata-rata dari suatu kolom. Sebagai contoh, kita ibsa menghitung nilai rata-rata dari jumlah halaman buku dengan kode penerbit `PB06` dengan perintah berikut.

```sql
SELECT
    AVG(buku_jmlhalaman)
FROM
    buku
WHERE
    penerbit_id = 'PB06';
```

Untuk lebih membuktikan, silahkan jalankan perintah berikut dan hitung rata-rata kolom `buku_jmlhalaman` secara manual.
```sql
SELECT
    buku_isbn,
    buku_judul,
    penerbit_id,
    buku_jmlhalaman
FROM
    buku
WHERE 
    penerbit_id = 'PB06';
```

## Fungsi GROUP_CONCAT()

- `GROUP CONCAT` merupakan fungsi agregasi yang hanya disediakan oleh MySQL, dalam SQL standar tidak tersedia.
- Fungsinya adalah untuk menyambung beberapa baris data dari suatu kolom menjadi sebuah teks tunggal.

Contoh, menampilkan data nama penerbit dari tabel penerbit.
```sql
SELECT penerbit_nama
FROM penerbit;
```

Selanjutnya kita ubah *query* nya sebagai berikut.
```sql
SELECT GROUP_CONCAT(penerbit_nama)
FROM penerbit;
```

Hasilnya, semua baris data akan digabungkan menjadi 1 baris.

Dalam kasus yang lebih nyata, kita bisa mengelompokkan daftar buku sesuai nama penerbit. berikut *query*-nya.
```sql
SELECT
    b.penerbit_nama,
    GROUP_CONCAT(a.buku_judul)
FROM
    buku a,
    penerbit b
WHERE
    a.penerbit_id = b.penerbit_id
GROUP BY
    b.penerbit_nama
ORDER BY
    b.penerbit_nama;
```

Fungsi `GROUP_CONCAT()` memiliki beberapa bentuk penggunaan, yaitu:

- Dalam keadaan standar (*default*), pemisah yang digunakan adalah tanda koma (,). Kita dapat mengubah pemisah tersebut menggunakan karakter lain dengan menambahkan klausa `SEPARATOR`, contoh:
```sql
SELECT
    GROUP_CONCAT(penerbit_nama SEPARATOR ' - ')
FROM
    penerbit;
```

- Kita dapat menggunakan `ORDER BY` untuk mengurutkan nilai yang akan digabung dalam teks tunggal, contoh:
```sql
SELECT
    GROUP_CONCAT(penerbit_nama ORDER BY penerbit_nama)
FROM
    penerbit;
```

- Jika terdapat duplikasi nilai yang akan digabung ke dalam teks tunggal, maka nilai duplikat tersebut dapat dihilangkan menggunakan klausa `DISTINCT`, contoh:
```sql
SELECT
    GROUP_CONCAT(DISTINCT penerbit_nama)
FROM
    penerbit;
```


## Fungsi Agregasi Pada Nilai NULL

Secara umum, fungsi-fungsi agregasi akan mengabaikan nilai `NULL`, kecuali `COUNT()`. Fungsi `COUNT()` memiliki sifat:

- `COUNT()` tidak akan mengabaikan nilai `NULL`
- `COUNT([ekspresi])` dan `COUNT(DISTINCT)` akan mengabaikan nilai `NULL`

Untuk membuktikan hal tersebut, kita buat contoh tabel baru `tnull`.
```sql
CREATE TABLE tnull(
    a int
);
```

Memasukkan data ke dalam tabel `tnull`
```sql
INSERT INTO tnull VALUES
(1),
(NULL),
(NULL),
(NULL),
(NULL);
```

Sekarang kita buktikan sifat pertama.
```sql
SELECT COUNT(*) 
FROM tnull;
```
Hasilnya adalah 5, karena nilai `NULL` tetap dihitung.

Sekarang kita buktikan sifat kedua.
```sql
-- Query-1
SELECT COUNT(DISTINCT a)
FROM tnull;

-- Query-2
SELECT COUNT(a)
FROM tnull;
```
Hasilnya adalah 1 karena nilai `NULL` tidak dihitung sebagai 1 baris data, dengan kata lain `NULL` diabaikan.

Perintah `SELECT` mungkin saja menghasilkan baris kosong atau nilai `NULL` di setiap barisnya. Jika kita menggunakan fungsi agregasi pada kolom yang berisi baris kosong atau nilai `NULL` di setiap baris yang ada, maka:

- Untuk fungsi `COUNT()`, nilai yang dihasilkan adalah 0 (nol)
- Untuk fungsi `MIN()`, `MAX()`, `SUM()`, `AVG()` dan `GROUP_CONCAT()` akan menghasilkan nilai `NULL`

Sebagai bukti, coba kita hapus 1 baris data yang berisi nilai non-`NULL`.
```sql
DELETE FROM tnull
WHERE a=1;
```
Lalu kita cek data yang tersisa
```sql
SELECT * FROM tnull;
```

Selanjutnya kita coba eksekusi satu-persatu fungsi agregasi untuk mengetahui nilai yang dikembalikan.

```sql
SELECT COUNT(a) FROM tnull;
```
Perintah di atas akan menghasilkan nilai 0 (nol), namun jika kita mencoba fungsi agregasi yang lain,

```sql
SELECT MIN(a) FROM tnull;
SELECT MAX(a) FROM tnull;
SELECT SUM(a) FROM tnull;
SELECT AVG(a) FROM tnull;
SELECT GROUP_CONCAT(a) FROM tnull;
```
Semua perintah di atas akan menghasilkan nilai `NULL`.