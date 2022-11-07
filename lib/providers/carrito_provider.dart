import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DetalleCarrito {
  double carrito = 0.0;
  double enCasa = 0.0;
  bool listo = false;

  DetalleCarrito({
    @required this.carrito,
    @required this.enCasa,
    @required this.listo,
  });

  Map toJson() => {
        'carrito': carrito,
        'enCasa': enCasa,
        'pendiente': listo,
      };
}

//Creamos el carrito:
class CarritoItem {
  Map<String, DetalleCarrito> carrito = {};

  CarritoItem({
    this.carrito,
  });
}

final carritoVacio = CarritoItem(carrito: {});

class Carrito with ChangeNotifier {
  final CarritoItem _carritoItem = carritoVacio;

  CarritoItem carritoItem() {
    return _carritoItem;
  }

  void actualizaCarrito(Map<String, DetalleCarrito> actualizacion) {
    _carritoItem.carrito = actualizacion;
    guardaCarritoLS();
    notifyListeners();
  }

  Map<String, DetalleCarrito> carritoTotal() {
    return _carritoItem.carrito;
  }

  void switchPendiente({String idAlimentoCarrito}) {
    _carritoItem.carrito[idAlimentoCarrito].listo =
        !_carritoItem.carrito[idAlimentoCarrito].listo;

    guardaCarritoLS();
    notifyListeners();
  }

  bool getPendiente({String idAlimentoCarrito}) {
    return _carritoItem.carrito[idAlimentoCarrito].listo;
  }

  void sumaUnoEnCasa({String idAlimento}) {
    if (_carritoItem.carrito[idAlimento].enCasa <
        _carritoItem.carrito[idAlimento].carrito) {
      _carritoItem.carrito[idAlimento].enCasa =
          _carritoItem.carrito[idAlimento].enCasa + 1;

      guardaCarritoLS();
      notifyListeners();
    }
  }

  void restaUnoEnCasa({String idAlimento}) {
    if (_carritoItem.carrito[idAlimento].enCasa > 0) {
      _carritoItem.carrito[idAlimento].enCasa =
          _carritoItem.carrito[idAlimento].enCasa - 1;

      guardaCarritoLS();
      notifyListeners();
    }
  }

  double getEnCasa({String idAlimento}) {
    if (_carritoItem.carrito[idAlimento].enCasa <=
        _carritoItem.carrito[idAlimento].carrito) {
      return _carritoItem.carrito[idAlimento].enCasa;
    }
    _carritoItem.carrito[idAlimento].enCasa =
        _carritoItem.carrito[idAlimento].carrito;
    return _carritoItem.carrito[idAlimento].enCasa;
  }

  //Metodos para guardar en archivos locales la renta
  //Encontramos la direccion local
  Future<String> get _direccionLocal async {
    final direcotio = await getApplicationDocumentsDirectory();
    return direcotio.path;
  }

  //Se crea la referencia a un archivo de la direccion local
  Future<File> get _archivoLocal async {
    final path = await _direccionLocal;
    return File('$path/carrito.txt');
  }

  //Escribimos la informacion (_carritoItem) en la referencia
  Future<File> guardaCarritoLS() async {
    final archivo = await _archivoLocal;
    String temporal = json.encode(_carritoItem.carrito);
    return archivo.writeAsString(temporal);
  }

  /*void imprimeArchivoLS() async {
    final archivo = await _archivoLocal;
    final respuesta = await archivo.readAsString();
    print(json.decode(respuesta));
  }*/

  Future<Map<String, DetalleCarrito>> getCarritoItemLs() async {
    final Map<String, DetalleCarrito> respuestaMetodo = {};
    final archivo = await _archivoLocal;
    final respuesta = await archivo.readAsString();
    Map<String, dynamic> respuestaDecodificada = json.decode(respuesta);
    respuestaDecodificada.forEach(
      (key, value) {
        respuestaMetodo.putIfAbsent(
          key,
          () => DetalleCarrito(
            carrito: value['carrito'],
            enCasa: value['enCasa'],
            listo: value['pendiente'],
          ),
        );
      },
    );
    return respuestaMetodo;
  }

  Future<void> setCarritoItemsLS() async {
    try {
      Map<String, DetalleCarrito> respuestaDecodificada =
          await getCarritoItemLs();
      if (respuestaDecodificada == null) {
        _carritoItem.carrito = {};
        return;
      }
      _carritoItem.carrito = respuestaDecodificada;
      notifyListeners();
    } catch (error) {
      _carritoItem.carrito = {};
      notifyListeners();
      rethrow;
    }
  }
}
