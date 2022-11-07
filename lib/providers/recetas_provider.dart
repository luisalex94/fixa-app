import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
//import '../providers/constantes.dart' as constantes;

//Creamos AlimentoItem + Cantidad

String _recetaEdicionId = '';
bool alimentoDeReceta001 = false;

class AlimentoItemYCantidad {
  String alimentoId;
  double cantidad;

  AlimentoItemYCantidad({
    this.alimentoId,
    this.cantidad,
  });

  Map toJson() => {
        'alimentoId': alimentoId,
        'cantidad': cantidad,
      };
}

//Creamos el item RecetaIndividual
class RecetaItem {
  String id;
  String nombre;
  String resumen;
  int porciones;
  Map<String, double> alimentos = {};

  RecetaItem({
    this.id,
    this.nombre,
    this.resumen,
    this.porciones,
    this.alimentos,
  });

  Map toJson() => {
        'id': id,
        'nombre': nombre,
        'resumen': resumen,
        'porciones': porciones,
        'alimentos': alimentos,
      };
  //Map<String <AlimentoItem, dynamic>> alimentos;
}

class Receta with ChangeNotifier {
  //final Map<String, RecetaItem> _recetaItem = constantes.recetas;
  Map<String, RecetaItem> _recetaItem = {};

  //Este es el id de la receta en edición.
  /*void setIdRecetaEdicion(String idReceta) {
    _recetaEdicionId = idReceta;
  }*/

  String get getIdRecetaEdicion {
    return _recetaEdicionId;
  }

  Map<String, RecetaItem> get recetaItem {
    return {..._recetaItem};
  }

  int get contadorReceta {
    return _recetaItem.length;
  }

  int contadorAlimentosReceta(String idReceta) {
    return _recetaItem[idReceta].alimentos.length;
  }

  RecetaItem recetaPorId(String idReceta) {
    return _recetaItem[idReceta];
  }

  String nombreRecetaPorId(String idReceta) {
    return _recetaItem[idReceta].nombre;
  }

  void eliminaReceta(String idReceta) {
    _recetaItem.remove(idReceta);
    guardaRecetasLS();
    notifyListeners();
  }

  void eliminaAlimentosReceta(
    String idReceta,
    String idAlimento,
  ) {
    _recetaItem[idReceta].alimentos.remove(idAlimento);
    guardaRecetasLS();
    notifyListeners();
  }

  void agregarReceta(RecetaItem recetaIndividual) {
    final date = DateTime.now().toString();
    recetaIndividual.id = date;
    _recetaItem.putIfAbsent(recetaIndividual.id, () => recetaIndividual);
    guardaRecetasLS();
    notifyListeners();
  }

  void agregarAlimentosReceta(
    String idReceta,
    String idAlimento,
    double cantidadAlimento,
  ) {
    if (_recetaItem[idReceta].alimentos.containsKey(idAlimento)) {
      _recetaItem[idReceta]
          .alimentos
          .update(idAlimento, (value) => cantidadAlimento);
    }
    _recetaItem[idReceta]
        .alimentos
        .putIfAbsent(idAlimento, () => cantidadAlimento);
    guardaRecetasLS();
    notifyListeners();
  }

  void actualizaReceta(
    String idReceta,
    RecetaItem recetaIndividual,
  ) {
    _recetaItem.update(idReceta, (value) => recetaIndividual);
    guardaRecetasLS();
    notifyListeners();
  }

  void actualizaAlimentoReceta(
    String idReceta,
    String idAlimento,
    double cantidadAlimento,
  ) {
    RecetaItem recetaIndividual = _recetaItem[idReceta];
    recetaIndividual.alimentos[idAlimento] = cantidadAlimento;
    _recetaItem.update(idReceta, (value) => recetaIndividual);
    guardaRecetasLS();
    notifyListeners();
  }

  double porcionAlimentoReceta({String idAlimento, String idCanasta}) {
    return _recetaItem[idCanasta].alimentos[idAlimento];
  }

