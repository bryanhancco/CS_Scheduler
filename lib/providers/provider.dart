import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoolProvider extends ChangeNotifier {
  List<bool> _isChecked = [];
  List<bool> get checked => _isChecked;

  set check(List<bool> newName) {
    _isChecked = newName;
    notifyListeners();
  }

  void initCourses(int n) {
    for (int i = 1; i <= n; i++) {
      _isChecked.add(true);
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
}
