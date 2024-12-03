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
- *Trigger* dapat memperoleh nilai lama dari baris data yagn dihapus atau dirubah (misalnya untuk pencatatan histori data suatu tabel).
- *Trigger* dapat mengolah nilai kolom pada tabel lain.

Selain ketiga manfaat di atas, *Trigger* juga dapat meringankan kode di bagian aplikasi atau *stored procedure* yagn dikembangkan. Kita tidak perlu menulis kode program di dalam aplikasi untuk melakukan validasi data.

## Konsep Trigger

Beberapa konsep yang perlu diketahui dan dipahami tentang *trigger* yaitu:

- *Trigger* adalah objek database yagn berisi kumpulan perintah SQL yang akan dieksekusi atau diaktivasi ketika suatu *event* terjadi.
- Dalam satu database, kita dapat mendefinisikan lebih dari sati *trigger*. Setiap *trigger* harus memiliki nama yang unik.
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

## Memeriksa Pengaruh Trigger

## Referensi Trigger : NEW-OLD

## Menghapus Trigger

## Hak Akses Trigger

## Batasan Trigger

## Implementasi Trigger