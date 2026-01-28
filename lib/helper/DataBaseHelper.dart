import 'package:fuelprice/classes/ClassConfiguracao.dart';
import 'package:fuelprice/classes/ClassVeiculo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  /// Getter do banco
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('veiculos.db');
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

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE veiculos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        litrosTanque REAL NOT NULL,
        gasolinaCidade REAL NOT NULL,
        gasolinaEstrada REAL NOT NULL,
        etanolCidade REAL NOT NULL,
        etanolEstrada REAL NOT NULL,
        favorita INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE configuracoes (
        id INTEGER PRIMARY KEY,
        precoEtanol REAL NOT NULL,
        precoGasolina REAL NOT NULL
      )
    ''');

    final veiculosIniciais = [
      ClassVeiculo(
        nome: 'HB20 1.0',
        litrosTanque: 50,
        gasolinaCidade: 13.0,
        gasolinaEstrada: 15.0,
        etanolCidade: 9.0,
        etanolEstrada: 11.0,
        favorita: true,
      ),
    ];

    for (final veiculo in veiculosIniciais) {
      await db.insert(
        'veiculos',
        veiculo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await db.insert(
      'configuracoes',
      {
        'id': 1,
        'precoEtanol': 0.0,
        'precoGasolina': 0.0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }



  Future<int> insertVeiculo(ClassVeiculo veiculo) async {
    final db = await instance.database;
    return await db.insert(
      'veiculos',
      veiculo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ClassVeiculo>> getVeiculos() async {
    final db = await instance.database;
    final result = await db.query('veiculos');
    return result.map((e) => ClassVeiculo.fromMap(e)).toList();
  }

  Future<int> updateVeiculo(ClassVeiculo veiculo) async {
    final db = await instance.database;
    return await db.update(
      'veiculos',
      veiculo.toMap(),
      where: 'id = ?',
      whereArgs: [veiculo.id],
    );
  }
  Future<int> deleteVeiculo(int id) async {
    final db = await instance.database;
    return await db.delete(
      'veiculos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> setFavorito(int id) async {
    final db = await instance.database;

    await db.update(
      'veiculos',
      {'favorita': 0},
    );

    await db.update(
      'veiculos',
      {'favorita': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<ClassVeiculo?> getVeiculoFavorito() async {
    final db = await instance.database;

    final result = await db.query(
      'veiculos',
      where: 'favorita = ?',
      whereArgs: [1],
      limit: 1,
    );

    if (result.isEmpty) return null;
    return ClassVeiculo.fromMap(result.first);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> salvarPrecosCombustivel({
    required double etanol,
    required double gasolina,
  }) async {
    final db = await instance.database;

    await db.insert(
      'configuracoes',
      {
        'id': 1,
        'precoEtanol': etanol,
        'precoGasolina': gasolina,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<ClassConfiguracao?> getPrecosCombustivel() async {
    final db = await instance.database;

    final result = await db.query(
      'configuracoes',
      where: 'id = ?',
      whereArgs: [1],
      limit: 1,
    );

    if (result.isEmpty) return null;
    return ClassConfiguracao.fromMap(result.first);
  }
}
