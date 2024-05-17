import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:project_med/data/medication/interaction_model.dart';
import 'package:project_med/data/medication/treatment_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

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
    //final database = await DatabaseService().database;
    final database = await instance.database; //? try instance.database
    final treatments = await database
        .rawQuery('''SELECT * FROM $table Where date = ?''', [convertedDate]);
    return treatments
        .map((treatment) => TreatmentModel.fromJson(treatment))
        .toList();
  }

  Future<List<InteractionModel>> fetchByName(
      {required String name, required String table}) async {
    final database = await DatabaseService().database;
    final interactions = await database
        .rawQuery('''SELECT * from $table WHERE drug1Name = ?''', [name]);
    return interactions
        .map((interaction) => InteractionModel.fromSqfliteDatabase(interaction))
        .toList();
  }

  Future<void> delete({required String table, required int id}) async {
    final database = await DatabaseService().database;
    await database.rawDelete('''DELETE FROM $table WHERE id = ?''', [id]);
  }

  Future<int> add({
    required dynamic object,
    required String table,
  }) async {
    final database = await instance.database;
    if (kDebugMode) {
      print('Item added to database.');
    }
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

  Future<List<dynamic>?> fetchAll({required String table}) async {
    final database = await instance.database;
    final List<Map<String, dynamic>> maps = await database.query(table);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
      maps.length,
      (index) => TreatmentModel.fromJson(maps[index]),
    );
  }

  // Future<int> saveToDatabase({
  //   required String table,
  //   required String type,
  //   required String name,
  //   required int dose,
  //   required String frequency,
  //   required String timing,
  //   String injectingSite = '',
  //   required int date,
  //   required String hour,
  // }) async {
  //   final database = await DatabaseService().database;
  //   return await database.rawInsert(
  //     '''INSERT INTO $table (type,name,dose,frequency,timing,injectingSite,date,hour) VALUES (?,?,?,?,?,?,?,?)''',
  //     [type, name, dose, frequency, timing, injectingSite, date, hour],
  //   );
  // }

//? For Testing =======================================================
  Future<List<TreatmentModel>> fetchAllTreatment(
      {required String table}) async {
    final database = await instance.database; //? try instance.database
    final treatments = await database.rawQuery('''SELECT * FROM $table''');
    return treatments
        .map((treatment) => TreatmentModel.fromJson(treatment))
        .toList();
  }

  Future<List<TreatmentModel>?> getAllTreatments(
      {required String table}) async {
    final database = await instance.database;
    final List<Map<String, dynamic>> maps = await database.query(table);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => TreatmentModel.fromJson(maps[index]));
  }

  Future<void> deleteAll({required String table}) async {
    final database = await DatabaseService().database;
    await database.delete(table);
  }

  // //* RAW query
  // Future<int?> getCount() async {
  //   Database? db = await instance.database;
  //   return Sqflite.firstIntValue(
  //     await db.rawQuery('SELECT COUNT(drugName) FROM $table'),
  //   );
  // }
}
