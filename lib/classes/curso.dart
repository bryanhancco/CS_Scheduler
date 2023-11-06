class Curso {
  String nombre;
  List<int> aulas;
  List<List<int>> horas;
  List<String> docentes;
  bool obligatorio;
  List<int> preferencias;

  Curso(this.nombre, this.aulas, this.horas, this.docentes, this.obligatorio,
      this.preferencias);

  Curso.empty(
    this.nombre,
    this.obligatorio,
  )   : aulas = [],
        docentes = [],
        horas = [],
        preferencias = [];
}
