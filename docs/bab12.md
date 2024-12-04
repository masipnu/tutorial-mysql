# Ekspor dan Impor

Terkadang kita dihadapkan pada kondisi di mana kita perlu memindahkan database kita dari satu server ke server yang lain, semisal:

- Ingin mengganti komputer server,
- Komputer server saat ini mengalami kendala (serangan virus, kendala hardware),
- Ingin memindahkan data dari lingkungan *development* ke lingkungan *production*, ataupun
- Alasan yang lain.

Maka kita perlu melakukan proses *backup* (pencadangan) dan *restore* (pengembalian) data.

## Mengekspor Data

- **Ekspor** adalah proses pembuatan salinan data dari database.
- Kita dapat mengekspor data yang terdapat di dalam satu tabel tertentu, seluruh tabel, bahkan keseluruhan objek yang ada di dalam database (tabel, prosedur, fungsi, view, dll).
- Ekspor data diperlukan untuk mengantisipasi terjadinya kerusakan pada database yang sedang diolah.

Ada beberapa teknik yang bisa dilakukan untuk melakukan `backup` dan `restore`, yaitu:

- Menggunakan `mysqldump`
- Menggunakan `mysqlhotcopy`
- Menyalin file data secara manual
- Menggunakan `BACKUP TABLE`

### Menggunakan `mysqldump`

- Cara kerja `mysqldump` adalah dengan membuat *dump file* yang berisi perintah-perintah SQL yang diperlukan untuk membuat ulang database.
- Ini adalah cara yang paling umum digunakan oleh pengguna MySQL.
- `mysqldump` dijalankan menggunakan terminal dengan format
    ```bash
    mysqldump -u [nama_user] -p [nama_database] > [nama_dump_file]
    ```

Sekarang mari kita coba jalankan

Untuk OS Linux
```bash
sudo mysqldump -u root -p buku_db > ~/backup/buku_db.sql
```

Untuk OS Windows
```cmd
mysqldump -u root -p buku_db > D:\backup\buku_db.sql
```

!!! info "Penjelasan Kode"
    - Dengan menjalankan perintah di atas, maka MySQL akan menciptakan file `buku_db.sql` yang ditempatkan pada direktori `backup`.
    - File tersebut berisi perintah-perintah untuk membuat ulang database beserta objek-objek di dalamnya.
  

`mysqldump` memiliki beberapa opsi yang bisa disertakan saat kita menjalankannya, yaitu:

- **--quick**

    Digunakan untuk mentransformasikan data yang terdapat di dalam database ke dalam *dump file* secara langsung, tanpa harus menyimpannya ke dalam memori komputer terlebih dahulu. Ini adalah opsi *default* untuk mempercepat proses pembuatan *dump file*.

- **--add-drop-table**
  
    Ini akan membuat perintah `DROP TABLE` sebelum `CREATE TABLE` di dalam *dump file*.

- **--add-lock**
    
    Ini akan menambahkan perintah `LOCK TABLES` dan `UNLOCK TABLES` di dalam *dump file* yang dihasilkan.

- **--extended-insert**

    Ini digunakan untuk menginstruksikan kepada MySQL agar menambahkan baris-baris data ke dalam tabel yang terbuat hanya dengan menggunakan satu perintah `INSERT`.

- **--databases**

    Digunakan jika kita ingin membuat salinan data dari beberapa (lebih dari satu) database dengan satu perintah.

- **--all-databases**

    Digunakan jika kita ingin membuat salinan data dari semua database yang terdapat pada server MySQL dalam satu perintah.
        
- **-d** atau **--no-data**

    Digunakan jika kita hanya ingin membuat salinan struktur datanya saja, tidak termasuk data yang terdapat di dalamnya.


Sebagai contoh, kita bisa menjalankan perintah berikut via *command prompt*.

```cmd
mysqldump -u root -p --databases buku_db mysql > D:\backup\dump.sql
```

### Menggunakan `mysqlhotcopy`

- `mysqlhotcopy` merupakan program yang dikembangkan menggunakan Perl, maka untuk mengaksesnya kita perlu menginstall *software* perl di komputer.
- `mysqlhotcopy` bekerja dengan menyalin daftar file data aktual yang terdapat di dalam database operasional dan memindahkannya ke lokasi baru.
- Semua proses terjadi di belakang layar.

