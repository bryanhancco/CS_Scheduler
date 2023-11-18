import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/database/firebase_operations.dart';

class BoolProvider extends ChangeNotifier {
  List<bool> _isChecked = [];
  List<Curso> _cursos = [];
  List<int> _turnos = [];
  List<bool> get checked => _isChecked;
  List<Curso> get cursos => _cursos;
  List<int> get turnos => _turnos;

  set check(List<bool> newName) {
    _isChecked = newName;
    notifyListeners();
  }

  void initCourses(List<Curso> lista) {
    _cursos.clear();
    _isChecked.clear();
    _turnos.clear();
    _cursos = [...lista];
    int num = _cursos.length;
    for (int i = 1; i <= num; i++) {
      _isChecked.add(true);
      _turnos.add(0);
    }
    notifyListeners();
  }

  bool getValue(int i) {
    return _isChecked[i];
  }

  void setValue(int i, bool newValue) {
    _isChecked[i] = newValue;
    notifyListeners();
  }

  void changeValue(int i) {
    _isChecked[i] = !_isChecked[i];
    notifyListeners();
  }

  void addItem() {
    //Añade booleano y turno
    _isChecked.add(false);
    _turnos.add(0);
  }

  void refresh() {
    notifyListeners();
  }
}
