# Trigger

- *Trigger* adalah objek di dalam database yang berasosiasi dengan suatu tabel.
- *Trigger* akan diaktivasi ketika tabel tersebut dikenai *event* tertentu.
- *Event* merupakan suatu kejadian yang menimpa tabel, bisa berupa penambahan, perubahan maupun penghapusan data.

Sebelum lebih lanjut membahas trigger, ada baiknya kita siapkan dulu tabel khusus untuk operasi *trigger* nantinya.

```sql
USE buku_db;

CREATE TABLE histori_buku(
    buku_isbn CHAR(13),
    buku_judul VARCHAR(75),
    penerbit_id CHAR(4),
    buku_tglterbit DATE,
    buku_jmlhalaman INT,
    buku_deskripsi TEXT,
    buku_harga DECIMAL(10, 0),
    aksi varchar(6),
    aksi_tgl DATE
);
```

## Alasan Menggunakan Trigger

Beberapa alasan kita menggunakan trigger adalah:

- *Trigger* dapat memvalidasi data yang akan dimasukkan maupun yang akan digunakan untuk melakukan perubahan data.
- *Trigger* dapat memperoleh nilai lama dari baris data yang dihapus atau dirubah (misalnya untuk pencatatan histori data suatu tabel).
- *Trigger* dapat mengolah nilai kolom pada tabel lain.

Selain ketiga manfaat di atas, *Trigger* juga dapat meringankan kode di bagian aplikasi atau *stored procedure* yang dikembangkan. Kita tidak perlu menulis kode program di dalam aplikasi untuk melakukan validasi data.

## Konsep Trigger

Beberapa konsep yang perlu diketahui dan dipahami tentang *trigger* yaitu:

- *Trigger* adalah objek database yang berisi kumpulan perintah SQL yang akan dieksekusi atau diaktivasi ketika suatu *event* terjadi.
- Dalam satu database, kita dapat mendefinisikan lebih dari satu *trigger*. Setiap *trigger* harus memiliki nama yang unik.
- *Trigger* harus berasosiasi dengan tabel tertentu sebagai pemicu *trigger* untuk menentukan kapan *trigger* yang bersangkutan akan dieksekusi.
- *Trigger* memiliki *event*:
    - `BEFORE INSERT`
    - `AFTER INSERT`
    - `BEFORE UPDATE`
    - `AFTER UPDATE`
    - `BEFORE DELETE`
    - `AFTER DELETE`
- *Trigger* memiliki referensi `NEW` dan `OLD`.

## Daftar Event untuk Aktivasi Trigger

| Event | Keterangan | 
|-|-|
|`BEFORE INSERT`|*Trigger* diaktivasi sebelum data ditambahkan ke dalam suatu tabel.|
|`AFTER INSERT`|*Trigger* diaktivasi setelah data ditambahkan ke dalam suatu tabel.|
|`BEFORE UPDATE`|*Trigger* diaktivasi sebelum data dalam suatu tabel diubah.|
|`AFTER UPDATE`|*Trigger* diaktivasi setelah data daalam suatu tabel diubah.|
|`BEFORE DELETE`|*Trigger* diaktivasi sebelum data dihapus daru suatu tabel.|
|`AFTER DELETE`|*Trigger* diaktivasi setelah data dihapus dari suatu tabel.|


## Membuat Trigger

Format pembuatan *trigger* adalah

```sql
CREATE TRIGGER [nama_trigger]
[BEFORE | AFTER]
[INSERT | UPDATE | DELETE]
ON [nama_tabel]
FOR EACH ROW
BEGIN
    [badan trigger]
END
```
Sekarang mari kita buat *trigger* nya.

```sql
DELIMITER $$
CREATE TRIGGER tr_ai_buku
AFTER INSERT
ON BUKU
FOR EACH ROW
BEGIN
    INSERT INTO histori_buku VALUES (
    new.buku_isbn,
    new.buku_judul,
    new.penerbit_id,
    new.buku_tglterbit,
    new.buku_jmlhalaman,
    new.buku_deskripsi,
    new.buku_harga,
    'INSERT',
    CURRENT_DATE()
    );
END $$
```
!!! info "Penjelasan Kode"
    - Perintah di atas akan membuat *trigger* `tr_ai_buku` yang akan diaktivasi setiap kali *user* memasukkan baris data baru ke dalam tabel `buku`.
    - *Trigger* tersebut akan memasukkan data baru ke dalam tabel `histori_buku`, nilainya diambil dari data yang baru saja dimasukkan ke dalam tabel `buku`.
    - Untuk mengambil nilai dari data yang baru dimasukkan menggunakan referensi `new` seperti pada `new.buku_isbn`.
    - `'INSERT'` digunakan untuk mengisi jenis aksi yang dilakukan oleh *user*.
    - `CURRENT_DATE()` berfungsi untuk mengisi nilai kolom berisi tanggal saat proses memasukkan data.
    - Perintah `DELIMITER $$` berfungsi untuk menentukan bahwa tanda `$$` akan digunakan sebagai pembatas berakhirnya pembuatan kode *trigger*.

