import 'package:flutter/material.dart';

abstract class BaseViewmodel extends ChangeNotifier {
  bool loading = false;

  void setLoading(bool value) {
    loading = value;
    notifyListeners(); // <--- SIN ESTO NO FUNCIONA
  }
}