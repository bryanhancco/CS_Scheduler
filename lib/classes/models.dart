class Curso {
  final String CurCod;
  final String CurNom;
  final int isObligatorio;

  Curso(this.CurCod, this.CurNom, this.isObligatorio);

  static List<Curso> ejemplos = [
    Curso(
        'MN',
        'Metodos Numéricos',
        1,),
  ];

  Curso.empty(
    this.CurCod,
    this.CurNom,
    this.isObligatorio
  );
}

class Turno {
  final String TurCod;
  final int TurCurCod;
  final String TurLet;
  final String TurDoc;
  
  Turno(this.TurCod, this.TurCurCod, this.TurLet, this.TurDoc);

  static List<Turno> ejeTur = [
    Turno('MN_A',1703244, 'A', 'Olha'),
    Turno('MN_B', 1703244, 'B', 'Norka'),
    Turno('MN_C', 1703244, 'C', 'Olha'),
  ];
}

class Horario {
  final String HorCod;
  final int HorInd;
  Horario(this.HorCod, this.HorInd);

  static List<Horario> horasExistentes = [
    Horario("H_1", 1),
  ];
}

class TurnoHorario {
  final String TurCod;
  final String HorCod;
  TurnoHorario(this.TurCod, this.HorCod);
  
  static List<TurnoHorario> ejemplosTurno = [
    TurnoHorario('MN_A', 'H_1'),
  ];
}

