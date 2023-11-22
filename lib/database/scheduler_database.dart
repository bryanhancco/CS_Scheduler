/*

## Base de datos sqlite propia de dispositivos moviles
## Funciones de manejo de esos datos

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:scheduler/classes/models.dart';

class SchedulerDatabase {
  static final SchedulerDatabase instance = SchedulerDatabase._init();
  final String tableCourse = "curso";
  final String tableShift = "turno";
  final String tableHour = 'hora';
  final String tableShiftPerHour = 'turno_hora';
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
        TurLet TEXT,
        TurDoc TEXT,
        FOREIGN KEY(TurCurCod) REFERENCES $tableCourse(CurCod)
      )''');
    await db.execute('''
      CREATE TABLE $tableShiftPerHour(
        TurHorCod TEXT PRIMARY KEY,
        TurCod TEXT,
        HorInd INTEGER,
        FOREIGN KEY(TurCod) REFERENCES $tableShift(TurCod)
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
        isRequired: maps[index]['CurReq'],
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
        TurLet: maps[index]['TurLet'],
        TurDoc: maps[index]['TurDoc'],
      );
    });
  }

  Future<void> insertShiftsHours(String turcod, List<int> items) async {
    await deleteShiftsHours(turcod, items);
    final db = await instance.database;
    await Future.forEach(items, (item) async {
      //print(turcod + ' Entrnado a insertShifthours ' + item.toString());
      final result = await db.insert(
          tableShiftPerHour, TurnoHorario(TurCod: turcod, HorInd: item).toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      /*if (result != null && result > 0) {
        print('Inserción exitosa. ID de la fila: $result');
      } else {
        print('Error al insertar el elemento: $item');
      }*/
    });
    items.clear();
  }

  Future<List<TurnoHorario>> getCourseHors(String turCod) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db
        .query(tableShiftPerHour, where: 'TurCod=?', whereArgs: [turCod]);
    /*if (maps.isNotEmpty) {
      print('Datos recuperados exitosamente. Número de filas: ${maps.length}');
    } else {
      print('No se encontraron datos para TurCod=$turCod');
    }*/
    return List.generate(maps.length, (index) {
      return TurnoHorario(
        TurCod: maps[index]['TurCod'],
        HorInd: maps[index]['HorInd'],
      );
    });
  }

  Future<List<TurnoHorario>> getAllHors() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableShiftPerHour);
    /*if (maps.isNotEmpty) {
      print('Datos recuperados exitosamente. Número de filas: ${maps.length}');
    } else {
      print('No se encontraron datos para TurCod=$turCod');
    }*/
    return List.generate(maps.length, (index) {
      return TurnoHorario(
        TurCod: maps[index]['TurCod'],
        HorInd: maps[index]['HorInd'],
      );
    });
  }

  Future<void> deleteShiftsHours(String turcod, List<int> items) async {
    final db = await instance.database;

    await Future.forEach(items, (item) async {
      //print(turcod + ' Entrando a deleteShiftsHours ' + item.toString());

      // Eliminar el elemento correspondiente
      final rowsDeleted = await db.delete(
        tableShiftPerHour,
        where: 'TurCod = ?',
        whereArgs: [turcod],
      );

      // Verificar si se eliminó la fila
      /*if (rowsDeleted > 0) {
        print('Eliminación exitosa. Filas eliminadas: $rowsDeleted');
      } else {
        print('Error al eliminar el elemento: $item');
      }*/
    });
  }
}
*/