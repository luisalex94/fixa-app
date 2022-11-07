// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:fixa_app/providers/recetas_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'constantes.dart' as constantes;

//Creamos el item Resumen:
class Resumen {
  String id = '';
  double cant_suge = 0;
  String unidad = '';
  double peso_bruto_g = 0;
  double peso_neto_g = 0;
  double energia_kcal = 0;
  double proteina_g = 0;
  double lipidos_g = 0;
  double hidra_carbo_g = 0;
  double fibra_g = 0;
  double sodio_mg = 0;
  double colesterol_mg = 0;

  Resumen({
    this.id,
    this.cant_suge,
    this.unidad,
    this.peso_bruto_g,
    this.peso_neto_g,
    this.energia_kcal,
    this.proteina_g,
    this.lipidos_g,
    this.hidra_carbo_g,
    this.fibra_g,
    this.sodio_mg,
    this.colesterol_mg,
  });

  Map toJson() => {
        'id': id,
        'cant_suge': cant_suge,
        'unidad': unidad,
        'peso_bruto_g': peso_bruto_g,
        'peso_neto_g': peso_neto_g,
        'energia_kcal': energia_kcal,
        'proteina_g': proteina_g,
        'lipidos_g': lipidos_g,
        'hidra_carbo_g': hidra_carbo_g,
        'fibra_g': fibra_g,
        'sodio_mg': sodio_mg,
        'colesterol_mg': colesterol_mg,
      };
}

//Creamos el item Alimento:
class AlimentoItem {
  String id = '';
  String nombre = '';
  bool esFavorito = false;
  double clasificacion = 0;
  double porcion = 0;
  String categoria = '';
  Resumen resumen = Resumen();

  AlimentoItem({
    this.id,
    this.nombre,
    this.esFavorito,
    this.clasificacion,
    this.porcion,
    this.categoria,
    this.resumen,
  });

  Map toJson() => {
        'id': id,
        'nombre': nombre,
        'esFavorito': esFavorito,
        'clasificacion': clasificacion,
        'porcion': porcion,
        'categoria': categoria,
        'resumen': resumen,
      };
}

var _nuevoAlimento = {
  'alimItem_id': '',
  'alimItem_nombre': '',
  'alimItem_esFavorito': '',
  'alimItem_clasificacion': '',
  'alimItem_porcion': '',
  'alimItem_categoria': '',
  'resumen_id': '',
  'resumen_cant_suge': '',
  'resumen_unidad': '',
  'resumen_peso_bruto_g': '',
  'resumen_peso_neto_g': '',
  'resumen_energia_kcal': '',
  'resumen_proteina_g': '',
  'resumen_lipidos_g': '',
  'resumen_hidra_carbo_g': '',
  'resumen_fibra_g': '',
  'resumen_sodio_mg': '',
  'resumen_colesterol_mg': '',
};

//Creamos una lista de item de Alimento:
class Alimentos with ChangeNotifier {
  Map<String, AlimentoItem> _alimentosItem = {};

  Map<String, AlimentoItem> get alimentosItem {
    return {..._alimentosItem};
  }

  int get alimentosItemCount {
    return _alimentosItem.length;
  }

  void alimentosItemElimina(String id) {
    _alimentosItem.remove(id);
    guardaAlimentosLS();
    notifyListeners();
  }

  void alimentosItemAgregar(AlimentoItem alimentoItem) {
    final date = DateTime.now().toString();
    alimentoItem.id = date;
    alimentoItem.resumen.id = date;
    alimentoItem.porcion = 1.0;
    _alimentosItem.putIfAbsent(alimentoItem.id, () => alimentoItem);
    guardaAlimentosLS();
    notifyListeners();
  }

  AlimentoItem alimentoPorId(String id) {
    return _alimentosItem[id];
  }

  String nombreAlimentoPorId(String id) {
    return _alimentosItem[id].nombre;
  }

  void cambiaEstadoFavorito(String idAlimento) {
    _alimentosItem[idAlimento].esFavorito =
        !_alimentosItem[idAlimento].esFavorito;
    guardaAlimentosLS();
    notifyListeners();
  }

  bool getEsFavorito(String idAlimento) {
    return _alimentosItem[idAlimento].esFavorito;
  }

  void alimentoActualizar(String id, AlimentoItem alimentoInformacion) {
    _alimentosItem.update(id, (value) => alimentoInformacion);
    guardaAlimentosLS();
    notifyListeners();
  }

