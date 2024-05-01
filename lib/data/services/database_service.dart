import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:project_med/data/medication/drug_model.dart';
import 'package:project_med/data/medication/interaction_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseService {
  static DatabaseService get instance => Get.find();

  static const databaseName = 'test_database.db';
  static const databaseVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);

    if (kDebugMode) {
      print('================Copying database================');
    }
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}
    //* copy
    ByteData data =
        await rootBundle.load(join('assets/databases', databaseName));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    //* write
    await File(path).writeAsBytes(bytes, flush: true);
    var database = await openDatabase(path, version: databaseVersion);
    return database;

//*==================================================================================================
    //* check existing
    // var exists = await databaseExists(path);
    // if (!exists) {
    //   //* if database doesn't exist
    //   if (kDebugMode) {
    //     print('================Copying database================');
    //   }
    //   try {
    //     await Directory(dirname(path)).create(recursive: true);
    //   } catch (_) {}
    //   //* copy
    //   ByteData data =
    //       await rootBundle.load(join('assets/databases', databaseName));
    //   List<int> bytes =
    //       data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    //   //* write
    //   await File(path).writeAsBytes(bytes, flush: true);
    //   var database = await openDatabase(path, version: databaseVersion);
    //   return database;
    // } else {
    //   if (kDebugMode) {
    //     print('================Opening existing database================');
    //     print(path);
    //   }
    //   var database = await openDatabase(path, version: databaseVersion);
    //   return database;
    // }
  }

  //? CRUD operations
  Future<List<DrugModel>> fetchAll({required String table}) async {
    final database = await DatabaseService().database;
    final drugs = await database.rawQuery('''SELECT * FROM $table''');
    return drugs.map((drug) => DrugModel.fromSqfliteDatabase(drug)).toList();
  }

  Future<List<DrugModel>> fetchByName({required String name, required String table}) async {
    final database = await DatabaseService().database;
    final drugs = await database.rawQuery('''SELECT * from $table WHERE name = ?''', [name]);
    return drugs.map((drug) => DrugModel.fromSqfliteDatabase(drug)).toList();
  }


  Future<List<InteractionModel>> fetchByName2({required String name, required String table}) async {
    final database = await DatabaseService().database;
    final interactions = await database.rawQuery('''SELECT * from $table WHERE drug1Name = ?''', [name]);
    return interactions.map((interaction) => InteractionModel.fromSqfliteDatabase(interaction)).toList();
  }

  // Future<int> create(
  //     {required int drugID,
  //     required String drugName,
  //     required String drugDescription}) async {
  //   final database = await DatabaseHelper().database;
  //   return await database.rawInsert(
  //     '''INSERT INTO $table (drugID, drugName, drugDescription) VALUES (?,?)''',
  //     [drugID, drugName, drugDescription],
  //   );
  // }

  // Future<DrugModel> fetchById(int id) async {
  //   final database = await DatabaseHelper().database;
  //   final drug = await database
  //       .rawQuery('''SELECT * FROM $table WHERE drugID = ?''', [id]);
  //   return DrugModel.fromSqfliteDatabase(drug.first);
  // }

  // Future<int> update({
  //   required int id,
  //   String? drugName,
  //   String? drugDescription,
  // }) async {
  //   final database = await DatabaseHelper().database;
  //   return await database.update(
  //     table,
  //     {
  //       if (drugName != null) 'drugName': drugName,
  //       'drugDescription': drugDescription,
  //     },
  //     where: 'drugID = ?',
  //     conflictAlgorithm: ConflictAlgorithm.rollback,
  //     whereArgs: [id],
  //   );
  // }

  // Future<void> delete(int id) async {
  //   final database = await DatabaseHelper().database;
  //   await database.rawDelete('''DELETE FROM $table WHERE drugID = ?''', [id]);
  // }

  // //* insert
  // Future<int> insert(Map<String, dynamic> row) async {
  //   Database? db = await instance.database;
  //   return await db.insert(table, row,
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  // //* select all
  // Future<List> getAll() async {
  //   Database? db = await instance.database;
  //   var result = await db.query(table);
  //   return result.toList();
  // }

  // //* RAW query
  // Future<int?> getCount() async {
  //   Database? db = await instance.database;
  //   return Sqflite.firstIntValue(
  //     await db.rawQuery('SELECT COUNT(drugName) FROM $table'),
  //   );
  // }

  //* update
  // Future<int> update(Map<String, dynamic> row) async {
  //   Database? db = await instance.database;
  //   String id = row[columnDrugName];
  //   return await db.update(table, row, where: columnDrugName, whereArgs: [id]);
  // }

  //* delete
  // Future<int> delete(String name) async {
  //   Database? db = await instance.database;
  //   return await db.delete(table, where: columnDrugName, whereArgs: [name]);
  // }
}