Berikut format perintah untuk menjalankan `mysqlhotcopy`

```bash
mysqlhotcopy -u [nama_user] -p [nama_database] [lokasi_backup]
```

### Menyalin File Data

Sebenarnya kita bisa saja membackup database dengan cara manual, yaitu menyalin file databasenya secara langsung. Ini merupakan versi manual daripada `mysqlhotcopy`.

Berikut langkah-langkahnya.

- Jalankan perintah `LOCK TABLES` seperti berikut.

    ```sql
    LOCK TABLES
    pengarang READ,
    penerbit READ,
    kategori READ,
    buku READ,
    link_buku_pengarang READ,
    link_buku_kategori READ;
    ```

- Jalankan `FLUSH TABLES`

    ```sql
    FLUSH TABLES;
    ```

- Salin data (\*.frm dan \*.myd) yang ada di dalam direktori `C:\Program Files\[MySQL Dir]\Data` secara manual menggunakan *copy-paste* ke direktori tujuan.

- Setelah selesai, jalankan perintah `UNLOCK TABLES`.

    ```sql
    UNLOCK TABLES;
    ```

### Menggunakan `BACKUP TABLE`

- `BACKUP TABLE` bisa menjadi alternatif dalam membackup database, dengan syarat tabel-tabelnya menggunakan mesin `MyISAM`.
- Perintah ini sebenarnya sudah dianggap *deprecated* (sudah tidak direkomendasikan)

Berikut format perintahnya.

```sql
BACKUP TABLE [nama_tabel1], [nama_tabel2], ...dst TO [direktori_tujuan];
```

Contoh:

```sql
BACKUP TABLE myisam1, myisam2 TO 'C:/tmp';
```

!!! info "Penjelasan kode"
    - Setelah dijalankan, maka MySQL akan membuat salinan dari tabel myisam1 (`myisam1.frm`, `myisam1.myd`) dan myisam2 (`myisam2.frm`, `myisam2.myd`) ke dalam direktori `C:\tmp`.
    - Perlu diperhatikan, kita menggunakan *forward slash* (/), bukan *back slash* (\\) saat menuliskan direktori tujuan.

## Mengimpor Data

- Salinan file yang dihasilkan oleh proses *backup* selanjutnya bisa disimpan dan digunakan sewaktu-waktu jika terjadi kesalahan atau kerusakan data pada server MySQL maupun pada komputer server.
- Proses pengembalian data ke keadaan sebelumnya disebut sebagai *restore*/ impor data.

Berikut langkah-langkah *restore* data yang dihasilkan dari program `mysqldump`.

1. Menggunakan *MySQL Client*, buatlah database baru dengan nama tertetntu. Contoh:

    ```sql
    CREATE DATABASE db_baru;
    ```
2. Melalui *terminal* atau *command prompt* jalankan perintah dengan format berikut.

    ```cmd
    mysql -u [nama_user] -p [nama_database] [file_backup]
    ```
    Contoh:

    ```cmd
    mysql -u root -p db_baru D:\backup\buku_db.sql
    ```
    Sekarang kita bisa mengecek hasilnya dengan menjalankan `query` pada *MySQL Monitor*.
    
    ```sql
    -- mengaktifkan database
    USE buku_db;

    -- menampilkan tabel
    SHOW TABLES;

    -- menampilkan contoh data
    SELECT * FROM penerbit;

    ```


Berikut cara melakukan *restore* menggunakan file *backup* yang dihasilkan dari program `mysqlhotcopy` ataupun yang disalin secara manual.

1. Hentikan *service* MySQL, (bisa melalui `Task Manager`),
2. Salin daftar file hasil *backup* (`*.frm` dan `*.myd`) ke dalam direktori `C:\Program Files\[MySQL Dir]\Data`. Proses penyalinan ini akan menimpa file lama.


Untuk melakukan *restore* databsae dari file yang dihasilkan oleh perintah `BACKUP TABLE`, kita bisa menggunakan perintah `RESTORE TABLE`, formatnya:

```sql
RESTORE TABLE
[nama_tabel1], [nama_tabel2], ...dst
FROM
[direktori_file_backup]
```

Contoh

```sql
RESTORE TABLE
myisam1, myisam2
FROM
'C:/tmp';
```

Sekarang silahkan cek hasilnya. :wink: