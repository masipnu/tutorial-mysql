# Operator dan Fungsi

- MySQL menyediakan banyak operator dan fungsi *built-in* yang dapat bermanfaat dalam pembuatan *query*.
- Fungsi *built-in* adalah fungsi siap pakai yang sudah didefinisikan oleh MySQL untuk menunjang kemudahan bagi para penggunanya.
- Pada umumnya operator dan fungsi digunakan pada perintah `SELECT` dan klausa `WHERE`.

Beberapa fungsi yang sering dipakai dapat dikelompokkan menjadi:

- Fungsi Teks
- Fungsi Bilangan
- Fungsi Tanggal dan Waktu
- Fungsi Konversi / *Typecasting*

## Operator

- Operator merupakan simbol-simbol khusus yang digunakan untuk melakukan operasi-operasi tertentu, misalnya perhitungan, perbandingan dua nilai dan lain-lain.
- Ketika menulis sebuah *query* kita akan sering menggunakan operator.
- Operator dapat dikategorikan menjadi:
    - Operator Aritmatika
    - Operator Relasional
    - Operator Logika

### Operator Aritmatika

Operator aritmatika digunakan untuk melakukan perhitungan di dalam *query* maupun prosedur/ fungsi. Berikut daftarnya

|Operator   |Keterangan|
|-|-|
|+|Untuk melakukan operasi penjumlahan|
|-|Untuk melakukan operasi pengurangan|
|*|Untuk melakukan operasi perkalian|
|/|Untuk melakukan operasi pembagian|

Contoh kasus, kita akan menghitung harga buku tertentu yang sudah didiskon sebanyak 25%.
```sql
SELECT
    buku_judul 'Judul',
    buku_harga 'Harga Normal',
    buku_harga - (0.25 * buku_harga) 'Harga Diskon 25%'
FROM
    buku
WHERE
    buku_isbn IN ('222-34222-1-0','222-34222-1-1')
```

### Operator Relasional

Operator relasional digunakan untuk membandingkan dua nilai atau ekspresi. Berikut tabel operator-operator yang termasuk.

|Operator|Keterangan|
|-|-|
| = | Sama dengan|
| != atau <>| Tidak sama dengan|
| < | Lebih kecil|
|<= | Lebih kecil atau sama dengan|
| > | Lebih besar|
| >= | Lebih besar atau sama dengan|
| *n* `BETWEEN` *min* `AND` *max* | Memeriksa *n* apakah berada di dalam rentang *min* dan *max* atau tidak|
| *n* `IN` (*set*) | Memeriksa keanggotaan himpunan (*set*), apakah *n* anggota dari himpunan yang didefinisikan atau tidak|
| *n* `IS NULL` | Memeriksa nilai *n* dengan nilai `NULL`|
| `ISNULL`(*n*) | Memeriksa nilai *n*, `NULL` atau tidak|

Sebagai contoh, kita akan menampilkan daftar buku yang harganya di bawah Rp. 50.000.
```sql
SELECT
    buku_isbn,
    buku_judul,
    buku_harga
FROM
    buku
WHERE
    buku_harga <= 50000
```

### Operator Logika

Oeprator logika berfungsi untuk memeriksa nilai kebenaran (*true* atau *false*). Berikut daftar operatornya.

|Operator   |Keterangan
|-|-|
|`AND` atau `&&` | Operasi logika AND|
|`OR` atau `||` | Operasi logika OR|
|`NOT` atau `!` | Operasi negasi|
|`XOR`|Operasi Exclusive OR|

Beberapa hal yang perlu diperhatikan ketika menggunakan operator logika:

- Dalam operasi `AND`, nilai *true* hanya diperoleh jika kedua ekspresi atau *operand* bernilai *true*, selain kondisi tersebut maka bernilai *false*
- Dalam operasi `OR`, nilai *false* hanya diperoleh jika kedua ekspresi atau *operand* bernilai *false*, selain kondisi tersebut maka bernilai *true*
- Dalam operasi `XOR`, nilai *true* hanya diperoleh jika salah satu (bukan keduanya) ekspresi atau *operand* bernilai *true*

Sebagai contoh, *query* berikut berfungsi untuk menampilakn data buku yang harganya di bawah atau sama dengan Rp. 50.000 dan memiliki kode penerbit `PB06`

```sql
SELECT
    buku_isbn,
    buku_judul,
    penerbit_id,
    buku_harga
FROM
    buku
WHERE
    buku_harga <= 50000 AND
    penerbit_id = 'PB06';
```

## Fungsi