  AlimentoItem alimentoPropiedadesPorcion(String id, double cantidad) {
    double relacion = cantidad;
    AlimentoItem datosOriginales = alimentoPorId(id);
    //Información se carga de datosOriginales a _nuevoAlimento para despues asi
    //gnar los valores de _nuevoAlimento a un nuevo AlimentoItem.
    _nuevoAlimento['alimItem_id'] = datosOriginales.id;
    _nuevoAlimento['alimItem_nombre'] = datosOriginales.nombre;
    _nuevoAlimento['alimItem_esFavorito'] =
        datosOriginales.esFavorito.toString();
    _nuevoAlimento['alimItem_clasificacion'] =
        datosOriginales.clasificacion.toString();
    _nuevoAlimento['alimItem_porcion'] = datosOriginales.porcion.toString();
    _nuevoAlimento['alimItem_categoria'] = datosOriginales.categoria;
    _nuevoAlimento['resumen_id'] = datosOriginales.resumen.id;
    _nuevoAlimento['resumen_cant_suge'] =
        datosOriginales.resumen.cant_suge.toString();
    _nuevoAlimento['resumen_unidad'] = datosOriginales.resumen.unidad;
    _nuevoAlimento['resumen_peso_bruto_g'] =
        datosOriginales.resumen.peso_bruto_g.toString();
    _nuevoAlimento['resumen_peso_neto_g'] =
        datosOriginales.resumen.peso_neto_g.toString();
    _nuevoAlimento['resumen_energia_kcal'] =
        datosOriginales.resumen.energia_kcal.toString();
    _nuevoAlimento['resumen_proteina_g'] =
        datosOriginales.resumen.proteina_g.toString();

    _nuevoAlimento['resumen_lipidos_g'] =
        datosOriginales.resumen.lipidos_g.toString();
    _nuevoAlimento['resumen_hidra_carbo_g'] =
        datosOriginales.resumen.hidra_carbo_g.toString();

    _nuevoAlimento['resumen_fibra_g'] =
        datosOriginales.resumen.fibra_g.toString();

    _nuevoAlimento['resumen_sodio_mg'] =
        datosOriginales.resumen.sodio_mg.toString();

    _nuevoAlimento['resumen_colesterol_mg'] =
        datosOriginales.resumen.colesterol_mg.toString();

    //Se asignan los valores de _nuevoAlimento a nuevoAlimento, en el proceso s
    //e multiplican los valores por el valor correspondiente de porcion.

    var nuevoAlimento = AlimentoItem(
      id: _nuevoAlimento['alimItem_id'],
      nombre: _nuevoAlimento['alimItem_nombre'],
      esFavorito: datosOriginales.esFavorito,
      clasificacion: double.parse(_nuevoAlimento['alimItem_clasificacion']),
      porcion: double.parse(_nuevoAlimento['alimItem_porcion']) * relacion,
      categoria: _nuevoAlimento['alimItem_categoria'],
      resumen: Resumen(
        id: _nuevoAlimento['resumen_id'],
        cant_suge: double.parse(_nuevoAlimento['resumen_cant_suge']),
        unidad: _nuevoAlimento['resumen_unidad'],
        peso_bruto_g:
            double.parse(_nuevoAlimento['resumen_peso_bruto_g']) * relacion,
        peso_neto_g:
            double.parse(_nuevoAlimento['resumen_peso_neto_g']) * relacion,
        energia_kcal:
            double.parse(_nuevoAlimento['resumen_energia_kcal']) * relacion,
        proteina_g:
            double.parse(_nuevoAlimento['resumen_proteina_g']) * relacion,
        lipidos_g: double.parse(_nuevoAlimento['resumen_lipidos_g']) * relacion,
        hidra_carbo_g:
            double.parse(_nuevoAlimento['resumen_hidra_carbo_g']) * relacion,
        fibra_g: double.parse(_nuevoAlimento['resumen_fibra_g']) * relacion,
        sodio_mg: double.parse(_nuevoAlimento['resumen_sodio_mg']) * relacion,
        colesterol_mg:
            double.parse(_nuevoAlimento['resumen_colesterol_mg']) * relacion,
      ),
    );
    relacion = 0;
    return nuevoAlimento;
  }

