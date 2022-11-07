import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

//Creamos el item Canasta:
class CanastaItem {
  String id;
  String nombre;
  String descripcion;
  Map<String, double> recetas = {};
  Map<String, double> alimentos = {};

  CanastaItem({
    this.id,
    this.nombre,
    this.descripcion,
    this.recetas,
    this.alimentos,
  });

  Map toJson() => {
        'id': id,
        'nombre': nombre,
        'descripcion': descripcion,
        'recetas': recetas,
        'alimentos': alimentos,
      };
}

final canastaUnica = {
  '0001': CanastaItem(
    id: '0001',
    nombre: 'Canasta única',
    descripcion: 'Canasta de alimentos general',
    recetas: {},
    alimentos: {},
  )
};

class Canasta with ChangeNotifier {
  Map<String, CanastaItem> _canastaItem = canastaUnica;

  Map<String, CanastaItem> get canastaItem {
    return {..._canastaItem};
  }

  Map<String, double> get recetas {
    return _canastaItem['0001'].recetas;
  }

  Map<String, double> get alimentos {
    return _canastaItem['0001'].alimentos;
  }

  int canastaAlimentosCount({String idCanasta}) {
    return _canastaItem[idCanasta].alimentos.length;
  }

  int canastaRecetasCount({String idCanasta}) {
    return _canastaItem[idCanasta].recetas.length;
  }

  //Obtiene alimentos de canasta
  Map<String, double> canastaAlimentosItems({String idCanasta}) {
    return _canastaItem[idCanasta].alimentos;
  }

  Map<String, double> canastaRecetasItems({String idCanasta}) {
    return _canastaItem[idCanasta].recetas;
  }

  double alimentoCantidadCanasta({String idAlimento, String idCanasta}) {
    return _canastaItem[idCanasta].alimentos[idAlimento];
  }

  double recetaCantidadCanasta({String idReceta, String idCanasta}) {
    return _canastaItem[idCanasta].recetas[idReceta];
  }

  void agregarRecetaACanasta(String idReceta, String idCanasta) {
    _canastaItem[idCanasta].recetas.putIfAbsent(idReceta, () => 1.0);
    guardaCanastaLS();
    notifyListeners();
  }

  void agregaAlimentoACanasta(
      {String idAlimento, String idCanasta, double cantidad}) {
    _canastaItem[idCanasta].alimentos.putIfAbsent(idAlimento, () => cantidad);
    guardaCanastaLS();
    notifyListeners();
  }

  void actualizaCantidadAlimentoCanasta(
      {String idAlimento, String idCanasta, double cantidad}) {
    _canastaItem[idCanasta].alimentos.update(idAlimento, (value) => cantidad);
    guardaCanastaLS();
    notifyListeners();
  }

  void adicionarCantidadAlimentoCanasta(
      {String idAlimento, String idCanasta, double cantidad}) {
    if (_canastaItem[idCanasta].alimentos.containsKey(idAlimento)) {
      _canastaItem[idCanasta]
          .alimentos
          .update(idAlimento, (value) => value + cantidad);
    }
    _canastaItem[idCanasta].alimentos.putIfAbsent(idAlimento, () => cantidad);
    guardaCanastaLS();
    notifyListeners();
  }

  void adicionarCantidadRecetaCanasta(
      {String idReceta, String idCanasta, double cantidad}) {
    if (_canastaItem[idCanasta].recetas.containsKey(idReceta)) {
      _canastaItem[idCanasta]
          .recetas
          .update(idReceta, (value) => value + cantidad);
    }
    _canastaItem[idCanasta].recetas.putIfAbsent(idReceta, () => cantidad);
    guardaCanastaLS();
    notifyListeners();
  }

  void actualizaCantidadRecetaCanasta(
      {String idReceta, String idCanasta, double cantidad}) {
    _canastaItem[idCanasta].recetas.update(idReceta, (value) => cantidad);
    guardaCanastaLS();
    notifyListeners();
  }

  void eliminaAlimentoCanasta({String idCanasta, String idAlimento}) {
    _canastaItem[idCanasta]
        .alimentos
        .removeWhere((key, value) => key == idAlimento);
    guardaCanastaLS();
    notifyListeners();
  }

  void eliminaRecetaCanasta({String idReceta}) {
    _canastaItem['0001'].recetas.remove(idReceta);
    guardaCanastaLS();
    notifyListeners();
  }

