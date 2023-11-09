import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:scheduler/classes/models.dart';

class ShopDatabase {
  static final ShopDatabase instance = ShopDatabase._init();
  final String tableCourse = "curso";
  final String tableShift = "turno";
  final String tableHour = 'hora';
  final String tableShiftPerHour = 'turno_hora';
  static Database? _database;
  
  ShopDatabase._init();

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
      )'''
    );
    await db.execute('''
      CREATE TABLE $tableShift(
        TurCod TEXT PRIMARY KEY,
        TurCurCod TEXT,
        TurLet TEXT,
        TurDoc TEXT,
        FOREIGN KEY(TurCurCod) REFERENCES $tableCourse(CurCod)
      )'''
    );
    await db.execute('''
      CREATE TABLE $tableHour(
        HorCod TEXT PRIMARY KEY,
        HorInd INTEGER
      )'''
    );
    await db.execute('''
      CREATE TABLE $tableShiftPerHour(
        TurCod TEXT,
        HorCod TEXT,
        FOREIGN KEY(TurCod) REFERENCES $tableShift(TurCod)
        FOREIGN KEY(HorCod) REFERENCES $tableHour(HorCod)
      )'''
    );
     
    for (int i = 1; i <= 75; i++) {
      await db.rawInsert('INSERT INTO $tableHour (HorCod, HorInd) VALUES ("H_$i", $i)');
    }
  }
}