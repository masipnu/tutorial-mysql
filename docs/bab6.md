# Tabel Virtual

*View* adalah objek di dalam database yang berisi kumpulan kolom yang dihasilkan dari perintah `SELECT`. Sederhananya *view* adalah objek yang menyimpan hasil *query*, baik dari satu tabel atau lebih. *View* juga sering disebut sebagai **tabel virtual**, karena *view* sebenranya tidak memiliki data. Data yang ditampilkan oleh *view* diambil dari tabel-tabel aktual yang disertakan dalam perintah `SELECT`.

## Mengapa Perlu Menggunakan Tabel Virtual?
Dalam pengelolaan database, view memiliki manfaat bagi kita, di antaranya:

1. Akses data menjadi lebih mudah.
    - Dapat digunakan untuk menampilkan rangkuman dari suatu perhitungan tertentu.
    - Dapat menampilkan beberapa kolom atau beberapa baris saja dari suatu tabel, tergantung dari kondisi yang didefinisikan.
    - Dapat digunakan untuk menampilkan data yang berasal dari dua tabel atau lebih.
2. View dapat digunakan untuk menampilkan data yang berbeda untuk masing-masing user, sehingga setiap user hanya dapat melihat data yang sesuai dengan hak aksesnya.

Pada kasus-kasus tertentu, data yang terdapat dalam satu view juga harus dapat dimodifikasi menggunakan perintah `INSERT`, `UPDATE` maupun `DELETE`. Jika data dalam suatu view diubah, sebenarnya yang berubah adalah data pada *base table*.

## Membuat View
Dalam MySQL, view dibuat menggunakan perintah `CREATE VIEW`. Berikut sintaks umum yang digunakan.
```sql
CREATE VIEW [nama_view] AS [perintah SELECT];
```
Sekarang kita buat view-nya.
```sql
CREATE VIEW v_buku AS
SELECT
    a.buku_isbn,
    a.buku_judul,
    b.penerbit_nama,
    a.buku_tglterbit,
    a.buku_jmlhalaman,
    a.buku_harga
FROM
    buku a,
    penerbit b
WHERE
    a.penerbit_id = b.penerbit_id
ORDER BY
    a.buku_judul;
```
Perintah di atas akan mendefinisikan *view* di dalam database dengan nama **v_buku**. *View* tersebut berisi perintah `SELECT` yang melibatkan dua tabel, yaitu **buku** dan **penerbit**. Kolom relasi antara dua tabel tersebut adalah kolom **penerbit_id**.

Sekarang kita bisa menampilkan data buku dengan `SELECT` view tersebut, berikut *query*-nya.
```sql
SELECT * FROM v_buku;
```

## Melihat Daftar Kolom di dalam view
Sama halnya seperti pada objek tabel, kita juga dapat melihat daftar kolom yang terdapat di dalam suatu *view*. Untuk melakukan hal ini kita bisa menjalankan *query*. Contoh:
```sql
DESC v_buku;
```

## Mengubah View
Untuk mengubah definisi dari suatu *view* yang sebelumnya sudah dibuat, kita perlu menggunakan perintah `ALTER VIEW`. Perintah ini akan membuang atau menghapus definisi *view* yang lama dan menimpanya dengan definisi *view* yang baru.
Format *query*-nya sebagai berikut.
```sql
ALTER VIEW [nama_view] AS [perintah SELECT yang baru]
```

Sekarang perhatikan dan jalankan *query* berikut.
```sql
ALTER VIEW v_buku AS
SELECT
    a.buku_isbn,
    a.buku_judul,
    b.penerbit_nama,
    a.buku_harga
FROM
    buku a,
    penerbit b
WHERE
    a.penerbit_id = b.penerbit_id
ORDER BY
    a.buku_judul;
```

## Menghapus View
Kita dapat menghapus satua tau lebih view yang terdapat di dalam database dengan menggunakan perintah `DROP VIEW`. Format umum *query*-nya adalah sebagai berikut.
```sql
DROP VIEW [IF EXISTS] [nama_view];
```
`IF EXISTS` bersifat opsional dan berfungsi untuk mencegah terjadinya kesalahan pada saat perintah tersebut dieksekusi, yaitu dengan cara melakukan pemeriksaan terlebih dahulu, apakah *view* yang akan dihapus tersebut ada di dalam database atau tidak.

