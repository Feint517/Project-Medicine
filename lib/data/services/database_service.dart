import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:project_med/data/medication/interaction_model.dart';
import 'package:project_med/data/medication/treatment_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

typedef ModelFactory<T> = T Function(Map<String, dynamic> data);

class DatabaseService {
  static DatabaseService get instance => Get.find();

  static const databaseName = 'test_database.db';
  static const databaseVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      if (kDebugMode) {
        print('Local files database:');
      }
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    //* check existing
    var exists = await databaseExists(path);
    if (!exists) {
      //* if database doesn't exist
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
    } else {
      if (kDebugMode) {
        print('================Opening existing database================');
        print(path);
      }
      var database = await openDatabase(path, version: databaseVersion);
      return database;
    }
  }

  Future<Database> copyDatabase() async {
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
  }

  //? Main CRUD operations ====================================================

  Future<List<TreatmentModel>> fetchTreatmentsFromDate(
      {required String table, required int convertedDate}) async {
    final database = await instance.database; //? try instance.database
    final treatments = await database
        .rawQuery('''SELECT * FROM $table Where date = ?''', [convertedDate]);
    return treatments
        .map((treatment) => TreatmentModel.fromJson(treatment))
        .toList();
  }

  Future<List<InteractionModel>> fetchByName({
    required String drug1,
    required String drug2,
    required String table,
  }) async {
    final database = await DatabaseService().database;
    final interactions = await database.query(
      'interactions',
      where:
          '(drug1Name = ? AND drug2Name = ?) OR (drug1Name = ? AND drug2Name = ?)',
      whereArgs: [drug1, drug2, drug2, drug1],
    );
    return interactions
        .map((interaction) => InteractionModel.fromSqfliteDatabase(interaction))
        .toList();
  }

  Future<void> deleteById({required String table, required int id}) async {
    final database = await DatabaseService().database;
    await database.rawDelete('''DELETE FROM $table WHERE id = ?''', [id]);
  }

  Future<int> add({
    required dynamic object,
    required String table,
  }) async {
    final database = await instance.database;
    return await database.insert(
      table,
      object.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int?> getCount({required String table}) async {
    final database = await instance.database;
    return Sqflite.firstIntValue(
      await database.rawQuery('SELECT COUNT(*) FROM $table'),
    );
  }

  Future<List<T>> fetchAll<T>(
      {required String table, required ModelFactory<T> factory}) async {
    final database = await instance.database;
    final results = await database.rawQuery('SELECT * FROM $table');
    return results.map((data) => factory(data)).toList();
  }

  Future<void> deleteAll({required String table}) async {
    final database = await DatabaseService().database;
    await database.delete(table);
  }

//? For Testing =======================================================
}
