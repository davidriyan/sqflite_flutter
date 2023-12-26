import 'dart:io';

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
}
