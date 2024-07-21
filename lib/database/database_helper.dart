import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:seguridad_20220199/models/incidencias.dart';
import 'package:seguridad_20220199/models/oficial.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> deleteAllIncidencias() async {
    final db = await database;
    await db.delete('incidencias');
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'seguridad.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE incidencias(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        fecha TEXT,
        descripcion TEXT,
        foto TEXT,
        audio TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE oficial(
        id INTEGER PRIMARY KEY,
        foto TEXT,
        nombre TEXT,
        apellido TEXT,
        matricula TEXT
      )
    ''');
  }

  // Métodos CRUD para Incidencia
  Future<int> insertIncidencia(Incidencia incidencia) async {
    Database db = await database;
    return await db.insert('incidencias', incidencia.toMap());
  }

  Future<List<Incidencia>> getIncidencias() async {
    Database db = await database;
    var result = await db.query('incidencias');
    return result.map((map) => Incidencia.fromMap(map)).toList();
  }

  Future<int> updateIncidencia(Incidencia incidencia) async {
    Database db = await database;
    return await db.update(
      'incidencias',
      incidencia.toMap(),
      where: 'id = ?',
      whereArgs: [incidencia.id],
    );
  }

  Future<int> deleteIncidencia(int id) async {
    Database db = await database;
    return await db.delete(
      'incidencias',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Métodos CRUD para Oficial
  Future<int> insertOficial(Oficial oficial) async {
    Database db = await database;
    return await db.insert('oficial', oficial.toMap());
  }

  Future<Oficial?> getOficial(int id) async {
    Database db = await database;
    var result = await db.query(
      'oficial',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Oficial.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateOficial(Oficial oficial) async {
    Database db = await database;
    return await db.update(
      'oficial',
      oficial.toMap(),
      where: 'id = ?',
      whereArgs: [oficial.id],
    );
  }

  Future<int> deleteOficial(int id) async {
    Database db = await database;
    return await db.delete(
      'oficial',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
