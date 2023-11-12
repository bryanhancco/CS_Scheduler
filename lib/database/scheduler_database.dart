import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:scheduler/classes/models.dart';

class SchedulerDatabase {
  static final SchedulerDatabase instance = SchedulerDatabase._init();
  final String tableCourse = "curso";
  final String tableShift = "turno";
  static Database? _database;

  SchedulerDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('scheduler.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableCourse(
        CurCod TEXT PRIMARY KEY,
        CurNom TEXT,
        CurReq INTEGER
      )''');
    await db.execute('''
      CREATE TABLE $tableShift(
        TurCod TEXT PRIMARY KEY,
        TurCurCod TEXT,
        TurHrs TEXT,
        TurLet TEXT,
        TurDoc TEXT,
        FOREIGN KEY(TurCurCod) REFERENCES $tableCourse(CurCod)
      )''');
  }

  Future<void> insertCourse(Curso item) async {
    final db = await instance.database;
    await db.insert(tableCourse, item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Curso>> getAllCursos() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableCourse);
    return List.generate(maps.length, (index) {
      return Curso(
        CurCod: maps[index]['CurCod'],
        CurNom: maps[index]['CurNom'],
        isObligatorio: maps[index]['CurReq'],
      );
    });
  }

  Future<void> insertShift(Turno item) async {
    final db = await instance.database;
    await db.insert(tableShift, item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Turno>> getAllTurnos(String curCod) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(tableShift, where: 'TurCurCod=?', whereArgs: [curCod]);
    return List.generate(maps.length, (index) {
      return Turno(
        TurCod: maps[index]['TurCod'],
        TurCurCod: maps[index]['TurCurCod'],
        TurHrs: maps[index]['TurHrs'],
        TurLet: maps[index]['TurLet'],
        TurDoc: maps[index]['TurDoc'],
      );
    });
  }
}