  void eliminaTodasLasRecetasCanasta() {
    _canastaItem['0001'].recetas = {};
    guardaCanastaLS();
    notifyListeners();
  }

  CanastaItem canastaPorId({String idCanasta}) {
    return _canastaItem[idCanasta];
  }

  int get canastaItemCount {
    return _canastaItem.length;
  }

  void sumaUnoPorAlimentoId(String idAlimento) {
    _canastaItem['0001']
        .alimentos
        .update(idAlimento, (cantidadAlimento) => cantidadAlimento + 1);
    guardaCanastaLS();
    notifyListeners();
  }

  void restaUnoPorAlimentoId(String idAlimento) {
    _canastaItem['0001'].alimentos[idAlimento] > 1
        ? _canastaItem['0001']
            .alimentos
            .update(idAlimento, (cantidadAlimento) => cantidadAlimento - 1)
        : _canastaItem['0001'].alimentos.remove(idAlimento);
    guardaCanastaLS();
    notifyListeners();
  }

  void sumaUnoPorRecetaId(String idReceta) {
    _canastaItem['0001']
        .recetas
        .update(idReceta, (cantidadReceta) => cantidadReceta + 1);
    guardaCanastaLS();
    notifyListeners();
  }

  void restaUnoPorRecetaId(String idReceta) {
    _canastaItem['0001'].recetas[idReceta] > 1
        ? _canastaItem['0001']
            .recetas
            .update(idReceta, (cantidadReceta) => cantidadReceta - 1)
        : _canastaItem['0001'].recetas.remove(idReceta);
    guardaCanastaLS();
    notifyListeners();
  }

  double getCantidadRecetaId(String idReceta) {
    return _canastaItem['0001'].recetas[idReceta];
  }

  //Metodos para guardar en archivos locales la canasta
  //Encontramos la direccion local
  Future<String> get _direccionLocal async {
    final directorio = await getApplicationDocumentsDirectory();
    return directorio.path;
  }

  //Se crea la referencia a un archivo de la direccion local
  Future<File> get _archivoLocal async {
    final path = await _direccionLocal;
    return File('$path/canasta.txt');
  }

  //Se escribe la informacion (_canastaItem) en la referencia
  Future<File> guardaCanastaLS() async {
    final archivo = await _archivoLocal;
    String temporal = json.encode(_canastaItem);
    return archivo.writeAsString(temporal);
  }

  //Elimina archivo canasta Local Storage
  void eliminaArchivoCanastaLS() async {
    final archivo = await _archivoLocal;
    archivo.delete();
  }

  /*void imprimeCanastaLS() async {
    final archivo = await _archivoLocal;
    final respuesta = await archivo.readAsString();
    Map<String, dynamic> respuestaDecodificada = json.decode(respuesta);
    (json.decode(respuesta));
    (_canastaItem);
    _canastaItem.forEach(
      (key, value) {
        (key);
        ('id: ${value.id}');
        ('nombre: ${value.nombre}');
        ('descripcion: ${value.descripcion}');
        ('alimentos: ${value.alimentos}');
        ('recetas ${value.recetas}');
      },
    );
  }*/

  Future<Map<String, CanastaItem>> getCanastaItemLS() async {
    final Map<String, CanastaItem> respuestaMetodo = {};
    final archivo = await _archivoLocal;
    final respuesta = await archivo.readAsString();
    Map<String, dynamic> respuestaDecodificada = json.decode(respuesta);
    respuestaDecodificada.forEach(
      (key, value) {
        respuestaMetodo.putIfAbsent(
          key,
          () => CanastaItem(
            id: value['id'],
            nombre: value['nombre'],
            descripcion: value['descripcion'],
            recetas: Map<String, double>.from(value['recetas']),
            alimentos: Map<String, double>.from(value['alimentos']),
          ),
        );
      },
    );
    return respuestaMetodo;
  }

  Future<void> setCanastaItem() async {
    try {
      Map<String, CanastaItem> respuestaDecodificada = await getCanastaItemLS();
      if (respuestaDecodificada == null) {
        _canastaItem = canastaUnica;
        return;
      }
      _canastaItem = respuestaDecodificada;
      notifyListeners();
    } catch (error) {
      notifyListeners();
      _canastaItem = canastaUnica;
      rethrow;
    }
  }
}
