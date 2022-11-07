import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/alimentos_provider.dart';
import '../../../providers/constantes.dart' as constantes;

class AgregaAlimentoScreen extends StatefulWidget {
  const AgregaAlimentoScreen({Key key}) : super(key: key);
  static const routeName = './agrega_alimento_screen';
  @override
  State<AgregaAlimentoScreen> createState() => _AgregaAlimentoScreenState();
}

class _AgregaAlimentoScreenState extends State<AgregaAlimentoScreen> {
  //Nodos para acceso en campos
  final _nombreAlimentoNode = FocusNode();
  final _porcionAlimentoNode = FocusNode();
  final _categoriaAlimentoNode = FocusNode();
  final _cantSugeResumenNode = FocusNode();
  final _unidadResumenNode = FocusNode();
  final _pesoBrutoResumenNode = FocusNode();
  final _pesoNetoResumenNode = FocusNode();
  final _energiaResumenNode = FocusNode();
  final _proteinaResumenNode = FocusNode();
  final _lipidosResumenNode = FocusNode();
  final _hidraCarboResumenNode = FocusNode();
  final _fibraResumenNode = FocusNode();
  final _sodioResumenNode = FocusNode();
  final _colestResumenNode = FocusNode();
  final _botonAgregar = FocusNode();

  //Llave global del formulario
  final _formKey = GlobalKey<FormState>();

  //Variables de inicio
  var _disparo_001 = true;

  //Inicializa valores
  var _datosAlimento = AlimentoItem(
    id: '',
    nombre: '',
    esFavorito: false,
    clasificacion: 0,
    porcion: 0,
    categoria: '',
    resumen: Resumen(
      id: '',
      cant_suge: 0,
      unidad: '',
      peso_bruto_g: 0,
      peso_neto_g: 0,
      energia_kcal: 0,
      proteina_g: 0,
      lipidos_g: 0,
      hidra_carbo_g: 0,
      fibra_g: 0,
      sodio_mg: 0,
      colesterol_mg: 0,
    ),
  );