  void actualizaPorcionAlimentoReceta(
      {String idAlimento, String idCanasta, double porcion}) {
    _recetaItem[idCanasta].alimentos[idAlimento] = porcion;
    guardaRecetasLS();
    notifyListeners();
  }

  Map<String, double> resumenRecetasParaCarrito(
      Map<String, double> canastaRecetas) {
    Map<String, double> respuesta = {};
    canastaRecetas.forEach((keyReceta, cantidadReceta) {
      _recetaItem[keyReceta].alimentos.forEach((keyAlimento, cantidadAlimento) {
        respuesta.containsKey(keyAlimento)
            ? respuesta.update(keyAlimento,
                (value) => value + (cantidadAlimento * cantidadReceta))
            : respuesta.putIfAbsent(
                keyAlimento, () => (cantidadAlimento * cantidadReceta));
      });
    });
    return respuesta;
  }

  Map<String, double> getAlimentosReceta(String idReceta) {
    return _recetaItem[idReceta].alimentos;
  }

  double porcionesAlimentosPorRecetaId({String idReceta, String idAlimento}) {
    return _recetaItem[idReceta].alimentos[idAlimento];
  }

  //Metodos para guardar en archivos locales la receta
  //Encontramos la direccion local
  Future<String> get _direccionLocal async {
    final directorio = await getApplicationDocumentsDirectory();
    return directorio.path;
  }

  //Se crea la referencia a un archivo de la direccion local
  Future<File> get _archivoLocal async {
    final path = await _direccionLocal;
    return File('$path/recetario.txt');
  }

  //Escribimos la informacion (_recetaItem) en la referencia
  Future<File> guardaRecetasLS() async {
    final archivo = await _archivoLocal;
    String temporal = json.encode(_recetaItem);
    return archivo.writeAsString(temporal);
  }

  //Imprime el archivo recetario.txt
  /*void imprimeArchivo() async {
    final archivo = await _archivoLocal;
    final respuesta = await archivo.readAsString();
    print(json.decode(respuesta));
  }*/

  //Elimina archivo recetas Local Storage
  void eliminaArchivoRecetasLS() async {
    final archivo = await _archivoLocal;
    archivo.delete(recursive: true);
    notifyListeners();
    setRecetaItems();
  }

  //Regresa Future<Map<String, RecetaItem>> de _recetaItem guardado en archivo local
  Future<Map<String, RecetaItem>> getRecetaItemLS() async {
    final Map<String, RecetaItem> respuestaMetodo = {};
    final archivo = await _archivoLocal;
    final respuesta = await archivo.readAsString();
    Map<String, dynamic> respuestaDecofificada = json.decode(respuesta);
    respuestaDecofificada.forEach(
      (key, value) {
        respuestaMetodo.putIfAbsent(
          key,
          () => RecetaItem(
            id: value['id'],
            nombre: value['nombre'],
            resumen: value['resumen'],
            porciones: value['porciones'],
            alimentos: Map<String, double>.from(
              value['alimentos'],
            ),
          ),
        );
      },
    );
    return respuestaMetodo;
  }

  //Setea de guardado en archivo local a _recetaItem
  Future<void> setRecetaItems() async {
    try {
      Map<String, RecetaItem> respuestaDecofificada = await getRecetaItemLS();
      if (respuestaDecofificada == null) {
        _recetaItem = {};
        return;
      }
      _recetaItem = respuestaDecofificada;
      notifyListeners();
    } catch (error) {
      _recetaItem = {};
      notifyListeners();
      rethrow;
    }
  }

  //Actualiza al llamado de eliminacion de recetas con alimentos inexistentes
  Future<void> actualizaRecetasAlimentosInexistentes(
      Map<String, RecetaItem> actualizacion) async {
    try {
      Map<String, RecetaItem> respuestaDecofificada = await getRecetaItemLS();
      if (respuestaDecofificada == null) {
        _recetaItem = {};
        return;
      }
      _recetaItem = actualizacion;
      guardaRecetasLS();
      notifyListeners();
    } catch (error) {
      _recetaItem = {};
      guardaRecetasLS();
      notifyListeners();
      rethrow;
    }
  }
}
