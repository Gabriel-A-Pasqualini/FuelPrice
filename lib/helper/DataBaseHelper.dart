import 'package:fuelprice/data/classes/ClassConfiguracao.dart';
import 'package:fuelprice/data/classes/ClassVeiculo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'veiculos.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }


  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        ALTER TABLE configuracoes ADD COLUMN kmRodadoDia REAL
      ''');

      await db.execute('''
        ALTER TABLE configuracoes ADD COLUMN litrosAtuais REAL
      ''');
    }
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
        favorita INTEGER NOT NULL,

        placaAntiga TEXT,
        placaNova TEXT,
        marcaModelo TEXT,
        nomeProprietario TEXT,
        cpfCnpjProprietario TEXT,
        renavam TEXT,
        chassi TEXT,
        codigoMotor TEXT,
        ano TEXT,
        procedencia TEXT,
        tipo TEXT,
        combustivel TEXT,
        cor TEXT,
        cilindradas INTEGER,
        potenciaCv INTEGER,
        capacidadePassageiros INTEGER,
        carroceria TEXT,
        cidade TEXT,
        estado TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE configuracoes (
        id INTEGER PRIMARY KEY,
        kmRodadoDia REAL,
        litrosAtuais REAL,
        precoEtanol REAL,
        precoGasolina REAL
      )
    ''');    

    await db.insert(
      'veiculos',
      ClassVeiculo(
        nome: 'HB20 1.0',
        litrosTanque: 50,
        gasolinaCidade: 13,
        gasolinaEstrada: 15,
        etanolCidade: 9,
        etanolEstrada: 11,
        favorita: true,
      ).toMap(),
    );

    await db.insert(
      'configuracoes',
      {
        'id': 1,
        'kmRodadoDia': 0.0,
        'litrosAtuais': 0.0,
        'precoEtanol': 0.0,
        'precoGasolina': 0.0,
      },
    );
  }

  // ================= CRUD =================

  Future<int> insertVeiculo(ClassVeiculo veiculo) async {
    final db = await database;
    return db.insert('veiculos', veiculo.toMap());
  }

  Future<List<ClassVeiculo>> getVeiculos() async {
    final db = await database;
    final result = await db.query('veiculos');
    return result.map(ClassVeiculo.fromMap).toList();
  }

  Future<int> updateVeiculo(ClassVeiculo veiculo) async {
    final db = await database;
    return db.update(
      'veiculos',
      veiculo.toMap(),
      where: 'id = ?',
      whereArgs: [veiculo.id],
    );
  }

  Future<int> deleteVeiculo(int id) async {
    final db = await database;
    return db.delete(
      'veiculos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> setFavorito(int id) async {
    final db = await database;
    await db.update('veiculos', {'favorita': 0});
    await db.update(
      'veiculos',
      {'favorita': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<ClassVeiculo?> getVeiculoFavorito() async {
    final db = await database;
    final result = await db.query(
      'veiculos',
      where: 'favorita = 1',
      limit: 1,
    );
    return result.isEmpty ? null : ClassVeiculo.fromMap(result.first);
  }

  Future<void> salvarPrecosCombustivel({
    required double etanol,
    required double gasolina,
  }) async {
    final db = await database;

    await db.update(
      'configuracoes',
      {
        'precoEtanol': etanol,
        'precoGasolina': gasolina,
      },
      where: 'id = ?',
      whereArgs: [1],
    );
  }


  Future<void> salvarConfiguracoes({
    required double kmRodadoDia,
    required double litrosAtuais,
    required double precoEtanol,
    required double precoGasolina,
  }) async {
    final db = await database;

    await db.insert(
      'configuracoes',
      {
        'id': 1,
        'kmRodadoDia': kmRodadoDia,
        'litrosAtuais': litrosAtuais,
        'precoEtanol': precoEtanol,
        'precoGasolina': precoGasolina,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<ClassConfiguracao?> getPrecosCombustivel() async {
    final db = await database;
    final result = await db.query(
      'configuracoes',
      where: 'id = 1',
      limit: 1,
    );
    return result.isEmpty ? null : ClassConfiguracao.fromMap(result.first);
  } 
}