## Memeriksa Pengaruh Trigger

Untuk memeriksa pengaruh daripada *trigger*, sekarang kita coba memasukkan sampel data ke dalam tabel buku.

```sql
INSERT INTO buku VALUES(
    '999-11555-2-2',
    'Microsoft Excell',
    'PB04',
    '2009/02/07',
    200,
    NULL,
    60000
);
```
Ketika perintah tersebut dijalankan dan tidak terjadi *error* maka harusnya datanya masuk ke dalam tabel `buku` dan ada data baru di tabel `histori_buku`. Mari kita cek.

```sql
SELECT * FROM histori_buku;
```

## Referensi Trigger : NEW-OLD

Referensi `NEW` dan `OLD` berguna untuk mengambil:

- nilai-nilai yang akan dimasukkan ke dalam tabel (melalui perintah `INSERT`)
- nilai-nilai yang akan digunakan untuk mengubah data (melalui perintah `UPDATE`), atau
- nilai-nilai dari satu baris data yang telah dihapus (melalui perintah `DELETE`).

Sebagai contoh:

```sql
INSERT INTO
    penerbit (penerbit_id, penerbit_nama)
VALUES
    ('PB06','INFORMATIKA');
```

Jika perintah di atas dieksekusi maka MySQL akan menyimpan nilai-nilai tersebut ke dalam referensi `NEW`. Dengan demikian `new.penerbit_id` akan bernilai `PB06` dan `new.penerbit_nama` akan bernilai `INFORMATIKA`.

Contoh lagi

```sql
UPDATE penerbit
    SET penerbit_nama = 'Informatika Bandung'
WHERE
    penerbit_id = 'PB06';
```

- Pada perintah `UPDATE`, referensi `NEW` berfungsi untuk menyimpan nilai-nilai yang akan digunakan untuk melakukan perubahan.
- Nilai lama yang akan ditimpa dapat diakses menggunakan referensi `OLD`.
- `new.penerbit_nama` bernilai `Informatika Bandung`, sedangkan `old.penerbit_nama` bernilai `INFORMATIKA`.

Contoh lagi

```sql
DELETE FROM penerbit
WHERE penerbit_id = 'PB06';
```

- Ketika perintah tersebut dieksekusi, maka referensi `OLD` akan menyimpan nilai-nilai dari baris data yang dihapus.
- Maka `old.penerbit_id` bernilai `PB06`.

!!! note "Kesimpulan"
    - Referensi `NEW` akan menyimpan data baru pada proses `INSERT` dan `UPDATE`
    - Referensi `OLD` akan menyimpan data lama pada proses `UPDATE` dan `DELETE`
    - Baik referensi `NEW` maupun `OLD` bisa diakses dengan format `new.[nama_kolom]` atau `old.[nama_kolom]` contoh `new.penerbit_nama` atau `old.penerbit_nama`


## Menghapus Trigger

Untuk menghapus *trigger* kita bisa menggunakan perintah `DROP TRIGGER` dengan format

```sql
DRPO TRIGGER [nama_database].[nama_trigger];
```

Mari kita coba

```sql
DROP TRIGGER buku_db.tr_ai_buku;
```

Sebenarnya kita bisa juga menghapus trigger tanpa mencantumkan nama databasenya, asalkan saat ini kita sedang mengaktifkan/ menggunakan databasenya.

```sql
DROP TRIGGER tr_ai_buku;
```

## Hak Akses Trigger

- Untuk bisa membuat dan menghapus *trigger* kita perlu memiliki hak akses `SUPER`.
- Jika di dalam *trigger* kita menggunakan referensi `NEW` dan `OLD`, maka kita perlu memiliki hak akses tambahan yaitu:
    - `UPDATE`, agar bisa mengisi nilai kolom dengan perintah `SET NEW.[nama_kolom] = [nilai]`,
    - `SELECT`, agar bisa menggunakan referensi `NEW.[nama_kolom]`

## Batasan Trigger

Kita sudah tahu bahwasanya menggunakan *trigger* dapat membantu pekerjaan kita, namun kita perlu tahu juga bahwasanya *trigger* juga memiliki beberapa batasan berikut.

- Kita tidak dapat menggunakan perintah `CALL` (perintah untuk mengeksekusi *stored procedure*),
- Kita tidak dapat melakukan transaksi, semisal `COMMIT` dan `ROLLBACK`,
- Kita tidak dapat membuat *trigger* untuk tabel temporari.

## Implementasi Trigger

- Untuk memberikan kasus yang lebih nyata, kita akan mencoba membuat beberapa *trigger* sesuai dengan database yang sedang kita kelola yaitu `buku_db`.
- Kita akan membuat *trigger* `AFTER UPDATE` dan `AFTER DELETE` yang bertujuan untuk mencatat setiap perubahan data dan penghapusan data pada tabel `buku`, nantinya catatan tersebut disimpan di tabel `histori_buku`

