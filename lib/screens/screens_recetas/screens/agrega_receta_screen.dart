import 'package:fixa_app/providers/navegador_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/alimentos_provider.dart';
import '../../screens_alimentos/screens/alimentos_categorias_screen.dart';
import '../../../providers/recetas_provider.dart';
import '../widgets/alimentos_item_receta_card.dart';
import '../../../providers/temporales.dart';

class AgregaRecetaScreen extends StatefulWidget {
  const AgregaRecetaScreen({Key key}) : super(key: key);
  static const routeName = './agrega_receta_screen';

  @override
  State<AgregaRecetaScreen> createState() => _AgregaRecetaScreenState();
}

class _AgregaRecetaScreenState extends State<AgregaRecetaScreen> {
  //Nodos para acceso en campos
  final _nombreRecetaNode = FocusNode();
  final _resumenRecetaNode = FocusNode();
  final _porcionesRecetaNode = FocusNode();
  final _botonAgregarRecedaNode = FocusNode();

  //Llave global del formulario
  final _formKey = GlobalKey<FormState>();

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
  final _datosRecetaEdicion = {
    'nombre': '',
    'resumen': '',
    'porciones': '',
  };

  void _guardaRecetaRecetaItems() {
    final validacion = _formKey.currentState.validate();
    if (!validacion) {
      return;
    }
    _formKey.currentState.save();
    _datosReceta.alimentos = temp;
    temp.isNotEmpty
        ? [
            Provider.of<Receta>(context, listen: false)
                .agregarReceta(_datosReceta),
            Provider.of<Alimentos>(context, listen: false)
                .limpiaAlimentosRecetaTemporal(),
            Provider.of<Temporales>(context, listen: false).limpiaTempReceta(),
            Navigator.of(context).pop(),
          ]
        : [
            _popupSinAlimentosEnReceta(context),
          ];
  }

  static _popupSinAlimentosEnReceta(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          'Receta vacía',
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'La receta debe contener al menos un alimento, presione el botón "Agregar alimento" para agregar alimentos a la receta.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //NAVEGADOR
    Provider.of<NavegadorHelper>(context, listen: false)
        .setNavegadorDetalleAlimento(
      agregar_canasta: false,
      agregar_receta: true,
      ver_alimento: false,
      ver_canasta: false,
      ver_receta: false,
      idAlimento: '',
      idCanasta: '',
      idReceta: '',
    );
    temp = Provider.of<Temporales>(context).getTempReceta;
    Provider.of<Alimentos>(context).alimentosReceta(temp);
    final alimentosRecetaTemporal =
        Provider.of<Alimentos>(context).alimentosRecetaTemporal;
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
          title: const Text(
            'Agregar receta',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () {
                _guardaRecetaRecetaItems();
                //Provider.of<Receta>(context, listen: false).guardaRecetasLS();
              },
            ),
            /*IconButton(
              icon: const Icon(
                Icons.add_a_photo_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                //_getDirectory();
                Provider.of<Receta>(context, listen: false).guardaRecetas();
              },
            ),*/
            /*IconButton(
              icon: const Icon(
                Icons.ev_station,
                color: Colors.white,
              ),
              onPressed: () {
                //_getDirectory();
                Provider.of<Receta>(context, listen: false).imprimeArchivo();
              },
            ),*/
            /*IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                //_getDirectory();
                /*Provider.of<Receta>(context, listen: false)
                    .actualizaRecetarioLocal();*/
              },
            ),*/
            /*IconButton(
              icon: const Icon(
                Icons.,
                color: Colors.white,
              ),
              onPressed: () {
                //_getDirectory();
                (Provider.of<Receta>(context, listen: false)
                    .getRecetaItemLocal());
              },
            ),*/
          ],
        ),
        body: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Colors.white24,
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  const Text(
                                    'Datos principales',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  //TextForm NOMBRE
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
                                        _datosRecetaEdicion['porcion'],
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
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white24, elevation: 0),
                child: const Text(
                  'Agregar alimento ',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AlimentosCategoriasScreen.routeName);
                  setState(() {});
                },
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: alimentosRecetaTemporal.length,
                    itemBuilder: (context, index) => AlimentosItemRecetaCard(
                          idAlimento:
                              alimentosRecetaTemporal.values.toList()[index].id,
                          alimentoInformacion:
                              alimentosRecetaTemporal.values.toList()[index],
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
