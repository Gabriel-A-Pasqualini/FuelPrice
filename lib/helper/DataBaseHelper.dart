import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../classes/ClassVeiculo.dart'; // sua classe de modelo

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('receitas.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE receitas(
        numeroReceita INTEGER PRIMARY KEY,
        nomeReceita TEXT NOT NULL,
        favorita INTEGER NOT NULL
      )
    ''');

    final receitasIniciais = [
      ClassVeiculo(0, 'Parmegiana de Carne', false),
      ClassVeiculo(1, 'Parmegiana de Frango', true),
      ClassVeiculo(2, 'Strogonoff de Carne', false),
      ClassVeiculo(3, 'Strogonoff de Frango', false),
      ClassVeiculo(4, 'Omelete', true),
      ClassVeiculo(5, 'Peixe na Frigideira', false),
      ClassVeiculo(6, 'Bolo de Caneca', true),
      ClassVeiculo(7, 'Ratatouille', false),
    ];

    for (var receita in receitasIniciais) {
      await db.insert(
        'receitas',
        receita.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }    
  }

  // Inserir receita
  Future<void> insertReceita(ClassVeiculo receita) async {
    final db = await instance.database;
    await db.insert(
      'receitas',
      receita.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Listar todas as receitas
  Future<List<ClassVeiculo>> getReceitas() async {
    final db = await instance.database;
    final result = await db.query('receitas');
    return result.map((json) => ClassVeiculo.fromMap(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
