import 'dart:io';

import 'package:belajar_sqflite/produk_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInstance {
  final String databaseName = 'belajar_sqflite.db';
  final int databaseVersion = 1;

  //membuat table
  final String tableName = 'produk';
  final String id = 'id';
  final String name = 'name';
  final String category = 'category';
  final String createAt = 'create_at';
  final String updateAt = 'update_at';

  //membuat inisialisasi database
  Database? database;

  //mengecek apakah database tersedia atau tidak
  Future<Database> cekDatabase() async {
    if (database != null) return database!;
    database = await initDatabase();
    return database!;
  }

//membuat fuction dimana kita akan menyimpan database kita
  Future initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    return openDatabase(path, version: databaseVersion, onCreate: onCreate);
  }

  //menginialisasi database
  Future onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName ($id INTEGER PRIMARY KEY, $name TEXT, $category TEXT, $createAt TEXT, $updateAt TEXT)');
  }

//membuat function untuk mengambil data dari table yang sudah kita buat
  Future<List<ProdukModel>> allData() async {
    final data = await database!.query(tableName);
    List<ProdukModel> result =
        data.map((e) => ProdukModel.fromJson(e)).toList();
    return result;
  }

//membuat function insert atau menambahkan data ke table
  Future<int> insert(Map<String, dynamic> row) async {
    final queryInsert = await database!.insert(tableName, row);
    return queryInsert;
  }

/*
update(int idParam, Map<String, dynamic> row) async: Ini adalah deklarasi fungsi update. Fungsi ini menerima dua parameter: idParam yang merupakan nilai id yang ingin diupdate, dan row yang merupakan data baru yang akan digunakan untuk mengganti data lama.
final queryUpdate = await database!.update(tableName, row, where: '$id = ?', whereArgs: [idParam]);: Pada baris ini, dilakukan operasi update pada tabel dengan menggunakan metode update dari objek database. Parameter yang diperlukan adalah nama tabel (tableName), data baru (row), kondisi untuk menentukan baris mana yang akan diupdate (where), dan nilai yang akan digunakan dalam kondisi (whereArgs).
tableName: Nama tabel yang akan diupdate.
row: Map yang berisi kolom dan nilai baru yang akan diupdate.
where: Kondisi untuk menentukan baris mana yang akan diupdate. Dalam hal ini, digunakan placeholder $id, yang kemudian akan diisi dengan nilai dari parameter idParam.
whereArgs: Nilai yang akan digunakan untuk menggantikan placeholder dalam where. Dalam hal ini, nilai dari idParam digunakan.
*/
  Future<int> update(int idParam, Map<String, dynamic> row) async {
    final queryUpdate = await database!
        .update(tableName, row, where: '$id = ?', whereArgs: [idParam]);
    return queryUpdate;
  }

  //membuat function delete
  Future delete(int idParam) async {
    await database!.delete(tableName, where: '$id = ?', whereArgs: [idParam]);
  }
}
