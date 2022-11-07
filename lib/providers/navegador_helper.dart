// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class NavegadorDetalleAlimento {
  bool ver_alimento = false;
  bool ver_receta = false;
  bool ver_canasta = false;
  bool agregar_receta = false;
  bool agregar_canasta = false;
  String idAlimento = '';
  String idReceta = '';
  String idCanasta = '';

  NavegadorDetalleAlimento({
    this.ver_alimento = false,
    this.ver_receta = false,
    this.ver_canasta = false,
    this.agregar_receta = false,
    this.agregar_canasta = false,
    this.idAlimento = '',
    this.idReceta = '',
    this.idCanasta = '',
  });
}

final navegadorVacio = NavegadorDetalleAlimento(
  ver_alimento: false,
  ver_receta: false,
  ver_canasta: false,
  agregar_receta: false,
  agregar_canasta: false,
  idAlimento: '',
  idReceta: '',
  idCanasta: '',
);

class NavegadorHelper with ChangeNotifier {
  final NavegadorDetalleAlimento _navegadorDetalleAlimento = navegadorVacio;

  void setNavegadorDetalleAlimento({
    bool ver_alimento = false,
    bool ver_receta = false,
    bool ver_canasta = false,
    bool agregar_receta = false,
    bool agregar_canasta = false,
    String idAlimento = '',
    String idReceta = '',
    String idCanasta = '',
  }) {
    _navegadorDetalleAlimento.ver_alimento = ver_alimento;
    _navegadorDetalleAlimento.ver_receta = ver_receta;
    _navegadorDetalleAlimento.ver_canasta = ver_canasta;
    _navegadorDetalleAlimento.agregar_receta = agregar_receta;
    _navegadorDetalleAlimento.agregar_canasta = agregar_canasta;
    _navegadorDetalleAlimento.idAlimento = idAlimento;
    _navegadorDetalleAlimento.idReceta = idReceta;
    _navegadorDetalleAlimento.idCanasta = idCanasta;
  }

  NavegadorDetalleAlimento get getNavegadorDetalleAlimento {
    return _navegadorDetalleAlimento;
  }
}
