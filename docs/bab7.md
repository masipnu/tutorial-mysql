# Manajemen User

## Membuat User

*User* adalah orang yang dapat menggunakan database. Sejauh mana user tersebut dapat bekerja di dalam database ditentukan dari hak akses yang dimilikinya: apakah sebagai *Database Administrator* yang memiliki hak akses penuh terhadap database yang diolah ataupun sekedar *Operator* yang memiliki hak akses terbatas sesuai jenis pekerjaannya.

Format query untuk membuat *user* adalah sebagai berikut.
```sql
CREATE USER [nama_user] IDENTIFIED BY [password];
```

Jalankan *query*  berikut untuk membuat *user* baru.
```sql
CREATE USER 'admin' IDENTIFIED BY 's3cr3t';
```
*Query* tersebut akan membuat *user* baru dengan nama **admin** dan *password* **s3cr3t**. Ingat, bahwa *user* tersebut baru kita buat dan belum memiliki hak akses apapun terhadap database, namun kita sudah bisa login ke server MySQL menggunakan *user* tersebut.

Keluar dari user saat ini dengan perintah `\q` lalu `ENTER`. Selanjutnya mari kita login
```sh
mysql -u admin -p
```
Tekan `ENTER` lalu masukkan *password* **s3cr3t** dan tekan `ENTER`. Setelah berhasil coba jalankan *query* berikut.

Menampilkan database
```sql
SHOW DATABASES;
```

Mengaktifkan/ menggunakan database **buku_db**
```sql
USE buku_db;
```
Apa hasilnya? 😂

## Mengenal Hak Akses

Hak akses adalah suatu izin yang dapat diberikan kepada seorang *user*. Dengan izin tersebut, seorang *user* dapat melakukan aksi-aksi tertentu terhadap database.

Hak akses tersebut dikelompokkan menjadi 2, yaitu:

1. Tingkat User
2. Tingkat Administrator

**Hak Akses Tingkat User**

|Hak Akses              |Keterangan                         |
|---------              |----------                         |
|CREATE                 |Membuat database, tabel atau indeks|
|CREATE TEMPORARY TABLE |Membuat tabel temporari            |
|CREATE VIEW            |Membuat view                       |
|DELETE                 |Menghapus baris data               |
|EXECUTE                |Mengeksekusi prosedur              |
|INDEX                  |Membuat indeks                     |
|INSERT                 |Memasukkan baris-baris data ke dalam tabel|
|LOCK TABLES            |Mengunci suatu tabel|
|SELECT                 |Mengambil/ memilih data dari tabel|
|SHOW DATABASES         |Menampilkan semua database|
|SHOW VIEW              |Melihat daftar view yang dimiliki database|
|UPDATE                 |Mengubah data di dalam tabel|
|USAGE                  |Melakukan login, tapi tidak bisa melakukan apapun|

**Hak Akses Tingkat Administrator**

|Hak Akses  |Keterangan|
|-  |-|
|ALL    |Memiliki semua hak akses, kecuali WITH GRANT OPTION|
|ALTER  |Mengubah struktur tabel|
|CREATE USER    |Membuat user lain|
|DROP   |Menghapus database, tabel atau view|
|FILE   |Memuat data dari suatu file|
|PROCESS    |Melihat daftar proses yang dieksekusi MySQL|
|RELOAD |Menggunakan perintah FLUSH|
|SHUTDOWN   |Menghentikan server MySQL|

## Memberi Hak Akses

Perintah yagn digunakan untuk memberikan hak akses adalah `GRANT`, format umumnya sebgaimana berikut.
```sql
GRANT [hak akses]
ON [nama_tabel]|*|*.*|[nama_database]
TO [nama_user]
IDENTIFIED BY [password];
```
Jalankan *query* berikut untuk memberikan semua hak akses pada semua tabel yang terdapat dalam database **bukudb** kepada *user* **admin**.

```sql
GRANT ALL
ON bukudb.*
TO 'admin'@'%'
IDENTIFIED BY 's3cr3t';
```

Terkadang kita tidak perlu memberikan semua hak akses kepada user tertentu, untuk itu kita bisa menjalankan *query* berikut sebagai contohnya.

```sql
GRANT USAGE, INSERT, UPDATE, DELETE, SELECT
ON pengarang
TO 'admin'@'%'
IDENTIFIED BY 's3cr3t';
```

Dengan *query* tersebut, maka *user* **admin** hanya bisa memasukkan, mengubah, menghapus dan mengambil/ menampilkan data yang terdapat pada tabel **pengarang** saja.

## Mencabut Hak Akses

Untuk mencabut/ menarik kembali hak akses dari *user* tertentu bisa menggunakan perintah `REVOKE` dengan format
```sql
REVOKE [hak akses]
ON [nama_tabel]|*|*.*|[nama_database]
FROM [nama user];
```

**Contoh 1**
```sql
REVOKE ALL
ON bukudb.*
FROM admin
```
*Query* tersebut akan mencabut semua hak akses admin terahdap database **bukudb**.

**Contoh 2**
```sql
REVOKE USAGE, INSERT, UPDATE, DELETE, SELECT
ON pengarang
FROM 'admin';
```
*Query* tersebut akan mencabut hak akses `USAGE`, `INSERT`, `UPDATE`, `DELETE`, `SELECT` dari user admin terhadap tabel pengarang.

## Menghapus User

Untuk menghapus *user* format *query*-nya adalah
```sql
DROP USER [nama_user_1], [nama_user_2], ...dst;
```

Mari kita coba
```sql
DROP USER 'admin'@'%';
```

## Mengetahui Tabel Hak Akses

Ketika kita menjalankan *query* `GRANT` dan `REVOKE`, sebenarnya MySQL menyimpan data hak akses tersebut di dalam database `mysql`. Sehingga sebenarnya kita bisa saja melihat bahkan memberi ataupun menghapus hak akses *user* dengan memanipulasi database `mysql` tanpa melakukan *query* `GRANT` dan `REVOKE`.

Jika kita ingin memodifikasi data secara langsung, kita harus menjalankan *query*

```sql
FLUSH PRIVILEGES
```
Perintah tersebut berfungsi me-*refresh* perubahan yang telah dilakukan ke dalam database `mysql`.

Berikut beberapa tabel dalam database `mysql` yang berkaitan dengan proses pemberian dan pencabutan hak akses *user*.

- **user**
    
    Menyimpan informasi global tentang *user* dan hak akses yang dimilikinya.

- **db**
    
    Menyimpan informasi hak akases yang berkaitan dengan database untuk *user* tertentu.

- **tables_priv**
    
    Menyimpan informasi hak akses yang berkaitan dengan tabel untuk *user* tertentu.

- **columns_priv**
    
    Menyimpan informasi hak akses yang berkaitan dengan kolom untuk user tertentu.

Coba kita jalankan *query* berikut.

Mengaktifkan database `mysql` dan menampilkan seluruh tabel di dalamnya.
```sql
USE mysql;
SHOW TABLES;
```

Menampilkan struktur tabel `user`
```sql
DESC user;
```

Menampilkan beberapa kolom data dari tabel user.
```sql
SELECT user, host
FROM user;
```