### Fungsi Teks

- Fungsi teks adalah fungsi yang digunakan untuk memanipulasi teks, baik di dalam *query* maupun prosedur/ fungsi.
- Selain itu juga terdapat fungsi yang berguna untuk membandingkan dua teks, apakah sama atau tidak.


**Fungsi concat()**

`concat()` berfungsi untuk menyambung dua teks atau lebih, tergantung dari banyaknya parameter yang dilewatkans aat pemanggialn fungsi. Contoh:

```sql
SELECT CONCAT('Belajar',' ', 'MySQL')
```

**Fungsi length()**

Berfungsi untuk mengetahui jumlah karakter dari teks. Contoh:
```sql
SELECT LENGTH('Belajar MySQL');
```

**Fungsi locate()**

Berfungsi untuk mencari karakter atau bagian teks (*substring*) dari suatu teks. Contoh:

```sql
SELECT LOCATE('base', 'Pemrograman Database MySQL', 1);
```
*Query* di atas akan mencari teks `base` di dalam teks `Pemrograman Database MySQL` dimulai dari posisi karakter ke-1. Jika karakter yang dimaksud tidak ditemukan, maka MySQL akan mengembalikan nilai 0.

**Fungsi lower() dan upper()**

`lower()` berfungsi untuk mengubah teks menjadi huruf kecil, sedangkan `upper()` berfungsi mengubah teks menjadi huruf kapital. Contoh:

```sql
SELECT LOWER('BELAJAR');
SELECT UPPER('database');
```

**Fungsi quote()**

`quote()` digunakan untuk mengapit teks menggunakan tanda petik tunggal. Sebagai contoh, jika kita igin membuat teks untuk proses `INSERT` dalam suatu prosedur/ fungsi yang didefinisikan sendiri. Contoh:

```sql
SET @STR = 'MySQL';
SELECT @STR;
```
Perintah di atas akan memberikan hasil berupa string 'MySQL'. Sekarang coba yang ini.
```sql
SET @STR = quote('MySQL');
SELECT @STR;
```
Perintah tersebut akan menampilkan string 'MySQL' yang mengandung tanda kutip.

**Fungsi replace()**

Kita bisa mengganti bagian teks tertentu dengan fungsi ini. Contoh:
```sql
SELECT REPLACE(
    'Pemrograman Database',
    'Database',
    'MySQL'
)
```
Perintah di atas akan mengganti teks `Database` yang berada pada string `Pemrograman Database` dengan teks `MySQL`.

**Fungsi substring()**

Digunakan untuk mengambil karakter atau bagian teks (dengan jumlah tertentu) dari suatu teks. Contoh:

```sql
SELECT SUBSTRING('MySQL', 1, 2);
```
Perintah di atas akan mengambil 2 karakter dari teks `MySQL` dimulai dari karakter ke-1, sehingga menghasilkan teks `QL`.

**Fungsi trim()**

Pada kasus-kasus tertentu, sering kali terjadi data yang tersimpan di dalam dataabse memiliki format yang belum sempurna. Sebagai contoh, data yang seharusnya berupa 'MySQL', tapi pada kenyataannya di dalamd database tertulis 'My SQL' atau ' MySQL' (mengandung *whitespace* atau karakter kosong baik di depan atau di belakang teks).

Kesalahan data seperti ini biasanya (tanpa sengaja) dilakukan oleh pneggna aplikasi atau operator entri data. Sebagai contoh, secara tidak sadar pengguna aplikasi telah menekan tombol spasi pada saat sedang melakukan entri data. Dengan demikian, data yang tersimpan di dalam database juga akan ikut mengandung spasi.

Kasus semacam ini terkadang sering membuat pusing para programmer database dan DBA (*Database Administrator*) pada saat mereka menulis *query*. Pasalnya, emreka merasa bahwa *query* sudah tertulis dengan benar, tapi data atau hasil yagn ditampilkan tidak sesuai dengan keinginan.

Untuk mengatasi masalah tersebut, kita bisa menggunakan fungsi `trim()` pada saat membandingkan data berupa teks. Jika kita ingin menghilangkan *whitespace* di awal *string* kita gunakan `ltrim()`, sedangkan jika di akhir string menggunakan `rtrim()`. Contoh:

```sql
SELECT
    buku_isbn,
    buku_judul
FROM
    buku
WHERE
    TRIM(penerbit_id) = 'PB06';
```

### Fungsi Bilangan

Untuk mengolah data bilangan, MySQL sudah menyediakan beberapa fungsi. Berikut tabelnya.