**Trigger `AFTER UPDATE`**

Membuat *trigger* `tr_au_buku` yang akan diaktivasi setiap kali *user* mengubah data pada tabel `buku`.

```sql
DELIMITER $$
CREATE TRIGGER tr_au_buku
AFTER UPDATE
ON buku
FOR EACH ROW
BEGIN
    DECLARE isbn CHAR(13);
    DECLARE judul VARCHAR(75);
    DECLARE penerbit_id CHAR(4);
    DECLARE tgl_terbit DATE;
    DECLARE jml_halaman INT;
    DECLARE deskripsi TEXT;
    DECLARE harga DECIMAL(10,0);
    
    -- Mengisi nilai isbn
    IF new.buku_isbn IS NULL THEN
        SET isbn = old.buku_isbn;
    ELSE
        SET isbn = new.buku_isbn;
    END IF;
    
    -- mengisi nilai judul
    IF new.buku_judul IS NULL THEN
        SET judul = old.buku_judul;
    ELSE
        SET judul = new.buku_judul;
    END IF;

    -- mengisi nilai penerbit_id
    IF new.penerbit_id IS NULL THEN
        SET penerbit_id = old.penerbit_id;
    ELSE
        SET penerbit_id = new.penerbit_id;
    END IF;
    
    -- mengisi nilai tgl_terbit
    IF new.buku_tglterbit IS NULL THEN
        SET tgl_terbit = old.buku_tglterbit;
    ELSE
        SET tgl_terbit = new.buku_tglterbit;
    END IF;
    
    -- mengisi nilai jml_halaman
    IF new.buku_jmlhalaman IS NULL THEN
        SET jml_halaman = old.buku_jmlhalaman;
    ELSE
        SET jml_halaman = new.buku_jmlhalaman;
    END IF;
    
    -- mengisi nilai deskripsi
    IF new.buku_deskripsi IS NULL THEN
        SET deskripsi = old.buku_deskripsi;
    ELSE
        SET deskripsi = new.buku_deskripsi;
    END IF;
    
    -- mengisi nilai harga
    IF new.buku_harga IS NULL THEN
        SET harga = old.buku_harga;
    ELSE
        SET harga = new.buku_harga;
    END IF;

    -- memasukkan data ke dalam tabel histori_buku
    INSERT INTO histori_buku
    VALUES (
        isbn,
        judul,
        penerbit_id,
        tgl_terbit,
        jml_halaman,
        deskripsi,
        harga,
        'UPDATE',
        CURRENT_DATE()
    );   
    
END $$
```

**Trigger `AFTER DELETE`**

Membuat *trigger* `tr_ad_buku` yang akan diaktivasi setiap kali *user* mengubah data pada tabel buku.

```sql
DELIMITER $
CREATE TRIGGER tr_ad_buku
AFTER DELETE
ON buku
FOR EACH ROW
BEGIN
    INSERT INTO histori_buku VALUES(
        old.buku_isbn,
        old.buku_judul,
        old.penerbit_id,
        old.buku_tglterbit,
        old.buku_jmlhalaman,
        old.buku_deskripsi,
        old.buku_harga,
        'DELETE',
        CURRENT_DATE()
    );
END $$
```

Sebagai percobaan, sekarang kita coba mengubah data pada tabel `buku`.

```sql
UPDATE buku
SET penerbit_id = 'PB05',
    buku_jmlhalaman = 254,
    buku_harga = 64000
WHERE
    buku_isbn = '999-11555-2-2';
```

Selanjutnya, kita coba menghapus data dari tabel `buku`.

```sql
DELETE FROM buku
WHERE buku_isbn = '999-11555-2-2';
```

Harusnya ada tambahan 2 baris data pada tabel `histori_buku`. Sekarang mari kita cek.

```sql
SELECT * FROM histori_buku;
```

**Trigger `BEFORE INSERT`**

- Kali ini kita juga akan membuat *trigger* yang berfungsi melakukan validasi sebelum data dimasukkan ke dalam tabel `buku`.
- Sebagai contoh, kita ingin memastikan bahwa kolom `buku_jmlhalaman` harus lebih besar dari 149, dan jika nilainya sama atau lebih kecil, maka MySQL server akan menolak untuk memasukkan baris data tersebut.

```sql
DELIMITER $$
CREATE TRIGGER tr_bi_buku
BEFORE INSERT
ON buku
FOR EACH ROW
BEGIN
    IF new.buku_jmlhalaman <= 149 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Tidak bisa menambah buku, jumlah halaman terlalu sedikit.';
    END IF;
END $$
```

Untuk membuktikan pengaruh *trigger* tersebut, sekarang kita coba tambahkan data buku baru.

```sql
INSERT INTO buku VALUES(
    '999-11555-2-3',
    'Microsoft Publisher',
    'PB04',
    '2021/02/07',
    100,
    NULL,
    6000
);
```

Hasilnya? 😎