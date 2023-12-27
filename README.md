# belajar_sqflite

## file database_instance

#### Fungsi allData

digunakan untuk mengambil semua data dari tabel produk dalam database. Pada baris pertama, await database!.query(tableName) akan mengambil semua data dari tabel dengan nama tableName (dalam hal ini, tabel 'produk'). Data yang diambil disimpan dalam variabel data. Kemudian, menggunakan metode map, setiap data diubah menjadi objek ProdukModel menggunakan fungsi ProdukModel.fromJson(e). Hasilnya adalah daftar ProdukModel yang kemudian dikembalikan.

#### Fungsi insert

digunakan untuk memasukkan data baru ke dalam tabel produk. Pada baris pertama, await database!.insert(tableName, row) memasukkan data yang diberikan (parameter row) ke dalam tabel dengan nama tableName. Hasil dari operasi insert ini (biasanya id dari data yang baru dimasukkan) disimpan dalam variabel queryInsert dan kemudian dikembalikan sebagai nilai fungsi.
