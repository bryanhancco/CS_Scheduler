import 'dart:math';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

/* ->  Clase Curso <-  */

class Curso {
  final String UserEmail;
  final String CurCod;
  final String CurNom;
  int isRequired;
  final List<Turno> CurTur;

  Curso({
    required this.UserEmail,
    required this.CurCod,
    required this.CurNom,
    required this.isRequired,
    required this.CurTur,
  });

  Curso.empty(this.UserEmail, this.CurCod, this.CurNom, this.isRequired) : CurTur = [];

  Map<String, dynamic> toMap() {
    return {
      'UserEmail': UserEmail,
      'CurCod': CurCod,
      'CurNom': CurNom,
      'CurReq': isRequired,
      'CurTur': CurTur.map((curso) => curso.toMap()).toList(),
    };
  }

  List<int> getNumTurnos() {
    List<int> numturnos = [];
    return numturnos;
  }

  static Curso fromJson(Map<String, dynamic> json) {
    var listaTurnos = json['CurTur'] as List;
    if (listaTurnos.isEmpty) {
      return Curso.empty(json['UserEmail'], json['CurCod'], json['CurNom'], json['CurReq']);
    } else {
      return Curso(
        UserEmail: json['UserEmail'],
        CurCod: json['CurCod'],
        CurNom: json['CurNom'],
        isRequired: json['CurReq'],
        CurTur: listaTurnos.map((turno) => Turno.fromJson(turno)).toList(),
      );
    }
  }

  List<String> getLetras() {
    List<String> letras = [];
    CurTur.forEach((element) {
      letras.add(element.TurLet);
    });
    return letras;
  }

  void addShift(Turno turno) {
    CurTur.add(turno);
  }
}

/* -> Conversion de Curso a Calendar <-  */

class CourseDataSource extends CalendarDataSource {
  List<int> horas = [
    7,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21
  ];
  List<int> minutos = [
    0,
    50,
    50,
    40,
    40,
    30,
    20,
    10,
    0,
    50,
    50,
    40,
    30,
    30,
    20,
    10,
    0
  ];

  List<String> diasSemana = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes'
  ];

  List<int> diasInt = [4, 5, 6, 7, 8];
  List<Color> colores = [];

  var today;
  CourseDataSource(
      List<Curso> source, List<int> indicesTurnos, List<bool> booleanos) {
    List<Hora> horas = [];
    for (int i = 0; i < source.length; i++) {
      Color nuevo = generarColor(i);
      if (source[i].CurTur.isEmpty || !booleanos[i]) {
        continue;
      }

      source[i].CurTur[indicesTurnos[i]].horas.forEach((element) {
        horas.add(Hora(source[i].CurNom, element));
        colores.add(nuevo);
      });
    }
    appointments = horas;
    today = DateTime.now();
  }

  DateTime tranform(int nroHora) {
    //Index empieza en 0
    int day = diasInt[nroHora % 5];
    int bloque = nroHora ~/ 5;
    int hourIni = horas[bloque];
    int minIni = minutos[bloque];
    final date = DateTime(today.year, today.month, day, hourIni, minIni, 0);
    return date;
  }

  @override
  DateTime getStartTime(int index) {
    int nroHora = appointments![index].nro - 1;
    int day = diasInt[nroHora % 5];
    int bloque = nroHora ~/ 5;
    int hourIni = horas[bloque];
    int minIni = minutos[bloque];
    final date = DateTime(today.year, today.month, day, hourIni, minIni, 0);
    //print("Hora inicio" + date.toString());
    return date;
  }

  @override
  DateTime getEndTime(int index) {
    int nroHora = appointments![index].nro - 1;
    int day = diasInt[nroHora % 5];
    int bloque = nroHora ~/ 5 + 1;
    int hourIni = horas[bloque];
    int minIni = minutos[bloque];
    final date = DateTime(today.year, today.month, day, hourIni, minIni, 0);
    //print("Hora fin" + date.toString());
    return date;
  }

  @override
  String getSubject(int index) {
    return appointments![index].nombre;
  }

  @override
  Color getColor(int index) {
    return colores[index];
  }

  Color generarColor(int index) {
    Random random = Random(
        index); // Utiliza el índice para inicializar la semilla del generador aleatorio
    int red = random.nextInt(128) + 60; // Rango: 128-255
    int green = random.nextInt(128) + 60; // Rango: 128-255
    int blue = random.nextInt(128) + 60; // Rango: 128-255

    return Color.fromARGB(255, red, green, blue);
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}

/* ->  Clase Turno <-  */

class Turno {
  final String TurLet; //Letra
  final String TurDoc; //Docente
  final List<int> horas;
  final int preferido;

  Turno(
      {required this.TurLet,
      required this.TurDoc,
      required this.horas,
      required this.preferido});

  Turno.empty(
      this.TurLet, //Letra
      this.TurDoc)
      : this.horas = [],
        this.preferido = 1;

  Map<String, dynamic> toMap() {
    return {
      'TurLet': TurLet,
      'TurDoc': TurDoc,
      'horas': horas,
      'preferido': preferido,
    };
  }

  static Turno fromJson(Map<String, dynamic> json) {
    var listaHoras = json['horas'] as List;
    return Turno(
      TurLet: json['TurLet'],
      TurDoc: json['TurDoc'],
      preferido: json['preferido'],
      horas: listaHoras.cast<int>().toList(),
    );
  }
}

/* ->  Clase Hora <-  */

class Hora {
  final String nombre;
  final int nro;

  Hora(this.nombre, this.nro);
}

/* ->  Clase TurnoHorario <-  */

class TurnoHorario {
  final String TurCod;
  final int HorInd;
  TurnoHorario({required this.TurCod, required this.HorInd});

  Map<String, dynamic> toMap() {
    return {
      'TurHorCod': TurCod + HorInd.toString(),
      'TurCod': TurCod,
      'HorInd': HorInd,
    };
  }
}