Jika nama *view* yang disertakan dalam perintah `DROP VIEW` ternyata tidak ada, maka server MySQL akan mengeluarkan pesan peringatan/ *warning*. Kitadapat menampilkan isi peringatan tersebut dengan perintah `SHOW WARNINGS`.

Perhatikan *query* berikut.
```sql
DROP VIEW v1, v2;
```
*Query* di atas akan menghapus dua *view* sekaligus. Sekarang jalankan *query* berikut untuk menghapus *view* `v_buku`.

```sql
DROP VIEW v_buku;
```

## Membuat View yang Dapat Dimodifikasi
Suatu *view* dapat dimodifikasi jika kolom-kolom dalam *view* tersebut mengacu langsung ke kolom yang terdapat pada *base tabel*, bukan hasil proses perhitungan. Sebagai contoh, coba perhatikan dan jalankan *query* berikut.

Membuat view **v_jmlBukuPerPenerbit**
```sql
CREATE VIEW v_jmlBukuPerPenerbit AS
SELECT
    b.penerbit_nama "Nama Penerbit",
    COUNT(a.buku_judul) "Jumlah Buku"
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
*View* tersebut berfungsi untuk menampilkan laporan jumlah buku per penerbit. Untuk melihat hasilnya jalankan *query* berikut.
```sql
SELECT * FROM v_jmlBukuPerPenerbit;
```
*View* di atas merupakan *view* yang tidak dapat dimodifikasi, karena data yang ditampilkan merupakan hasil proses perhitungan dari fungsi `COUNT()`.

Sekarang kita coba membuat *view* yang bisa dimodifikasi. Perhatikan dan jalankan *query* berikut.

Membuat view **v_jmlHalaman**
```sql
CREATE VIEW v_jmlHalaman AS
SELECT
    buku_isbn,
    buku_judul,
    buku_jmlhalaman
FROM
    buku
ORDER BY
    buku_isbn;
```
Selanjutnya kita coba lihat data yang disajikan dari *view* di atas.
```sql
SELECT * FROM v_jmlHalaman
WHERE
    buku_isbn = "999-1555-2-1";
```
Perhatikan hasilnya, maka akan menampilkan 1 baris data.
Sekarang kita coba lakukan modifikasi terhadap view tersebut dengan *query* berikut.
```sql
UPDATE v_jmlHalaman
SET
    buku_halaman = buku_halaman + 10
WHERE
    buku_isbn = "999-1555-2-1";
```
Setelah berhasil mengupdate *view* **v_jmlHalaman**, kita coba ulangi perintah berikut dan perhatikan hasilnya.
```sql
SELECT * FROM v_jmlHalaman
WHERE
    buku_isbn = "999-1555-2-1";
```

Perhatikan nilai dari kolom **buku_jmlhalaman**. Nilai yang ditampilkan sekarang adalah 280, yang awalnya bernilai 270. Ini terjadi karena kita telah melakukan modifikasi terhadap *view* **v_jmlHalaman** menggunakan perintah `UPDATE`.

Data yang sebenarnya diubah adalah data pada kolom tabel yang diakses, bukan data di dalam *view* yang bersangkutan. karena secara fisik *view* tidak pernah memiliki data. Karena inilah *view* sering disebut sebagai tabel virtual. Untuk membuktikan hal ini sekarang mari kita lihat datanya langsung dari tabel asli.

```sql
SELECT
    buku_isbn,
    buku_judul,
    buku_jmlhalaman
FROM
    buku
WHERE
    buku_isbn = "999-1555-2-1";
```
Hasil yang diperoleh akan sama seperti pada asat kita mengaksesnya melalui *view* **v_jmlHalaman**.

## Batasan-batasan dalam Penggunaan View
Pendefinisian *view* dapat menggunakan klausa-klausa yang terdapat pada perintah `SELECT`, seperti `WHERE`, `GROUP BY`, `ORDER BY` dan lain-lain. Namun demikian ada batasan-batasan yang perlu diperhatikan, yaitu:

1. Kita tidak dapat membuat *view* temporari
2. Kita tidak dapat mengasosiasikan *trigger* dengan *view*
3. Tabel-tabel yang diakses oleh *view* harus ada di dalam database. Jika nama tabel diubah, maka *view* tidak dapat digunakan lagi, karena terjadi kesalahan pada saat dieksekusi
4. Perintah `SELECT` yang didefinisikan di dalam *view* tidak boleh berisi kontruksi-kontruksi berikut:
    - *Subquery* di dalam klausa `FROM`
    - Mengacu ke tabel temporari