import 'package:flutter/material.dart';
import '../../../providers/recetas_provider.dart';
import 'package:provider/provider.dart';

class EditaRecetaScreen extends StatefulWidget {
  const EditaRecetaScreen({Key key}) : super(key: key);
  static const routeName = './edita_informacion_receta_screen';

  @override
  State<EditaRecetaScreen> createState() => _EditaRecetaScreenState();
}

class _EditaRecetaScreenState extends State<EditaRecetaScreen> {
//Nodos para acceso en campos
  final _nombreRecetaNode = FocusNode();
  final _resumenRecetaNode = FocusNode();
  final _porcionesRecetaNode = FocusNode();
  final _botonAgregarRecedaNode = FocusNode();

//Llave global del formulario
  final _formKey = GlobalKey<FormState>();

  //Variables de inicio
  var _disparo_001 = true;
  String nombreTitulo = '';
  String idReceta;

//Inicializa valores
  var _datosReceta = RecetaItem(
    id: '',
    nombre: '',
    resumen: '',
    porciones: 0,
    alimentos: {},
  );

//Inicializa valor del Map<String, double> temporal
  Map<String, double> temp;

//Inicializa valores de edición para formulario
  var _datosRecetaEdicion = {
    'nombre': '',
    'resumen': '',
    'porciones': '',
  };
  void _actualizaReceta() {
    final validacion = _formKey.currentState.validate();
    if (!validacion) {
      return;
    }
    _formKey.currentState.save();
    Provider.of<Receta>(context, listen: false)
        .actualizaReceta(idReceta, _datosReceta);
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (_disparo_001) {
      idReceta = ModalRoute.of(context).settings.arguments as String;
      nombreTitulo = Provider.of<Receta>(context).nombreRecetaPorId(idReceta);
      _datosReceta = Provider.of<Receta>(context).recetaPorId(idReceta);
      _datosRecetaEdicion = {
        'nombre': _datosReceta.nombre,
        'resumen': _datosReceta.resumen,
        'porciones': _datosReceta.porciones.toString(),
      };
    }
    _disparo_001 = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            nombreTitulo,
            style: const TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.change_circle),
              onPressed: () {
                _actualizaReceta();
              },
            ),
          ],
        ),
        body: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Colors.white24,
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
                                  TextFormField(
                                    initialValue: _datosRecetaEdicion['nombre'],
                                    decoration: const InputDecoration(
                                        labelText: 'Nombre',
                                        labelStyle: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    textInputAction: TextInputAction.next,
                                    focusNode: _nombreRecetaNode,
                                    onFieldSubmitted: (value) => {
                                      FocusScope.of(context)
                                          .requestFocus(_resumenRecetaNode)
                                    },
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
                                      _datosReceta = RecetaItem(
                                        id: _datosReceta.id,
                                        nombre: value,
                                        resumen: _datosReceta.resumen,
                                        porciones: _datosReceta.porciones,
                                        alimentos: _datosReceta.alimentos,
                                      );
                                    },
                                  ),
                                  //TextForm RESUMEN
                                  TextFormField(
                                    initialValue:
                                        _datosRecetaEdicion['resumen'],
                                    decoration: const InputDecoration(
                                        labelText: 'Resumen',
                                        labelStyle: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    textInputAction: TextInputAction.next,
                                    focusNode: _resumenRecetaNode,
                                    onFieldSubmitted: (value) => {
                                      FocusScope.of(context)
                                          .requestFocus(_porcionesRecetaNode)
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Por favor introduzca un valor';
                                      }
                                      if (value.length <= 2) {
                                        return 'Por favor ingrese un nombre mayor a 2 letras';
                                      }
                                      if (value.length > 150) {
                                        return 'Por favor ingrese un nombre menor a 150 letras';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _datosReceta = RecetaItem(
                                        id: _datosReceta.id,
                                        nombre: _datosReceta.nombre,
                                        resumen: value,
                                        porciones: _datosReceta.porciones,
                                        alimentos: _datosReceta.alimentos,
                                      );
                                    },
                                  ),
                                  //TextForm PORCION
                                  TextFormField(
                                    initialValue:
                                        _datosRecetaEdicion['porciones'],
                                    decoration: const InputDecoration(
                                        labelText: 'Porcion',
                                        labelStyle: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    focusNode: _porcionesRecetaNode,
                                    onFieldSubmitted: (value) => {
                                      FocusScope.of(context)
                                          .requestFocus(_botonAgregarRecedaNode)
                                    },
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
                                      _datosReceta = RecetaItem(
                                        id: _datosReceta.id,
                                        nombre: _datosReceta.nombre,
                                        resumen: _datosReceta.resumen,
                                        porciones: int.parse(value),
                                        alimentos: _datosReceta.alimentos,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add_to_photos_outlined,
                                size: 48,
                                color: Colors.white,
                              ),
                              Text(
                                'Para editar los alimentos, haga clic en este icono en la pantalla anterior.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
