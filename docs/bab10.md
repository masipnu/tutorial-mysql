# Prosedur dan Fungsi

- Prosedur dan fungsi merupakan objek database yang berisi runtutan perintah untuk melaksanakan satu tugas khusus tertentu.
- Prosedur dan fungsi disimpan di dalam database, sehingga jika database dihapus, keduanya kan hilang.
- Prosedur dan fungsi sering juga disebut sebagai *stored procedure* dan *stored function*.
- Sekali dibuat, prosedur dan fungsi dapat digunakan secara berulang.

## Manfaat Prosedur dan Fungsi

Pembuatan prosedur dan fungsi memiliki beberapa manfaat, di antaranya:

- **Sintaks SQL lebih fleksibel**
    
    Mengizinkan kita untuk menulis kode logis di dalam prosedur atau fungsi (bisa mengandung kontruksi pengulangan maupun percabangan).

- **Memiliki kemampuan untuk menanganni kesalahan (*error*)**
    
    Kesalahan yang terjadi pada saat eksekusi prosedur atau fungsi dapat ditangani dengan benar.

- **Pembungkusan kode (*code packaging and encapsulation*)**
    
    Prosedur dan fungsi di simpan di dalam server database. Dengan demikian, kode hanya ditulis sekali, tapi prosedur atau fungsi tersebut dapat digunakan oleh banyak aplikasi klien. Tentu hal ini akan meringankan tugas dari aplikasi klien.

- **Mudah dipelihara**
    
    Kita hanya perlu merubah kode prosedur atau fungsi di sisi server dan perubahan otomatis akan diterpakna ke semua aplikasi klien.

## Perbedaan Prosedur dan Fungsi

Perbedaan antara prosedur dan fungsi terletak pada peruntukan, cara pembuatan dan cara eksekusinya. Berikut hal-hal yang perlu diperhatikan.

- **Prosedur tidak mengembalikan nilai**

    Prosedur hanya melakukan suatu proses atau operasi tertentu, contohnya mengubah struktur tabel dan data dalam suatu tabel. Prosedur dieksekusi menggunakan perintah `CALL`.

- **Fungsi mengembalikan nilai**

    Cara eksekusinya adalah dengan meletakkan nama fungsi (beserta parameternya, jika ada) sebagai ekspresi, misalnya dalam perintah `SELECT`, dalam rumus perhitungan maupun ayng lain. Ini berarti bahwa pemanggilan fungsi sama seperti penggunaan variabel atau konstanta.

- **Cara Eksekusi**

    Fungsi tidak bisa dieksekusi menggunakan perintah CALL. Demikian juga, prosedur tidak dapat dieksekusi di dalam ekspresi.

- **Parameter**

    Parameter yang didefinisikan di dalam prosedur dapat bersifat sebagai parameter masukan (*input only*), parameter keluaran (*output only*), mapupun gabungan dari keduanya (dikenal dengan parameter masukan/keluaran). Karena alasan tersebut,s ebenarnya prosedur juga dapat digunakan untuk mengembalikan nilai, asalkan nilai tersebut ditampung ke dalam parameter keluaran. Fungsi hanya memiliki parameter masukan.

- **Klausa RETURNS**

    Karena fungsi merupakan sub-program yagn mengembalikan nilai, maka saat pembuatannya kita harus menggunakan klausa `RETURNS` di bagian kepala atau judul fungsi dan diikuti dengan tipe data dari nilai yang akan dikembalikan.

    Selain itu, di bagian akhir badan fungsi kita juga perlu menggunakan klausa `RETURN` untuk mengembalikan nilai yang diperoleh dari proses yang telah dilakukan oleh fungsi. Klausa `RETURNS` dan `RETURN` tidak ditemukans saat kita mendeklarasikan prosedur.

## Membuat dan Mengeksekusi Prosedur

- Prosedur dapat memiliki satu atau lebih perintah yang dikumpulkan menjadi satu kelompok. Oleh karena itu, kita perlu menggunakan blok `BEGIN-END`.
- Setiap perintah di dalma prosedur harus dipisahkan menggunakan tanda titik koma/ *semicolon* (;).