  Map<String, AlimentoItem> alimentosItemCategoria(String categoria) {
    Map<String, AlimentoItem> respuesta = {};
    _alimentosItem.forEach((key, value) {
      if (value.categoria == categoria) {
        respuesta.putIfAbsent(value.id, () => _alimentosItem[value.id]);
      }
    });
    return respuesta;
  }

  Map<String, AlimentoItem> alimentosItemFavoritos() {
    Map<String, AlimentoItem> respuesta = {};
    _alimentosItem.forEach((key, value) {
      if (value.esFavorito == true) {
        respuesta.putIfAbsent(value.id, () => _alimentosItem[value.id]);
      }
    });
    return respuesta;
  }

  //Respuesta temporal
  final Map<String, AlimentoItem> _alimentosRecetaTemporal = {};

  Map<String, AlimentoItem> alimentosReceta(Map<String, double> temp_receta) {
    _alimentosRecetaTemporal.clear();
    temp_receta.forEach(
      (key, value) {
        _alimentosRecetaTemporal.putIfAbsent(
            key, () => alimentoPropiedadesPorcion(key, value));
      },
    );
    return _alimentosRecetaTemporal;
  }

  Map<String, AlimentoItem> get alimentosRecetaTemporal {
    return {..._alimentosRecetaTemporal};
  }

  void limpiaAlimentosRecetaTemporal() {
    _alimentosRecetaTemporal.clear();
  }

  double getKcalPorRecetaId(Map<String, double> alimentosReceta) {
    double respuesta = 0.0;
    alimentosReceta.forEach((idAlimento, cantidadAlimento) {
      respuesta = respuesta +
          alimentoPropiedadesPorcion(idAlimento, cantidadAlimento)
              .resumen
              .energia_kcal;
    });
    return respuesta;
  }

  double getPesoBrutoPorAlimentoPorReceta(
      Map<String, double> alimentosReceta, String idAlimento) {
    double respuesta = 0.0;
    respuesta = _alimentosItem[idAlimento].resumen.peso_bruto_g *
        alimentosReceta[idAlimento];
    return respuesta;
  }

  double getEnergiaKcalPorAlimentoPorReceta(
      Map<String, double> alimentosReceta, String idAlimento) {
    double respuesta = 0.0;
    respuesta = _alimentosItem[idAlimento].resumen.energia_kcal *
        alimentosReceta[idAlimento];
    return respuesta;
  }

  double getPesoBrutoPorReceta(Map<String, double> alimentosReceta) {
    double respuesta = 0.0;
    alimentosReceta.forEach((idAlimento, cantidadAlimento) {
      respuesta = respuesta +
          (_alimentosItem[idAlimento].resumen.peso_bruto_g * cantidadAlimento);
    });
    return respuesta;
  }

  double getEnergiaKcalPorReceta(Map<String, double> alimentosReceta) {
    double respuesta = 0.0;
    alimentosReceta.forEach((idAlimento, cantidadAlimento) {
      respuesta = respuesta +
          (_alimentosItem[idAlimento].resumen.energia_kcal * cantidadAlimento);
    });
    return respuesta;
  }

  double getProteinaPorReceta(Map<String, double> alimentosReceta) {
    double respuesta = 0.0;
    alimentosReceta.forEach((idAlimento, cantidadAlimento) {
      respuesta = respuesta +
          (_alimentosItem[idAlimento].resumen.proteina_g * cantidadAlimento);
    });
    return respuesta;
  }

  Map<String, AlimentoItem> _alimentosCanasta = {};

  Map<String, AlimentoItem> getAlimentosCanasta(
      Map<String, double> alimentosCanasta) {
    _alimentosCanasta = {};
    alimentosCanasta.forEach(
      (idAlimentoCanasta, cantidadAlimentoCanasta) {
        cantidadAlimentoCanasta > 0
            ? _alimentosCanasta.containsKey(idAlimentoCanasta)
                ? _alimentosCanasta.update(
                    idAlimentoCanasta,
                    (value) => alimentoPropiedadesPorcion(
                        idAlimentoCanasta, cantidadAlimentoCanasta))
                : _alimentosCanasta.putIfAbsent(
                    idAlimentoCanasta,
                    () => alimentoPropiedadesPorcion(
                        idAlimentoCanasta, cantidadAlimentoCanasta))
            : [
                _alimentosCanasta.remove(idAlimentoCanasta),
              ];
      },
    );
    return _alimentosCanasta;
  }