|Fungsi | Keterangan|
|-|-|
|abs()|Mengembalikan nilai mutlak dari n. Misal `abs(-10)` akan mengembalikan nilai 10.|
|round()|Membulatkan bilangan desimal *n* menjadi bilangan bulat. Misal `round(3.45)` hasilnya 3.
|ceiling(n)|Pembulatan ke atas terdekat. Misal `ceiling(3.25)` menghasilkan 4.|
|floor(n)|Pembulatan ke bawah terdekat. Misal `floor(3.97)` menghasilkan nilai 3.|
|mod(n,m)|Operasi sisa hasil bagi/ *modulus*. Misal `mod(11,4)` menghasilkan nilai 3.|
|power(n,m)|Mengembalikan nilai *n* pangkat *m*. Misal `power(10,2)` hasilnya 100.|
|sqrt(n)|Mengembalikan akar pangkat 2 dari *n*. Misal `sqrt(4)` hasilnya 2.|
|rand(n)|Mengembalikan nilai acak (*random*) antara 0 dan 1. Parameter *n* bersifat opsional.|


### Fungsi Tanggal dan Waktu

Kolom bertipe tanggal dan waktu umumnya digunakan untuk mencatat kapan suatu transaksi atau kejadian terjadi dalam database.

| **Fungsi**                     | **Keterangan**                                                                 | **Contoh**                                                                                      |
|--------------------------------|--------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| `now()`                        | Mengembalikan tanggal dan waktu saat ini (tanggal penuh dengan jam, menit, detik). | `SELECT now();` hasil: `2024-11-29 10:15:30`                                                  |
| `curdate()`                    | Mengembalikan tanggal hari ini (hanya tanggal, tanpa waktu).                      | `SELECT curdate();` hasil: `2024-11-29`                                                       |
| `curtime()`                    | Mengembalikan waktu saat ini (hanya jam, menit, dan detik).                       | `SELECT curtime();` hasil: `10:15:30`                                                         |
| `extract(day from [tanggal])`  | Mengambil nilai hari dari kolom tanggal.                                         | `SELECT extract(day from '2024-11-29');` hasil: `29`                                          |
| `extract(month from [tanggal])`| Mengambil nilai bulan dari kolom tanggal.                                        | `SELECT extract(month from '2024-11-29');` hasil: `11`                                        |
| `extract(year from [tanggal])` | Mengambil nilai tahun dari kolom tanggal.                                        | `SELECT extract(year from '2024-11-29');` hasil: `2024`                                       |
| `dayname([tanggal])`           | Mengembalikan nama hari dari tanggal tertentu (dalam bahasa Inggris).            | `SELECT dayname('2024-11-29');` hasil: `Friday`                                               |
| `date_format([tanggal], format)`| Memformat tanggal sesuai pola tertentu.                                          | `SELECT date_format('2024-11-29', '%d-%m-%Y');` hasil: `29-11-2024`                          |
| `time_format([waktu], format)` | Memformat waktu sesuai pola tertentu.                                            | `SELECT time_format('10:15:30', '%h:%i %p');` hasil: `10:15 AM`                               |

**Penjelasan Format untuk `date_format` dan `time_format`:**

  - `%d` = Hari (01-31)
  - `%m` = Bulan (01-12)
  - `%Y` = Tahun (4 digit)
  - `%h` = Jam (01-12, format 12 jam)
  - `%i` = Menit (00-59)
  - `%p` = AM atau PM

**Catatan:**

Format dapat disesuaikan dengan kebutuhan untuk menampilkan data yang lebih user-friendly. Contoh-contoh di atas juga dapat digunakan dalam perintah SQL untuk pengolahan data.

### Fungsi Konversi / *Typecasting*

- *Typecasting* adalah proses memerankan suatu data dengan tipe lain.
- Proses *typecasting* tidak bisa diterapkan untuk semua tipe data.
- Tipe data yang akan diperankan sebagai tipe lain harus cocok.
- MySQL memiliki fungsi `cast()` dan `convert()` untuk melakukan hal ini. Keduanya berfungsi sama, hanya sintaksnya yang berbeda.

Contoh:
```sql
SELECT CAST('13' AS SIGNED);
SELECT CONVERT('13', SIGNED);
```

Berikut tipe-tipe data yang dapat digunakan dalam fungsi `cast()` dan `convert()`.

- BINARY
- CHAR
- DATE
- DATETIME
- SIGNED (INTEGER bertanda, bisa negatif)
- UNSIGNED (INTEGER tak bertanda, selalu positif)