Format pembuatan prosedur pada umumnya sebagaimana berikut.
```sql
CREATE PROCEDURE [nama_prosedur] ([daftar parameter])
BEGIN
    [daftar deklarasi variabel]
    [perintah1];
    [perintah2]
    ... dst
END;
```
Sekarang kita coba membuat satu prosedur.
```sql
DELIMITER //
CREATE PROCEDURE select_penerbit()
BEGIN
    SELECT penerbit_nama
    FROM penerbit
    WHERE penerbit_id='PB06';
END;
//
```
Sekarang coba kita jalankan prosedurnya.

```sql
CALL select_penerbit();
```
Setelah dijalankan, kita tahu bahwa prosedur `select_penerbit()` tersebut berfungsi untuk menampilkan nama penerbit yang memiliki id penerbit `PB06`.

Selanjutnya, kita coba membuat prosedur yang memiliki parameter.
```sql
DELIMITER //
CREATE PROCEDURE
    insert_penerbit(id char(4), nama varchar(50))
BEGIN
    INSERT INTO penerbit
    (penerbit_id, penerbit_nama)
    VALUES (id, nama);
END;
//
```
Selanjutnya kita coba eksekusi.
```sql
CALL insert_penerbit('PB10','Sinar Terang');
```
Kita tahu bahwa prosedur yang baru saja kita buat dan kita jalankan berfungsi untuk menambahkan data penerbit. Untuk membuktikannya coba kita cek data penerbit dengan perintah
```sql
SELECT * FROM penerbit;
```
Tentu saja ada penerbit `Sinar Terang` dengan penerbit_id `PB10` bertengger di baris terakhir.

## Membuat dan Mengeksekusi Fungsi

Untuk membuat fungsi kita perlu menggunakan `CREATE FUNCTION` disusul dengan `RETURNS` dan diakhiri dengan `RETURN`. Berikut formatnya.

```sql
CREATE FUNCTION
    [nama_fungsi]([daftar parameter])
RETURNS [tipe data]
BEGIN
    [daftar deklarasi variabel]
    [perintah1];
    [perintah2];
    ... [dst]
    RETURN [nilai keluaran];
END;
```

`RETUNRS` [tipe data] berfungsi untuk menentukan tipe data keluaran dari fungsi tersebut. Semisal kita ingin emngembalikan nilai berupa bilangan bulat, berarti kita perlu menulis `RETURNS INT`.

Mari kita buat contohnya.

```sql
CREATE FUNCTION harga_buku(isbn CHAR(13))
    RETURNS DECIMAL(10, 0) DETERMINISTIC
BEGIN
-- Mendeklarasikan veriabel
DECLARE harga DECIMAL(10,0);

-- Seleksi data dan menampung hasilnya ke dalam variabel
SELECT buku_harga INTO harga
FROM buku
WHERE buku_isbn = isbn;

-- Mengembalikan nilai hasil proses
RETURN harga;

END;
//

```
Selanjutnya, coba kita eksekusi.
```sql
SELECT harga_buku('222-34222-1-0');
```

Ingin lebih jelas? kita coba begini.
```sql
SELECT harga_buku('222-34222-1-0')
AS 'Harga Buku';
```

Kita juga bisa memanggil fungsi di dalam ekspresi secara langsung. Contoh:
```sql
SET total = harga_buku('222-34222-1-0') * 2;
```
Dalam contoh tersebut, pemanggilan fungsi secara langsung digunakan untuk proses perkalian dengan bilangan lain. Dengan demikian, eksekusi fungsi perlakuannya sama dengan penggunaan variabel normal.

## Menghapus Prosedur dan Fungsi

Kita gunakan `DROP PROCEDURE` untuk menghapus prosedur, dan `DROP FUNCTION` untuk menghapus fungsi, diikuti nama prosedur ataupun fungsi. Contoh:

```sql
-- Menghapus prosedur
DROP PROCEDURE select_penerbit;

-- Menghapus fungsi
DROP FUNCTION harga_buku;
```

## Menampilkan Daftar Prosedur dan Fungsi

Ada beberapa variasi perintah di dalam MySQL untuk menampilkan prosedur maupun fungsi.

**Query-1**

Menampilkan seluruhprosedur yang tersimpan di dalam database beserta properti dan informasi *metadata* lainnya.

```sql
SHOW PROCEDURE STATUS;
```

**Query-2**

Menampilkan prosedur berdasarkan *filter* yang dilakukan menggunakan klausa `LIKE`.
```sql
SHOW PROCEDURE STATUS
WHERE name LIKE 'insert';
```

**Query-3**