  //Metodos para guardar en archivos locales los alimentos
  //Encontramos la direccion local
  Future<String> get _direccionLocal async {
    final directorio = await getApplicationDocumentsDirectory();
    return directorio.path;
  }

  //Se crea la referencia a un archivo de la direccion local
  Future<File> get _archivoLocal async {
    final path = await _direccionLocal;
    return File('$path/alimentosOriginales');
  }

  //Escribimos la informacion (_alimentosItem) en la referencia
  Future<File> guardaAlimentosLS() async {
    final archivo = await _archivoLocal;
    String temporal = json.encode(_alimentosItem);
    return archivo.writeAsString(temporal);
  }

  //Imprime el archivo alimentosOriginales.txt
  /*void imprimeArchivo() async {
    final archivo = await _archivoLocal;
    final respuesta = await archivo.readAsString();
  }*/

  //Elimina archivo alimentosOriginales Local Storage
  void eliminaArchivoAlimentosOriginalesLS() async {
    final archivo = await _archivoLocal;
    archivo.delete(recursive: true);
    notifyListeners();
  }

  Future<File> restauraAlimentosOriginales() async {
    final archivo = await _archivoLocal;
    String temporal = json.encode(constantes.alimentos);
    return archivo.writeAsString(temporal);
  }

  Map<String, RecetaItem> eliminaRecetasConAlimentosInexistentes(
    Map<String, RecetaItem> recetasOriginal,
  ) {
    bool flag = true;
    recetasOriginal.forEach((key, value) {});
    recetasOriginal.removeWhere(
      (idReceta, recetaItem) {
        recetaItem.alimentos.forEach(
          (idAlimento, cantidadAlimento) {
            flag = true;
            _alimentosItem.forEach(
              (key, value) {
                if (value.id.contains(idAlimento)) {
                  flag = false;
                }
              },
            );
          },
        );
        return flag;
      },
    );
    recetasOriginal.forEach((key, value) {});
    return recetasOriginal;
  }

  Future<Map<String, AlimentoItem>> getAlimentoItemLS() async {
    final Map<String, AlimentoItem> respuestaMetodo = {};
    final archivo = await _archivoLocal;
    final respuesta = await archivo.readAsString();
    Map<String, dynamic> respuestaDecodificada = json.decode(respuesta);
    respuestaDecodificada.forEach(
      (key, alimentoItem) {
        respuestaMetodo.putIfAbsent(
          key,
          () => AlimentoItem(
            id: alimentoItem['id'],
            nombre: alimentoItem['nombre'],
            esFavorito: alimentoItem['esFavorito'],
            clasificacion: alimentoItem['clasificacion'],
            porcion: alimentoItem['porcion'],
            categoria: alimentoItem['categoria'],
            resumen: Resumen(
              id: alimentoItem['resumen']['id'],
              cant_suge: alimentoItem['resumen']['cant_suge'],
              unidad: alimentoItem['resumen']['unidad'],
              peso_bruto_g: alimentoItem['resumen']['peso_bruto_g'],
              peso_neto_g: alimentoItem['resumen']['peso_neto_g'],
              energia_kcal: alimentoItem['resumen']['energia_kcal'],
              proteina_g: alimentoItem['resumen']['proteina_g'],
              lipidos_g: alimentoItem['resumen']['lipidos_g'],
              hidra_carbo_g: alimentoItem['resumen']['hidra_carbo_g'],
              fibra_g: alimentoItem['resumen']['fibra_g'],
              sodio_mg: alimentoItem['resumen']['sodio_mg'],
              colesterol_mg: alimentoItem['resumen']['colesterol_mg'],
            ),
          ),
        );
      },
    );
    return respuestaMetodo;
  }

  Future<void> setAlimentoItems() async {
    try {
      Map<String, AlimentoItem> respuestaDecodificada =
          await getAlimentoItemLS();
      if (respuestaDecodificada == null) {
        _alimentosItem = constantes.alimentos;
        return;
      }
      if (respuestaDecodificada.isEmpty) {
        _alimentosItem = constantes.alimentos;
        return;
      }
      _alimentosItem = respuestaDecodificada;
      notifyListeners();
    } catch (error) {
      _alimentosItem = constantes.alimentos;
      notifyListeners();
      rethrow;
    }
  }
}
