import 'package:fixa_app/providers/recetas_provider.dart';
import 'package:fixa_app/providers/temporales.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/alimentos_provider.dart';
import '../../../providers/navegador_helper.dart';

class AlimentosItemDetallePopup002 extends StatefulWidget {
  const AlimentosItemDetallePopup002({
    Key key,
    this.idAlimento,
    this.idReceta,
    this.idCanasta,
    this.color,
  }) : super(key: key);

  final String idAlimento;
  final String idReceta;
  final String idCanasta;
  final Color color;

  @override
  State<AlimentosItemDetallePopup002> createState() =>
      _AlimentosItemDetallePopup002State();
}

NavegadorDetalleAlimento navegador;
bool agregarCanasta = true;
double agregarCanastaVal = 1.0;
var valActual = 1.0;
Map<String, double> alimentosRecetaElimina;

// ignore: camel_case_types
enum eliminaSiNo { si, no }

class _AlimentosItemDetallePopup002State
    extends State<AlimentosItemDetallePopup002> {
  @override
  void didChangeDependencies() {
    navegador = Provider.of<NavegadorHelper>(context, listen: false)
        .getNavegadorDetalleAlimento;
    if (navegador.idReceta == '') {
      valActual = Provider.of<Temporales>(context, listen: false)
          .getCantidadAlimentosTempReceta(widget.idAlimento);
      valActual == null
          ? agregarCanastaVal = 1.0
          : agregarCanastaVal = valActual;
    } else {
      agregarCanastaVal = Provider.of<Receta>(context, listen: false)
              .porcionesAlimentosPorRecetaId(
                  idAlimento: widget.idAlimento,
                  idReceta: navegador.idReceta) ??
          1.0;
    }
    super.didChangeDependencies();
  }

  //FUTUROS POPUP COMPROBACIÓN ELIMINACIÓN
  /*static Future<eliminaSiNo> _popupSinAlimentosEnReceta(
      BuildContext context) async {
    final shoDia = await showDialog(
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
              Navigator.of(context).pop(eliminaSiNo.si);
            }),
            child: const Text('Aceptar'),
          ),
          TextButton(
            onPressed: (() {
              Navigator.of(context).pop(eliminaSiNo.no);
            }),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
    return (shoDia != null) ? shoDia : eliminaSiNo.no;
  }*/

  //FUTUROS POPUP COMPROBACIÓN ELIMINACIÓN
  /*void _popupRecetaSinAlimentos(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          '¡Último alimento!',
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'No se puede dejar una receta sin alimentos, si deseas eliminar la receta, eliminala directamente desde arriba de su información.',
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
  }*/

  @override
  Widget build(BuildContext context) {
    final alimentoInformacion =
        Provider.of<Alimentos>(context).alimentoPorId(widget.idAlimento);
    final recetaInformacion = Provider.of<Receta>(context, listen: false)
        .recetaPorId(navegador.idReceta);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: widget.color,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
                Text(alimentoInformacion.nombre,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    )),
                const Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                Text(
                  alimentoInformacion.categoria,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                /*Text(
                  'ID Receta: ${navegador.idReceta}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),*/
                const Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                navegador.idReceta != ''
                    ? Text('Receta: ${recetaInformacion.nombre}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ))
                    : const Text(
                        'Agregar a nueva receta:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 242, 192, 43),
                      elevation: 0,
                    ),
                    child: valActual == null
                        ? const Text('Agregar a la receta',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400))
                        : const Text('Actualizar la receta',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                    onPressed: () {
                      navegador.idReceta == ''
                          ? Provider.of<Temporales>(context, listen: false)
                              .agregaTempReceta(
                              widget.idAlimento,
                              agregarCanastaVal,
                            )
                          : Provider.of<Receta>(context, listen: false)
                              .agregarAlimentosReceta(
                              navegador.idReceta,
                              widget.idAlimento,
                              agregarCanastaVal,
                            );
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                  Row(
                    children: [
                      alimentoInformacion.esFavorito
                          ? IconButton(
                              icon: const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 32,
                              ),
                              onPressed: () {
                                Provider.of<Alimentos>(context, listen: false)
                                    .cambiaEstadoFavorito(widget.idAlimento);
                                setState(() {});
                              })
                          : IconButton(
                              icon: const Icon(
                                Icons.star_border,
                                color: Colors.white,
                                size: 32,
                              ),
                              onPressed: () {
                                Provider.of<Alimentos>(context, listen: false)
                                    .cambiaEstadoFavorito(widget.idAlimento);
                                setState(() {});
                              },
                            ),
                    ],
                  )
                ],
              ),
            ],
          ),
          agregarCanasta
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: () {
                            if (agregarCanastaVal > 1) {
                              agregarCanastaVal = agregarCanastaVal - 1;
                            }
                            setState(() {});
                          },
                        ),
                        Text(
                          agregarCanastaVal.toStringAsFixed(0),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle_outline_sharp,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: () {
                            if (agregarCanastaVal < 999) {
                              agregarCanastaVal = agregarCanastaVal + 1;
                            }
                            setState(() {});
                          },
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.receipt_long_rounded),
                          color: Colors.white,
                          iconSize: 32,
                          onPressed: () {},
                        ),
                        navegador.idReceta == ''
                            ? Text(
                                (Provider.of<Temporales>(context, listen: false)
                                            .getCantidadAlimentosTempReceta(
                                                widget.idAlimento)) ==
                                        null
                                    ? '0'
                                    : Provider.of<Temporales>(context,
                                            listen: false)
                                        .getCantidadAlimentosTempReceta(
                                            widget.idAlimento)
                                        .toStringAsFixed(0),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 24),
                              )
                            : Text(
                                (Provider.of<Receta>(context)
                                            .porcionesAlimentosPorRecetaId(
                                                idReceta: navegador.idReceta,
                                                idAlimento:
                                                    widget.idAlimento) ??
                                        0)
                                    .toStringAsFixed(0),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                        IconButton(
                          icon: const Icon(Icons.delete_sweep_outlined),
                          color: Colors.white,
                          iconSize: 32,
                          onPressed: () async {
                            [
                              //Ternaria para ver si es receta nueva o edicion.
                              navegador.idReceta == ''
                                  ? Provider.of<Temporales>(context,
                                          listen: false)
                                      .setEliminaCantidadAlimentosTempReceta(
                                          widget.idAlimento)
                                  : [
                                      Provider.of<Receta>(context,
                                              listen: false)
                                          .eliminaAlimentosReceta(
                                              navegador.idReceta,
                                              widget.idAlimento),
                                      /*alimentosRecetaElimina =
                                          Provider.of<Receta>(context,
                                                  listen: false)
                                              .getAlimentosReceta(
                                                  navegador.idReceta),
                                      //Ternario revisa si solo queda un alimento o varios.
                                      alimentosRecetaElimina.length > 1
                                          ? [
                                              aceptaCancela =
                                                  await _popupSinAlimentosEnReceta(
                                                      context),
                                              if (aceptaCancela ==
                                                  eliminaSiNo.si)
                                                {
                                                  Provider.of<Receta>(context,
                                                          listen: false)
                                                      .eliminaAlimentosReceta(
                                                          navegador.idReceta,
                                                          widget.idAlimento),
                                                  print('Entra al si'),
                                                }
                                              else if (aceptaCancela ==
                                                  eliminaSiNo.no)
                                                {
                                                  print('Entra al no'),
                                                },
                                            ]
                                          : [
                                              //_popupRecetaSinAlimentos(context),
                                            ]*/
                                    ]
                            ];
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                        ),
                      ],
                    )
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 242, 192, 43),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.02),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              'Porcion:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                (alimentoInformacion.resumen.cant_suge *
                                        agregarCanastaVal)
                                    .toStringAsFixed(2),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                            Text(
                              '${alimentoInformacion.resumen.unidad} (s)',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.02),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              'Peso bruto: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                '${(alimentoInformacion.resumen.peso_bruto_g * agregarCanastaVal).toStringAsFixed(1)} g',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                            const Text(
                              'por porcion',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Contenido energético: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        '${(alimentoInformacion.resumen.energia_kcal * agregarCanastaVal).toStringAsFixed(1)} kcal',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                        ),
                      ),
                    ),
                    const Text(
                      'por porcion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            shape: const StadiumBorder(),
            color: Colors.white54,
            elevation: 0,
            child: ListTile(
              title: Text(
                  'Carbohidratos: ${(alimentoInformacion.resumen.hidra_carbo_g * agregarCanastaVal).toStringAsFixed(1)} g',
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
              trailing: const Icon(Icons.fastfood),
            ),
          ),
          Card(
            shape: const StadiumBorder(),
            color: Colors.white54,
            elevation: 0,
            child: ListTile(
              title: Text(
                  'Proteina: ${(alimentoInformacion.resumen.proteina_g * agregarCanastaVal).toStringAsFixed(1)} g',
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
              trailing: const Icon(Icons.fastfood),
            ),
          ),
          Card(
            shape: const StadiumBorder(),
            color: Colors.white54,
            elevation: 0,
            child: ListTile(
              title: Text(
                  'Lípidos: ${(alimentoInformacion.resumen.lipidos_g * agregarCanastaVal).toStringAsFixed(1)} g',
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
              trailing: const Icon(Icons.fastfood),
            ),
          ),
          Card(
            shape: const StadiumBorder(),
            color: Colors.white54,
            elevation: 0,
            child: ListTile(
              title: Text(
                  'Fibra: ${(alimentoInformacion.resumen.fibra_g * agregarCanastaVal).toStringAsFixed(1)} g',
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
              trailing: const Icon(Icons.fastfood),
            ),
          ),
          Card(
            shape: const StadiumBorder(),
            color: Colors.white54,
            elevation: 0,
            child: ListTile(
              title: Text(
                  'Sodio: ${(alimentoInformacion.resumen.sodio_mg * agregarCanastaVal).toStringAsFixed(1)} mg',
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
              trailing: const Icon(Icons.fastfood),
            ),
          ),
          Card(
            shape: const StadiumBorder(),
            color: Colors.white54,
            elevation: 0,
            child: ListTile(
              title: Text(
                  'Colesterol: ${(alimentoInformacion.resumen.colesterol_mg * agregarCanastaVal).toStringAsFixed(1)} mg',
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
              trailing: const Icon(Icons.fastfood),
            ),
          ),
        ],
      ),
    );
  }
}