Menampilkan seluruh fungsi yang tersimpan dalam database, beserta properti dan informasi *metadata* dari fungsi-fungsi tersebut.
```sql
SHOW FUNCTION STATUS;
```

## Hak Akses untuk Bekerja dengan Prosedur dan Fungsi

Untuk bekerja menggunakan prosedur dan fungsi kita perlu memiliki beberapa hak akses berikut.

- `CREATE ROUTINE`

    Untuk membuat prosedur maupun fungsi.

- `EXECUTE`

    Untuk mengeksekusi prosedur maupun fungsi.

- `ALTER ROUTINE`

    Untuk mengubah atau menghapus prosedur maupun fungsi.

## Variabel di dalam Prosedur dan Fungsi

- Pada saat membuat prosedur maupun fungsi, terkadang kita memerlukan satu atau lebih variabel untuk menampung nilai sementara dari proses yang dilakukan di dalam prosedur atau fungsi bersangkutan.
- Untuk mendeklarasikan variabel, kita gunakan perintah `DECLARE`, formatnya adalah
    ```sql
    DECLARE [nama_variabel] [tipe data];
    ```
- Perintah `DECLARE` harus berada di dalam blok `BEGIN-END` sebagai mana pada contoh sebelumnya [**di sini**](#membuat-dan-mengeksekusi-fungsi). Pada contoh tersebut kita mendeklarasikan variabel `harga` dengan tipe `DECIMAL` dengan lebar 10.
- Untuk melakukan inisialisasi nilai terhadap variabel yang telah dideklarasikan, kita perlu menggunakan perintah `SET` dengan format
    ```sql
    SET [nama_variabel] = [nilai]
    ```
    Contoh:
    ```sql
    BEGIN
        DECLARE harga DECIMAL(10, 0);
        SET harga = 0;
        ...
    END;
    ```
- Jika suatu variabel diugnakan untuk menampung nilai yang diperoleh dari suatu tabel dalam database, kita bisa mengisikannya ke dalam variabel dengan perintah `SELECT ... INTO`. Contoh:
    ```sql
    BEGIN
        ...
        SELECT buku_harga INTO harga
        FROM buku
        WHERE buku_isbn = isbn;
        ...
    END;
    ```

## Pemilihan dalam Prosedur dan Fungsi

- `IF` dan `CASE` bisa kita gunakan untuk melakukan pemilihan perintah atau aksi. Pemilihan ini didasarkan pada kondisi tertentu.
- Dalam blok pemilihan, aksi hanya dieksekusi jika kondisi yang didefinisikan bernilai benar.

### Perintah IF

Bentuk umum perintah `IF` adalah:

**Bentuk 1**

```sql
IF [kondisi] THEN
    [daftar aksi]
END IF
```

Ini adalah bentuk yang paling sederhana, karena hanya memiliki satu kondisi untuk diperiksa. Jika ekspresi bernilai benar, maka daftar aksi akan dieksekusi, namun jika salah, maka aksi tidak akan dijalankan.

**Bentuk 2**

```sql
IF [kondisi] THEN
    [daftar aksi1]
ELSEIF [kondisi2] THEN
    [daftar aksi2]
ELSE [daftar aksi3]
END IF
```
Ini adalah bentuk yang sedikit lebih kompleks. Jika kondisi1 bernilai benar, maka daftar aksi1 akan dijalankan. Jika tidak, maka akan dilanjutkan pengecekan kondisi2, jika benar, maka daftar aksi2 akan dijalankan. Jika tidak maka daftar aksi3 yang akan dijalankan.

Kita coba contoh berikut.

```sql
DELIMITER //
CREATE FUNCTION get_penerbit9isbn CHAR(13)
    RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
    DECLARE namapenerbit VARCHAR(50);
    SELECT b.penerbit_nama INTO namapenerbit
    FROM
        buku a,
        penerbit b
    WHERE
        a.penerbit_id = b.penerbit_id
        AND
        a.buku_isbn = isbn;

    IF namapenerbit IS NULL THEN
        SET namapenerbit = '';
    END IF;

    RETURN namapenerbit;
END;
//
```

!!! info "Penjelasan Kode"
    Inti penggunaan `IF` pada kode di atas adalah, jika `namapenerbit` bernilai `NULL` maka variabel `namapenerbit` akan diisi dengan nilai string kosong.

Sekarang coba kita tes fungsi tersebut.

```sql
SELECT get_penerbit('222-34222-1-0');
```

### Perintah CASE

Format penggunaan `CASE` adalah sebagai berikut.

```sql
CASE [ekspresi]
    WHEN [nilai1]
    THEN [daftar aksi1];
    WHEN [nilai2]
    THEN [daftar aksi2];
    ...[dst]

    ELSE [daftar aksi]
END CASE
```

!!! info "Penjelasan Kode"

    Jika ekspresi yang diperiksa memiliki nilai yang sama dengan nilai1, maka yang akan dieksekusi adalah daftar aksi1. Jika ekspresi sama dengan nilai2, maka yang akan dieksekusi adalah daftar aksi2, dan seterusnya.

    Jika semua nilai konstan yang didefinisikan tidak ada yang sama dengan ekspresi, maka yang akan dieksekusi adalah daftar aksi yang terdapat pada bagian `ELSE`.

Sekarang kita coba menerapkan `CASE` dengan fungsi berikut.

```sql
DELIMITER //
CREATE FUNCTION ubah_format_tanggal(tanggal DATE)
    RETURNS VARCHAR(30) DETERMINISTIC
BEGIN
    DECLARE dd INT(2);
    DECLARE mm INT(2);
    DECLARE yy INT(4);
    DECLARE bulan VARCHAR(9);

    SET dd = EXTRACT(DAY FROM tanggal);
    SET mm = EXTRACT(MONTH FROM tanggal);
    SET yy = EXTRACT(YEAR FROM tanggal);

    CASE mm
        WHEN 1 THEN SET bulan = 'Januari';
        WHEN 2 THEN SET bulan = 'Februari';
        WHEN 3 THEN SET bulan = 'Maret';
        WHEN 4 THEN SET bulan = 'April';
        WHEN 5 THEN SET bulan = 'Mei';
        WHEN 6 THEN SET bulan = 'Juni';
        WHEN 7 THEN SET bulan = 'Juli';
        WHEN 8 THEN SET bulan = 'Agustus';
        WHEN 9 THEN SET bulan = 'September';
        WHEN 10 THEN SET bulan = 'Oktober';
        WHEN 11 THEN SET bulan = 'November';
        WHEN 12 THEN SET bulan = 'Desember';
    END CASE;

    RETURN CONCAT(
        CONVERT(dd, CHAR),
        ' ',
        bulan,
        ' ' ,
        CONVERT(yy, CHAR)
    );
END
//
```
!!! info "Penjelasan Kode"

    Fungsi di atas berguna untuk mengubah format tanggal yang dilewatkan sebagai parameter, dari bentuk standar (dalam format angka) ke bentuk tanggal yang menggunakan nama bulan.

Sekarang mari kita coba gunakan fungsi tersebut.

```sql
SELECT
    buku_judul "Judul",
    ubah_format_tanggal(buku_tgl_terbit) "Tanggal Terbit",
    buku_harga "Harga"
FROM
    buku;
```
Sebagai perbandingan, coba kita jalankan query di atas tanpa menggunakan fungsi`ubah_format_tanggal`.

```sql
SELECT
    buku_judul "Judul",
    buku_tgl_terbit "Tanggal Terbit",
    buku_harga "Harga"
FROM
    buku;
```

## Pengulangan dalam Prosedur dan Fungsi

Satu atau beberapa aksi dapat dieksekusi secara berulang menggunakan blok perulangan. Di dalam MySQL blok perulangan dapat dibuat menggunakan:

- `LOOP`
- `WHILE`
- `REPEAT`

### Perintah LOOP

- `LOOP` merupakan bentuk perulangan yang tidak memiliki kondisi, maka normalnya perulangan akan dilakukan secara terus-menerus.
- Untuk menghentikan perulangan tersebut, kita perlu menggunakan perintah `LEAVE`.

Berikut format sintaksnya

```sql
LOOP
    [daftar aksi];
END LOOP
```

Mari langsung kita buat contohnya dengan memasukkan `LOOP` ke dalam sebuah fungsi.

```sql
DELIMITER //
CREATE FUNCTION jumlahkan(n INT)
    RETURNS int(11) DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE total INT DEFAULT 0;
    myloop: LOOP
        SET i = i + 1;
        IF i > n THEN
            -- keluar dari perulangan
            LEAVE myloop;
        END IF;
        SET total = total + i;
    END LOOP myoop;

    RETURN total;
END;
//
```

!!! info "Penjelasan Kode"
    Kita memberi label pada badan perulangan dengan nama `myloop`. Fungsi di atas berguna untuk menjumlahkan *n* buah bilangan positif pertama.

    Sebagai contoh, jika *n* bernilai 5, maka hasilnya adalah 15, berasal dari 1 + 2 + 3 + 4 + 5.

Sekarang, kita coba eksekusi fungsi `LOOP` tersebut.

```sql
SELECT jumlahkan(5);
```

### Perintah WHILE

- `WHILE` merupakan bentuk preintah untuk melakukan perulangan dengan cara memeriksa kondisi tertentu.
- Kondisi yang akan diperiksa ditempatkan di bagian awal blok.
- Aksi yang berada di dalam badan perulangan hanya akan dieksekusi jika kondisi terpenuhi (bernilai benar).
- Jika kondisi bernilai salah, maka aksi di dalam badan perulangan akan diabaikan dan proses eksekusi dilanjutkan ke aksi setelah blok perulangan (jika ada).

Bentuk umum sintaksnya adalah

```sql
WHILE [kondisi] DO
    [daftar aksi];
ENd WHILE
```

Mari kita buat fungsi yang mengandung `WHILE`

```sql
DELIMITER //
CREATE FUNCTION jumlahkan_while(n INT)
    RETURNS int(11) DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE total INT DEFAULT 0;
    WHILE (i <= n) DO
        SET total = total + i;
        SET i = i + 1;
    END WHILE;

    RETURN total;
END;
//
```

!!! info "Penjelasan Kode"
    Fungsi di atas merupakan modifikasi dari kode program sebelumnya. Perbedaannya, kali ini kita menggunakan perintah `WHILE` dalam proses pengulangan aksinya. Hasil yang diperoleh sama seperti pada fungsi sebelumnya.

### Perintah REPEAT

- `REPEAT` hampir sama dengan `WHILE`, hanya berbeda pada penempatan kondisinya saja.
- Pada `REPEAT`, pemeriksaan kondisi ditempatkan pada bagian akhir blok perulangan.
- `REPEAT` minimal akan menjalankan aksi minimal 1 kali.

Format sintaks `REPEAT` sebagai berikut.

```sql
REPEAT
    [daftar aksi]
UNTIL [kondisi]
END REPEAT
```
Sekarang, mari kita coba implementasikan ke dalam sebuah fungsi.

```sql
DELIMITER //
CREATE FUNCTION jumlahkan_repeat(n INT)
    RETURNS int(11) DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE total INT DEFAULT 0;
    
    REPEAT
        SET total = total + i;
        SET i = i + 1;
    UNTIL (i > n)
    END REPEAT;

    RETURN total;
END;
//
```

!!! info "Penjelasan Kode"
    Ketika dieksekusi, cara kerja fungsi di atas akan sama seperti dua fungsi sebelumnya 😂

### Perintah LEAVE dan ITERATE

- Proses pengulangan dapat dipaksa untuk berhenti atau untuk diteruskan menggunakan pernyataan loncat (*jump statement*).
- Untuk menghentikan, kita bisa menggunakan `LEAVE`, sedangkan untuk melanjutkan perulangan kita bisa menggunakan `ITERATE`.

Mari kita coba terapkan keduanya pada fungsi berikut.

```sql
DELIMITER //
CREATE PROCEDURE tampilkan_bil_genap(n INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE str VARCHAR(200) DEFAULT '';
    next: LOOP
        SET i = i + 1;
        IF (i mod 2 = 1) THEN
            ITERATE next;
        END IF;
        IF (i > n) THEN
            LEAVE next;
        END IF;
        SET str = CONCAT(str, CONVERT(i, CHAR), ' ');
    ENd LOOP next;
    SELECT str AS "Bilangan Genap";
END;
//
```

!!! info "Penjelasan Kode"
    Pada kode di atas, kita membuat sebuah prosedur yang dapat menampilkan bilangan genap yang terdapat antara bilangan 1 dan *n*. Nilai *n* ditentukan pada saat pemanggilan prosedur.

Sekarang kita coba panggil prosedur di atas.

```sql
CALL tampilkan_bil_genap(50);
```

!!! info "Tentu saja"
    Perintah tersebut akan menampilkan bilangan genap aygn berada dalam rentang 1 dan 20.