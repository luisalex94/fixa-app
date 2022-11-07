// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Map<String, double> temp_receta = {};

class Temporales with ChangeNotifier {
  final Map<String, double> _temp_receta = {};

  Map<String, double> get getTempReceta {
    return {..._temp_receta};
  }

  int get contadorTempReceta {
    return _temp_receta.length;
  }

  void agregaTempReceta(String id, double cantidad) {
    if (_temp_receta.containsKey(id)) {
      _temp_receta.update(id, (value) => cantidad);
    } else {
      _temp_receta.putIfAbsent(id, () => cantidad);
    }
    notifyListeners();
  }

  void setEliminaCantidadAlimentosTempReceta(String idAlimento) {
    _temp_receta.remove(idAlimento);
    notifyListeners();
  }

  double getCantidadAlimentosTempReceta(String idAlimento) {
    return _temp_receta[idAlimento];
  }

  void limpiaTempReceta() {
    _temp_receta.clear();
  }
}
