import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/classes/models.dart';

class ShiftProvider extends ChangeNotifier {
  bool _refreshAll = true;
  List<bool> _isChecked = [];
  List<int> _turnos = [];
  List<bool> get checked => _isChecked;
  List<int> get turnos => _turnos;
  bool get refreshAll => _refreshAll;

  set setRefreshAll(bool newbool) {
    _refreshAll = newbool;
  }

  set check(List<bool> news) {
    _isChecked = news;
    notifyListeners();
  }

  set turnos(List<int> news) {
    _turnos = [...news];
    notifyListeners();
  }

  void chargeShifts(List<int> news) {
    _refreshAll = false;
    _turnos.clear();
    print("Cargando " + news.toString());
    _turnos = [...news];
    notifyListeners();
  }

  void initShifts(int num) {
    _isChecked.clear();
    _turnos.clear();
    for (int i = 1; i <= num; i++) {
      _isChecked.add(true);
      _turnos.add(0);
    }
  }

  bool getCheckValue(int i) {
    return _isChecked[i];
  }

  void changeCheckValue(int i) {
    //print("Cambiando " + i.toString());
    _refreshAll = false;
    _isChecked[i] = !_isChecked[i];
    notifyListeners();
  }

  void addItem(int i) {
    //Añade booleano y turno
    //_refreshAll = false;
    _isChecked.insert(i, false);
    _turnos.insert(i, 0);
    //notifyListeners();
  }

  int getShift(int i) {
    return _turnos[i];
  }

  void changeShift(int i, int? n) {
    if (n != null) {
      _refreshAll = false;
      _turnos[i] = n;
      notifyListeners();
    }
  }
}

class CourseProvider extends ChangeNotifier {
  List<Curso> _cursos = [];
  List<Curso> get cursos => _cursos;

  set cursos(List<Curso> newName) {
    _cursos.clear();
    _cursos = [...newName];
    notifyListeners();
  }

  void initCursos(List<Curso> newName) {
    _cursos.clear();
    _cursos = [...newName];
  }
}

class BlockProvider extends ChangeNotifier {
  bool _blocked = false;
  bool get blocked => _blocked;

  set blocked(bool newVal) {
    _blocked = newVal;
    notifyListeners();
  }

  void changeValue() {
    _blocked = !_blocked;
  }
}

class PosiblesProvider {
  static List<List<int>> posibles = [];

  static void addPosible(List<int> posible) {
    posibles.add(posible);
  }

  static List<int> getPosible(int i) {
    return [...posibles[i]];
  }

  static int getNumPosibles() {
    return posibles.length;
  }

  static void deleteAll() {
    posibles.clear();
  }
}