  //Inicializa valores de edición para formulario
  var _datosAlimentoEdicion = {
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

  @override
  void didChangeDependencies() {
    if (_disparo_001) {
      final productoId = ModalRoute.of(context).settings.arguments as String;
      if (productoId != null) {
        _datosAlimento = Provider.of<Alimentos>(context, listen: false)
            .alimentoPorId(productoId);
        _datosAlimentoEdicion = {
          'alimItem_nombre': _datosAlimento.nombre,
          'alimItem_clasificacion': _datosAlimento.clasificacion.toString(),
          'alimItem_porcion': _datosAlimento.porcion.toString(),
          'alimItem_categoria': _datosAlimento.categoria,
          'resumen_cant_suge': _datosAlimento.resumen.cant_suge.toString(),
          'resumen_unidad': _datosAlimento.resumen.unidad,
          'resumen_peso_bruto_g':
              _datosAlimento.resumen.peso_bruto_g.toString(),
          'resumen_peso_neto_g': _datosAlimento.resumen.peso_neto_g.toString(),
          'resumen_energia_kcal':
              _datosAlimento.resumen.energia_kcal.toString(),
          'resumen_proteina_g': _datosAlimento.resumen.proteina_g.toString(),
          'resumen_lipidos_g': _datosAlimento.resumen.lipidos_g.toString(),
          'resumen_hidra_carbo_g':
              _datosAlimento.resumen.hidra_carbo_g.toString(),
          'resumen_fibra_g': _datosAlimento.resumen.fibra_g.toString(),
          'resumen_sodio_mg': _datosAlimento.resumen.sodio_mg.toString(),
          'resumen_colesterol_mg':
              _datosAlimento.resumen.colesterol_mg.toString(),
        };
      }
    }
    _disparo_001 = false;
    super.didChangeDependencies();
  }

  //Funcion para guardar formulario
  void _guardaAlimento() {
    final validacion = _formKey.currentState.validate();
    if (!validacion) {}
    _formKey.currentState.save();
    if (_datosAlimento.id != '') {
      Provider.of<Alimentos>(context, listen: false)
          .alimentoActualizar(_datosAlimento.id, _datosAlimento);
    } else {
      Provider.of<Alimentos>(context, listen: false)
          .alimentosItemAgregar(_datosAlimento);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    const listaCategorias = constantes.TIPO_ALIMENTO_LIST;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromARGB(255, 15, 167, 152),
            Color.fromARGB(255, 242, 192, 43)
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: _datosAlimentoEdicion['nombre'] == ''
              ? const Text('Agregar alimento')
              : Text('Edita ${_datosAlimentoEdicion['alimItem_nombre']}',
                  style: const TextStyle(color: Colors.white)),
          actions: <Widget>[
            IconButton(
              focusNode: _botonAgregar,
              icon: const Icon(Icons.save),
              onPressed: _guardaAlimento,
            )
          ],
        ),
        body: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Colors.white24,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              const Text(
                                'Datos principales',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                              //TextForm NOMBRE
                              TextFormField(
                                initialValue:
                                    _datosAlimentoEdicion['alimItem_nombre'],
                                decoration: const InputDecoration(
                                    labelText: 'Nombre',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textInputAction: TextInputAction.next,
                                //keyboardType: TextInputType.number,
                                focusNode: _nombreAlimentoNode,
                                onFieldSubmitted: ((value) {
                                  FocusScope.of(context)
                                      .requestFocus(_porcionAlimentoNode);
                                }),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor introduzca un valor';
                                  }
                                  if (value.length <= 2) {
                                    return 'Por favor ingrese un nombre mayor a 2 letras';
                                  }
                                  if (value.length > 50) {
                                    return 'Por favor ingrese un nombre menor a 50 letras';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _datosAlimento = AlimentoItem(
                                    id: _datosAlimento.id,
                                    nombre: value,
                                    esFavorito: _datosAlimento.esFavorito,
                                    clasificacion: _datosAlimento.clasificacion,
                                    porcion: _datosAlimento.porcion,
                                    categoria: _datosAlimento.categoria,
                                    resumen: Resumen(
                                      id: _datosAlimento.resumen.id,
                                      cant_suge:
                                          _datosAlimento.resumen.cant_suge,
                                      unidad: _datosAlimento.resumen.unidad,
                                      peso_bruto_g:
                                          _datosAlimento.resumen.peso_bruto_g,
                                      peso_neto_g:
                                          _datosAlimento.resumen.peso_neto_g,
                                      energia_kcal:
                                          _datosAlimento.resumen.energia_kcal,
                                      proteina_g:
                                          _datosAlimento.resumen.proteina_g,
                                      lipidos_g:
                                          _datosAlimento.resumen.lipidos_g,
                                      hidra_carbo_g:
                                          _datosAlimento.resumen.hidra_carbo_g,
                                      fibra_g: _datosAlimento.resumen.fibra_g,
                                      sodio_mg: _datosAlimento.resumen.sodio_mg,
                                      colesterol_mg:
                                          _datosAlimento.resumen.colesterol_mg,
                                    ),
                                  );
                                },
                              ),
                              //DropdownButtonFormField - CATEGORIA
                              //Se usa un if para determinar si categoria esta vacia o si tie
                              //ene algun valor, dependiendo, se muestra uno u otro DropdownB
                              //uttonFormField con valor inicial o sin valor inicial.
                              if (_datosAlimentoEdicion['alimItem_categoria'] ==
                                  '') ...[
                                DropdownButtonFormField(
                                  dropdownColor:
                                      const Color.fromARGB(255, 15, 167, 152),
                                  focusNode: _categoriaAlimentoNode,
                                  decoration: const InputDecoration(
                                      labelText: 'Categoría',
                                      labelStyle: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Selecciona una categoría';
                                    }
                                    return null;
                                  },
                                  items: listaCategorias.map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList(),
                                  onSaved: (value) {
                                    _datosAlimento = AlimentoItem(
                                      id: _datosAlimento.id,
                                      nombre: _datosAlimento.nombre,
                                      esFavorito: _datosAlimento.esFavorito,
                                      clasificacion:
                                          _datosAlimento.clasificacion,
                                      porcion: _datosAlimento.porcion,
                                      categoria: value,
                                      resumen: Resumen(
                                        id: _datosAlimento.resumen.id,
                                        cant_suge:
                                            _datosAlimento.resumen.cant_suge,
                                        unidad: _datosAlimento.resumen.unidad,
                                        peso_bruto_g:
                                            _datosAlimento.resumen.peso_bruto_g,
                                        peso_neto_g:
                                            _datosAlimento.resumen.peso_neto_g,
                                        energia_kcal:
                                            _datosAlimento.resumen.energia_kcal,
                                        proteina_g:
                                            _datosAlimento.resumen.proteina_g,
                                        lipidos_g:
                                            _datosAlimento.resumen.lipidos_g,
                                        hidra_carbo_g: _datosAlimento
                                            .resumen.hidra_carbo_g,
                                        fibra_g: _datosAlimento.resumen.fibra_g,
                                        sodio_mg:
                                            _datosAlimento.resumen.sodio_mg,
                                        colesterol_mg: _datosAlimento
                                            .resumen.colesterol_mg,
                                      ),
                                    );
                                  },
                                  onChanged: ((value) {}),
                                  isExpanded: true,
                                ),
                              ],
                              if (_datosAlimentoEdicion['alimItem_categoria'] !=
                                  '') ...[
                                DropdownButtonFormField(
                                  dropdownColor:
                                      const Color.fromARGB(255, 15, 167, 152),
                                  focusNode: _categoriaAlimentoNode,
                                  decoration: const InputDecoration(
                                      labelText: 'Categoría',
                                      labelStyle: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                  value: _datosAlimentoEdicion[
                                      'alimItem_categoria'],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Selecciona una categoría';
                                    }
                                    return null;
                                  },
                                  items: listaCategorias.map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList(),
                                  onSaved: (value) {
                                    _datosAlimento = AlimentoItem(
                                      id: _datosAlimento.id,
                                      nombre: _datosAlimento.nombre,
                                      esFavorito: _datosAlimento.esFavorito,
                                      clasificacion:
                                          _datosAlimento.clasificacion,
                                      porcion: _datosAlimento.porcion,
                                      categoria: value,
                                      resumen: Resumen(
                                        id: _datosAlimento.resumen.id,
                                        cant_suge:
                                            _datosAlimento.resumen.cant_suge,
                                        unidad: _datosAlimento.resumen.unidad,
                                        peso_bruto_g:
                                            _datosAlimento.resumen.peso_bruto_g,
                                        peso_neto_g:
                                            _datosAlimento.resumen.peso_neto_g,
                                        energia_kcal:
                                            _datosAlimento.resumen.energia_kcal,
                                        proteina_g:
                                            _datosAlimento.resumen.proteina_g,
                                        lipidos_g:
                                            _datosAlimento.resumen.lipidos_g,
                                        hidra_carbo_g: _datosAlimento
                                            .resumen.hidra_carbo_g,
                                        fibra_g: _datosAlimento.resumen.fibra_g,
                                        sodio_mg:
                                            _datosAlimento.resumen.sodio_mg,
                                        colesterol_mg: _datosAlimento
                                            .resumen.colesterol_mg,
                                      ),
                                    );
                                  },
                                  onChanged: ((value) {}),
                                  isExpanded: true,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Colors.white24,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              const Text(
                                'Porciones',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                              //TextForm CANTIDAD SUGERIA
                              TextFormField(
                                initialValue:
                                    _datosAlimentoEdicion['resumen_cant_suge'],
                                decoration: const InputDecoration(
                                    labelText: 'Cantidad sugerida',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _cantSugeResumenNode,
                                onFieldSubmitted: ((value) {
                                  FocusScope.of(context)
                                      .requestFocus(_unidadResumenNode);
                                }),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor introduzca un valor';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Por favor introduzca un número válido.';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Por favor intrudzca un valor mayor a cero.';
                                  }
                                  if (value.length > 9) {
                                    return 'El valor es demasiado grande';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _datosAlimento = AlimentoItem(
                                    id: _datosAlimento.id,
                                    nombre: _datosAlimento.nombre,
                                    esFavorito: _datosAlimento.esFavorito,
                                    clasificacion: _datosAlimento.clasificacion,
                                    porcion: _datosAlimento.porcion,
                                    categoria: _datosAlimento.categoria,
                                    resumen: Resumen(
                                      id: _datosAlimento.resumen.id,
                                      cant_suge: double.parse(value),
                                      unidad: _datosAlimento.resumen.unidad,
                                      peso_bruto_g:
                                          _datosAlimento.resumen.peso_bruto_g,
                                      peso_neto_g:
                                          _datosAlimento.resumen.peso_neto_g,
                                      energia_kcal:
                                          _datosAlimento.resumen.energia_kcal,
                                      proteina_g:
                                          _datosAlimento.resumen.proteina_g,
                                      lipidos_g:
                                          _datosAlimento.resumen.lipidos_g,
                                      hidra_carbo_g:
                                          _datosAlimento.resumen.hidra_carbo_g,
                                      fibra_g: _datosAlimento.resumen.fibra_g,
                                      sodio_mg: _datosAlimento.resumen.sodio_mg,
                                      colesterol_mg:
                                          _datosAlimento.resumen.colesterol_mg,
                                    ),
                                  );
                                },
                              ),
                              //TextForm UNIDAD
                              TextFormField(
                                initialValue:
                                    _datosAlimentoEdicion['resumen_unidad'],
                                decoration: const InputDecoration(
                                    labelText: 'Unidad',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textInputAction: TextInputAction.next,
                                //keyboardType: TextInputType.number,
                                focusNode: _unidadResumenNode,
                                onFieldSubmitted: ((value) {
                                  FocusScope.of(context)
                                      .requestFocus(_pesoBrutoResumenNode);
                                }),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor introduzca un valor';
                                  }
                                  if (value.length <= 2) {
                                    return 'Por favor ingrese un nombre mayor a 2 letras';
                                  }
                                  if (value.length > 20) {
                                    return 'Por favor ingrese un nombre menor a 20 letras';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _datosAlimento = AlimentoItem(
                                    id: _datosAlimento.id,
                                    nombre: _datosAlimento.nombre,
                                    esFavorito: _datosAlimento.esFavorito,
                                    clasificacion: _datosAlimento.clasificacion,
                                    porcion: _datosAlimento.porcion,
                                    categoria: _datosAlimento.categoria,
                                    resumen: Resumen(
                                      id: _datosAlimento.resumen.id,
                                      cant_suge:
                                          _datosAlimento.resumen.cant_suge,
                                      unidad: value,
                                      peso_bruto_g:
                                          _datosAlimento.resumen.peso_bruto_g,
                                      peso_neto_g:
                                          _datosAlimento.resumen.peso_neto_g,
                                      energia_kcal:
                                          _datosAlimento.resumen.energia_kcal,
                                      proteina_g:
                                          _datosAlimento.resumen.proteina_g,
                                      lipidos_g:
                                          _datosAlimento.resumen.lipidos_g,
                                      hidra_carbo_g:
                                          _datosAlimento.resumen.hidra_carbo_g,
                                      fibra_g: _datosAlimento.resumen.fibra_g,
                                      sodio_mg: _datosAlimento.resumen.sodio_mg,
                                      colesterol_mg:
                                          _datosAlimento.resumen.colesterol_mg,
                                    ),
                                  );
                                },
                              ),
                              //TextForm PESO BRUTO
                              TextFormField(
                                initialValue: _datosAlimentoEdicion[
                                    'resumen_peso_bruto_g'],
                                decoration: const InputDecoration(
                                    labelText: 'Peso bruto (g)',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _pesoBrutoResumenNode,
                                onFieldSubmitted: ((value) {
                                  FocusScope.of(context)
                                      .requestFocus(_pesoNetoResumenNode);
                                }),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor introduzca un valor';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Por favor introduzca un número válido.';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Por favor intrudzca un valor mayor a cero.';
                                  }
                                  if (value.length > 9) {
                                    return 'El valor es demasiado grande';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _datosAlimento = AlimentoItem(
                                    id: _datosAlimento.id,
                                    nombre: _datosAlimento.nombre,
                                    esFavorito: _datosAlimento.esFavorito,
                                    clasificacion: _datosAlimento.clasificacion,
                                    porcion: _datosAlimento.porcion,
                                    categoria: _datosAlimento.categoria,
                                    resumen: Resumen(
                                      id: _datosAlimento.resumen.id,
                                      cant_suge:
                                          _datosAlimento.resumen.cant_suge,
                                      unidad: _datosAlimento.resumen.unidad,
                                      peso_bruto_g: double.parse(value),
                                      peso_neto_g:
                                          _datosAlimento.resumen.peso_neto_g,
                                      energia_kcal:
                                          _datosAlimento.resumen.energia_kcal,
                                      proteina_g:
                                          _datosAlimento.resumen.proteina_g,
                                      lipidos_g:
                                          _datosAlimento.resumen.lipidos_g,
                                      hidra_carbo_g:
                                          _datosAlimento.resumen.hidra_carbo_g,
                                      fibra_g: _datosAlimento.resumen.fibra_g,
                                      sodio_mg: _datosAlimento.resumen.sodio_mg,
                                      colesterol_mg:
                                          _datosAlimento.resumen.colesterol_mg,
                                    ),
                                  );
                                },
                              ),
                              //TextForm PESO NETO
                              TextFormField(
                                initialValue: _datosAlimentoEdicion[
                                    'resumen_peso_neto_g'],
                                decoration: const InputDecoration(
                                    labelText: 'Peso neto (g)',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _pesoNetoResumenNode,
                                onFieldSubmitted: ((value) {
                                  FocusScope.of(context)
                                      .requestFocus(_energiaResumenNode);
                                }),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor introduzca un valor';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Por favor introduzca un número válido.';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Por favor intrudzca un valor mayor a cero.';
                                  }
                                  if (value.length > 9) {
                                    return 'El valor es demasiado grande';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _datosAlimento = AlimentoItem(
                                    id: _datosAlimento.id,
                                    nombre: _datosAlimento.nombre,
                                    esFavorito: _datosAlimento.esFavorito,
                                    clasificacion: _datosAlimento.clasificacion,
                                    porcion: _datosAlimento.porcion,
                                    categoria: _datosAlimento.categoria,
                                    resumen: Resumen(
                                      id: _datosAlimento.resumen.id,
                                      cant_suge:
                                          _datosAlimento.resumen.cant_suge,
                                      unidad: _datosAlimento.resumen.unidad,
                                      peso_bruto_g:
                                          _datosAlimento.resumen.peso_bruto_g,
                                      peso_neto_g: double.parse(value),
                                      energia_kcal:
                                          _datosAlimento.resumen.energia_kcal,
                                      proteina_g:
                                          _datosAlimento.resumen.proteina_g,
                                      lipidos_g:
                                          _datosAlimento.resumen.lipidos_g,
                                      hidra_carbo_g:
                                          _datosAlimento.resumen.hidra_carbo_g,
                                      fibra_g: _datosAlimento.resumen.fibra_g,
                                      sodio_mg: _datosAlimento.resumen.sodio_mg,
                                      colesterol_mg:
                                          _datosAlimento.resumen.colesterol_mg,
                                    ),
                                  );
                                },
                              ),
                              //TextForm ENERGIA
                              TextFormField(
                                initialValue: _datosAlimentoEdicion[
                                    'resumen_energia_kcal'],
                                decoration: const InputDecoration(
                                    labelText: 'Energía (kcal)',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _energiaResumenNode,
                                onFieldSubmitted: ((value) {
                                  FocusScope.of(context)
                                      .requestFocus(_proteinaResumenNode);
                                }),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor introduzca un valor';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Por favor introduzca un número válido.';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Por favor intrudzca un valor mayor a cero.';
                                  }
                                  if (value.length > 9) {
                                    return 'El valor es demasiado grande';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _datosAlimento = AlimentoItem(
                                    id: _datosAlimento.id,
                                    nombre: _datosAlimento.nombre,
                                    esFavorito: _datosAlimento.esFavorito,
                                    clasificacion: _datosAlimento.clasificacion,
                                    porcion: _datosAlimento.porcion,
                                    categoria: _datosAlimento.categoria,
                                    resumen: Resumen(
                                      id: _datosAlimento.resumen.id,
                                      cant_suge:
                                          _datosAlimento.resumen.cant_suge,
                                      unidad: _datosAlimento.resumen.unidad,
                                      peso_bruto_g:
                                          _datosAlimento.resumen.peso_bruto_g,
                                      peso_neto_g:
                                          _datosAlimento.resumen.peso_neto_g,
                                      energia_kcal: double.parse(value),
                                      proteina_g:
                                          _datosAlimento.resumen.proteina_g,
                                      lipidos_g:
                                          _datosAlimento.resumen.lipidos_g,
                                      hidra_carbo_g:
                                          _datosAlimento.resumen.hidra_carbo_g,
                                      fibra_g: _datosAlimento.resumen.fibra_g,
                                      sodio_mg: _datosAlimento.resumen.sodio_mg,
                                      colesterol_mg:
                                          _datosAlimento.resumen.colesterol_mg,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Colors.white24,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              const Text(
                                'Macronutrientes',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                              //TextForm PROTEINA
                              TextFormField(
                                initialValue:
                                    _datosAlimentoEdicion['resumen_proteina_g'],
                                decoration: const InputDecoration(
                                    labelText: 'Proteinas (g)',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _proteinaResumenNode,
                                onFieldSubmitted: ((value) {
                                  FocusScope.of(context)
                                      .requestFocus(_lipidosResumenNode);
                                }),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor introduzca un valor';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Por favor introduzca un número válido.';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Por favor intrudzca un valor mayor a cero.';
                                  }
                                  if (value.length > 9) {
                                    return 'El valor es demasiado grande';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _datosAlimento = AlimentoItem(
                                    id: _datosAlimento.id,
                                    nombre: _datosAlimento.nombre,
                                    esFavorito: _datosAlimento.esFavorito,
                                    clasificacion: _datosAlimento.clasificacion,
                                    porcion: _datosAlimento.porcion,
                                    categoria: _datosAlimento.categoria,
                                    resumen: Resumen(
                                      id: _datosAlimento.resumen.id,
                                      cant_suge:
                                          _datosAlimento.resumen.cant_suge,
                                      unidad: _datosAlimento.resumen.unidad,
                                      peso_bruto_g:
                                          _datosAlimento.resumen.peso_bruto_g,
                                      peso_neto_g:
                                          _datosAlimento.resumen.peso_neto_g,
                                      energia_kcal:
                                          _datosAlimento.resumen.energia_kcal,
                                      proteina_g: double.parse(value),
                                      lipidos_g:
                                          _datosAlimento.resumen.lipidos_g,
                                      hidra_carbo_g:
                                          _datosAlimento.resumen.hidra_carbo_g,
                                      fibra_g: _datosAlimento.resumen.fibra_g,
                                      sodio_mg: _datosAlimento.resumen.sodio_mg,
                                      colesterol_mg:
                                          _datosAlimento.resumen.colesterol_mg,
                                    ),
                                  );
                                },
                              ),
                              //TextForm LIPIDOS
                              TextFormField(
                                initialValue:
                                    _datosAlimentoEdicion['resumen_lipidos_g'],
                                decoration: const InputDecoration(
                                    labelText: 'Lípidos (g)',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _lipidosResumenNode,
                                onFieldSubmitted: ((value) {
                                  FocusScope.of(context)
                                      .requestFocus(_hidraCarboResumenNode);
                                }),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor introduzca un valor';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Por favor introduzca un número válido.';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Por favor intrudzca un valor mayor a cero.';
                                  }
                                  if (value.length > 9) {
                                    return 'El valor es demasiado grande';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _datosAlimento = AlimentoItem(
                                    id: _datosAlimento.id,
                                    nombre: _datosAlimento.nombre,
                                    esFavorito: _datosAlimento.esFavorito,
                                    clasificacion: _datosAlimento.clasificacion,
                                    porcion: _datosAlimento.porcion,
                                    categoria: _datosAlimento.categoria,
                                    resumen: Resumen(
                                      id: _datosAlimento.resumen.id,
                                      cant_suge:
                                          _datosAlimento.resumen.cant_suge,
                                      unidad: _datosAlimento.resumen.unidad,
                                      peso_bruto_g:
                                          _datosAlimento.resumen.peso_bruto_g,
                                      peso_neto_g:
                                          _datosAlimento.resumen.peso_neto_g,
                                      energia_kcal:
                                          _datosAlimento.resumen.energia_kcal,
                                      proteina_g:
                                          _datosAlimento.resumen.proteina_g,
                                      lipidos_g: double.parse(value),
                                      hidra_carbo_g:
                                          _datosAlimento.resumen.hidra_carbo_g,
                                      fibra_g: _datosAlimento.resumen.fibra_g,
                                      sodio_mg: _datosAlimento.resumen.sodio_mg,
                                      colesterol_mg:
                                          _datosAlimento.resumen.colesterol_mg,
                                    ),
                                  );
                                },
                              ),
                              //TextForm HIDRATOS DE CARBONO
                              TextFormField(
                                initialValue: _datosAlimentoEdicion[
                                    'resumen_hidra_carbo_g'],
                                decoration: const InputDecoration(
                                    labelText: 'Hidratos de carbono (g)',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _hidraCarboResumenNode,
                                onFieldSubmitted: ((value) {
                                  FocusScope.of(context)
                                      .requestFocus(_fibraResumenNode);
                                }),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor introduzca un valor';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Por favor introduzca un número válido.';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Por favor intrudzca un valor mayor a cero.';
                                  }
                                  if (value.length > 9) {
                                    return 'El valor es demasiado grande';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _datosAlimento = AlimentoItem(
                                    id: _datosAlimento.id,
                                    nombre: _datosAlimento.nombre,
                                    esFavorito: _datosAlimento.esFavorito,
                                    clasificacion: _datosAlimento.clasificacion,
                                    porcion: _datosAlimento.porcion,
                                    categoria: _datosAlimento.categoria,
                                    resumen: Resumen(
                                      id: _datosAlimento.resumen.id,
                                      cant_suge:
                                          _datosAlimento.resumen.cant_suge,
                                      unidad: _datosAlimento.resumen.unidad,
                                      peso_bruto_g:
                                          _datosAlimento.resumen.peso_bruto_g,
                                      peso_neto_g:
                                          _datosAlimento.resumen.peso_neto_g,
                                      energia_kcal:
                                          _datosAlimento.resumen.energia_kcal,
                                      proteina_g:
                                          _datosAlimento.resumen.proteina_g,
                                      lipidos_g:
                                          _datosAlimento.resumen.lipidos_g,
                                      hidra_carbo_g: double.parse(value),
                                      fibra_g: _datosAlimento.resumen.fibra_g,
                                      sodio_mg: _datosAlimento.resumen.sodio_mg,
                                      colesterol_mg:
                                          _datosAlimento.resumen.colesterol_mg,
                                    ),
                                  );
                                },
                              ),
                              //TextForm FIBRA
                              TextFormField(
                                initialValue:
                                    _datosAlimentoEdicion['resumen_fibra_g'],
                                decoration: const InputDecoration(
                                    labelText: 'Fibra (g)',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _fibraResumenNode,
                                onFieldSubmitted: ((value) {
                                  FocusScope.of(context)
                                      .requestFocus(_sodioResumenNode);
                                }),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor introduzca un valor';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Por favor introduzca un número válido.';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Por favor intrudzca un valor mayor a cero.';
                                  }
                                  if (value.length > 9) {
                                    return 'El valor es demasiado grande';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _datosAlimento = AlimentoItem(
                                    id: _datosAlimento.id,
                                    nombre: _datosAlimento.nombre,
                                    esFavorito: _datosAlimento.esFavorito,
                                    clasificacion: _datosAlimento.clasificacion,
                                    porcion: _datosAlimento.porcion,
                                    categoria: _datosAlimento.categoria,
                                    resumen: Resumen(
                                      id: _datosAlimento.resumen.id,
                                      cant_suge:
                                          _datosAlimento.resumen.cant_suge,
                                      unidad: _datosAlimento.resumen.unidad,
                                      peso_bruto_g:
                                          _datosAlimento.resumen.peso_bruto_g,
                                      peso_neto_g:
                                          _datosAlimento.resumen.peso_neto_g,
                                      energia_kcal:
                                          _datosAlimento.resumen.energia_kcal,
                                      proteina_g:
                                          _datosAlimento.resumen.proteina_g,
                                      lipidos_g:
                                          _datosAlimento.resumen.lipidos_g,
                                      hidra_carbo_g:
                                          _datosAlimento.resumen.hidra_carbo_g,
                                      fibra_g: double.parse(value),
                                      sodio_mg: _datosAlimento.resumen.sodio_mg,
                                      colesterol_mg:
                                          _datosAlimento.resumen.colesterol_mg,
                                    ),
                                  );
                                },
                              ),
                              //TextForm SODIO
                              TextFormField(
                                initialValue:
                                    _datosAlimentoEdicion['resumen_sodio_mg'],
                                decoration: const InputDecoration(
                                    labelText: 'Sodio (mg)',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _sodioResumenNode,
                                onFieldSubmitted: ((value) {
                                  FocusScope.of(context)
                                      .requestFocus(_colestResumenNode);
                                }),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor introduzca un valor';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Por favor introduzca un número válido.';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Por favor intrudzca un valor mayor a cero.';
                                  }
                                  if (value.length > 9) {
                                    return 'El valor es demasiado grande';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _datosAlimento = AlimentoItem(
                                    id: _datosAlimento.id,
                                    nombre: _datosAlimento.nombre,
                                    esFavorito: _datosAlimento.esFavorito,
                                    clasificacion: _datosAlimento.clasificacion,
                                    porcion: _datosAlimento.porcion,
                                    categoria: _datosAlimento.categoria,
                                    resumen: Resumen(
                                      id: _datosAlimento.resumen.id,
                                      cant_suge:
                                          _datosAlimento.resumen.cant_suge,
                                      unidad: _datosAlimento.resumen.unidad,
                                      peso_bruto_g:
                                          _datosAlimento.resumen.peso_bruto_g,
                                      peso_neto_g:
                                          _datosAlimento.resumen.peso_neto_g,
                                      energia_kcal:
                                          _datosAlimento.resumen.energia_kcal,
                                      proteina_g:
                                          _datosAlimento.resumen.proteina_g,
                                      lipidos_g:
                                          _datosAlimento.resumen.lipidos_g,
                                      hidra_carbo_g:
                                          _datosAlimento.resumen.hidra_carbo_g,
                                      fibra_g: _datosAlimento.resumen.fibra_g,
                                      sodio_mg: double.parse(value),
                                      colesterol_mg:
                                          _datosAlimento.resumen.colesterol_mg,
                                    ),
                                  );
                                },
                              ),
                              //TextForm COLESTEROL
                              TextFormField(
                                initialValue: _datosAlimentoEdicion[
                                    'resumen_colesterol_mg'],
                                decoration: const InputDecoration(
                                    labelText: 'Colesterol (mg)',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _colestResumenNode,
                                onFieldSubmitted: ((value) {
                                  FocusScope.of(context)
                                      .requestFocus(_botonAgregar);
                                }),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor introduzca un valor';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Por favor introduzca un número válido.';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Por favor intrudzca un valor mayor a cero.';
                                  }
                                  if (value.length > 9) {
                                    return 'El valor es demasiado grande';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _datosAlimento = AlimentoItem(
                                    id: _datosAlimento.id,
                                    nombre: _datosAlimento.nombre,
                                    esFavorito: _datosAlimento.esFavorito,
                                    clasificacion: _datosAlimento.clasificacion,
                                    porcion: _datosAlimento.porcion,
                                    categoria: _datosAlimento.categoria,
                                    resumen: Resumen(
                                      id: _datosAlimento.resumen.id,
                                      cant_suge:
                                          _datosAlimento.resumen.cant_suge,
                                      unidad: _datosAlimento.resumen.unidad,
                                      peso_bruto_g:
                                          _datosAlimento.resumen.peso_bruto_g,
                                      peso_neto_g:
                                          _datosAlimento.resumen.peso_neto_g,
                                      energia_kcal:
                                          _datosAlimento.resumen.energia_kcal,
                                      proteina_g:
                                          _datosAlimento.resumen.proteina_g,
                                      lipidos_g:
                                          _datosAlimento.resumen.lipidos_g,
                                      hidra_carbo_g:
                                          _datosAlimento.resumen.hidra_carbo_g,
                                      fibra_g: _datosAlimento.resumen.fibra_g,
                                      sodio_mg: _datosAlimento.resumen.sodio_mg,
                                      colesterol_mg: double.parse(value),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
