class Curso {
  String nombre;
  List<String> aulas;
  List<List<int>> horas;
  List<String> docentes;
  bool obligatorio;
  List<int> preferencias;
  List<Turno> turnos;

  Curso(this.nombre, this.aulas, this.horas, this.docentes, this.obligatorio,
      this.preferencias, this.turnos);

  Curso.empty(
    this.nombre,
    this.obligatorio,
  )   : aulas = [],
        docentes = [],
        horas = [],
        preferencias = [],
        turnos = [];

  static List<Curso> ejemplos = [
    Curso(
        "Metodos Numéricos",
        ["306", "306", "306"],
        [
          [16, 21, 26],
          [43, 48, 53],
          [28, 33, 38]
        ],
        ["Olha", "Olha", "Olha"],
        true,
        [],
        [
          Turno('A', 'Olha', [
            Horario('Lunes', '8:00', '8:40'),
          ]),
          Turno('B', 'Norka', [
            Horario('Martes', '8:50', '9:40'),
          ]),
          Turno('C', 'NorkaOlha', [
            Horario('Miercoles', '13:00', '13:40'),
          ]),
        ]),
    Curso(
        "Sistemas Operativos",
        ["306", "306", "306"],
        [
          [27, 32, 14, 19],
          [51, 56, 44, 49],
          [37, 42, 24, 29]
        ],
        ["Karim", "Aceituno", "Karim"],
        true,
        [],
        []),
    Curso(
        "Construcción de Software",
        ["306", "306"],
        [
          [2, 7],
          [36, 41]
        ],
        ["Arroyo", "Arroyo"],
        true,
        [],
        []),
    Curso(
        "Tecnología de objetos",
        ["306", "306", "302"],
        [
          [54, 59, 5, 10],
          [71, 76, 74, 79],
          [72, 77, 75, 80]
        ],
        ["Bornas", "Bornas", "Sardón"],
        true,
        [],
        []),
    Curso(
        "Redes",
        ["205", "306"],
        [
          [28, 33, 34, 39],
          [57, 62, 68, 73]
        ],
        ["Lucy", "Lino"],
        true,
        [],
        []),
    Curso(
        "IDSE",
        ["205", "306"],
        [
          [27, 32, 37],
          [41, 46, 51]
        ],
        ["Giovanni", "Giovanni"],
        true,
        [],
        []),
    Curso(
        "Aspectos",
        ["306", "306", "302"],
        [
          [5, 10],
          [42, 47],
          [31, 36]
        ],
        ["Maribel", "Maribel", "Maribel"],
        true,
        [],
        []),
    Curso(
        "Fundamentos",
        ["306", "306", "306"],
        [
          [18, 23, 20, 25, 30],
          [58, 63, 35, 40, 45],
          [3, 8, 13, 4, 9]
        ],
        ["Juarez", "Juarez", "Juarez"],
        true,
        [],
        []),
    Curso(
        "Lab- MN",
        ["306", "306", "306", "306"],
        [
          [32, 37],
          [64, 69],
          [1, 6],
          [42, 47]
        ],
        ["Polanco", "Polanco", "Polanco", "Polanco"],
        true,
        [],
        []),
    Curso(
        "Lab- CS",
        ["306", "306", "306"],
        [
          [6, 11, 12, 17],
          [16, 21, 33, 38],
          [26, 31, 27, 32]
        ],
        ["Arroyo", "Arroyo", "Arroyo"],
        true,
        [],
        []),
    Curso(
        "Lab- SO",
        ["306", "306", "306", "306"],
        [
          [12, 17],
          [48, 53],
          [11, 16],
          [58, 63]
        ],
        ["Aceituno", "Aceituno", "Aceituno", "Aceituno"],
        true,
        [],
        []),
    Curso(
        "Lab- Aspectos",
        ["306", "306", "306", "306"],
        [
          [4, 9],
          [41, 46],
          [51, 56],
          [53, 58]
        ],
        ["Maribel", "Maribel", "Ramiro", "Ramiro"],
        true,
        [],
        []),
    Curso(
        "Lab Redes",
        ["306", "306"],
        [
          [24, 29],
          [56, 61]
        ],
        ["Lucy", "Lino"],
        true,
        [],
        []),
    Curso(
        "Lab- TO",
        ["306", "306", "306", "306", "306"],
        [
          [22, 27],
          [56, 61],
          [34, 39],
          [44, 49],
          [24, 29]
        ],
        ["Bornas", "Bornas", "Karen", "Karen", "Karen"],
        true,
        [],
        []),
    Curso(
        "Lab - IDSE",
        ["205", "306", "306"],
        [
          [18, 23],
          [42, 47],
          [52, 57]
        ],
        ["Giovanni", "Giovanni", "Giovanni"],
        true,
        [],
        []),
  ];
}

class Turno {
  final String turnoName;
  final String docente;
  List<Horario> horas = [];
  Turno(this.turnoName, this.docente, this.horas);
}

class Horario {
  final String dia;
  final String horaInicio;
  final String horaFin;
  Horario(this.dia, this.horaInicio, this.horaFin);
}
