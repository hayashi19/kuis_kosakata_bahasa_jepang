// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite_dev.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseController extends GetxController {
  //> factory
  //?= store database factory temporary
  DatabaseFactory? _factory;
  //?= get database factory base on platform
  Future<DatabaseFactory> _getFactory() async {
    if (GetPlatform.isWeb) {
      return databaseFactoryFfiWeb;
    } else if (GetPlatform.isWindows) {
      return databaseFactoryFfi;
    } else {
      return sqfliteDatabaseFactoryDefault;
    }
  }

  //> database path
  //?= temporary store db path
  String? _path;
  //?= get db path from factory, with file name is dictionary.db
  Future<String> _getPath() async => join(
        (await _factory!.getDatabasesPath()),
        'dictionary.db',
      );

  //> database
  //?= temporary store opened db
  Database? database;
  //?= get the db by opening db from selected db factory and db path
  Future<Database> _getDatabase() async => _factory!.openDatabase(_path!);

  //> create
  //?= create database base on platform
  Future<Database> createDb() async {
    // [1] initial sqflite for windows
    sqfliteFfiInit();
    // [2] get database factory based on platform
    _factory = await _getFactory();
    // [3] get db path from the factory path
    _path = await _getPath();

    // [4] delete db to prevent duplicate
    await _factory!.deleteDatabase(_path!);

    // [6] write initial db base on platform
    // web & windows
    if (GetPlatform.isWeb || GetPlatform.isWindows) {
      // [5] get database
      database = await _getDatabase();
      // [7] load the sql create and insert command
      String listType = await rootBundle.loadString(
        'assets/wordlist_database/type_list.sql',
      );
      String wordList = await rootBundle.loadString(
        'assets/wordlist_database/word_list.sql',
      );
      String wordLevel = await rootBundle.loadString(
        'assets/wordlist_database/word_level.sql',
      );
      String wordType = await rootBundle.loadString(
        'assets/wordlist_database/word_type.sql',
      );
      // [8] execute the sql command
      await database!.transaction((txn) async {
        await txn.execute(listType.toString());
        await txn.execute(wordList.toString());
        await txn.execute(wordLevel.toString());
        await txn.execute(wordType.toString());
      });
    }
    // mobile
    else {
      // [9] load sqlite file from root assets
      ByteData data = await rootBundle.load(
        'assets/wordlist_database/word_database_mobile.sqlite',
      );
      // [10] get the byte
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      // [11] write the byte to file with the selected path
      File(_path!).writeAsBytesSync(bytes);
      // [5] get database
      database = await _getDatabase();
    }
    return database!;
  }
}
