import 'package:fixa_app/providers/canasta_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/alimentos_provider.dart';
import '../screens/agrega_alimento_screen.dart';

class AlimentosItemDetallePopup001 extends StatefulWidget {
  const AlimentosItemDetallePopup001({
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
  State<AlimentosItemDetallePopup001> createState() =>
      _AlimentosItemDetallePopup001State();
}

bool agregarCanasta = true;
//bool isLoading = false;
double agregarCanastaVal = 1.0;

class _AlimentosItemDetallePopup001State
    extends State<AlimentosItemDetallePopup001> {
  @override
  void didChangeDependencies() {
    agregarCanastaVal = 1.0;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final alimentoInformacion =
        Provider.of<Alimentos>(context).alimentoPorId(widget.idAlimento);
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
                const Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 10,
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
                    child: const Text('Agregar a la canasta',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400)),
                    onPressed: () {
                      Provider.of<Canasta>(context, listen: false)
                          .adicionarCantidadAlimentoCanasta(
                        idAlimento: widget.idAlimento,
                        idCanasta: '0001',
                        cantidad: agregarCanastaVal,
                      );
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            AgregaAlimentoScreen.routeName,
                            arguments: widget.idAlimento,
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: () async {
                          //isLoading = true;
                          Navigator.of(context).pop();
                          Provider.of<Alimentos>(context, listen: false)
                              .alimentosItemElimina(widget.idAlimento);
                          Provider.of<Canasta>(context, listen: false)
                              .eliminaAlimentoCanasta(
                            idAlimento: widget.idAlimento,
                            idCanasta: '0001',
                          );

                          //setState(() {});
                        },
                      ),
                      //alimentoInformacion.esFavorito
                      IconButton(
                          icon: Icon(
                            alimentoInformacion.esFavorito
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: () {
                            Provider.of<Alimentos>(context, listen: false)
                                .cambiaEstadoFavorito(widget.idAlimento);
                            setState(() {});
                          })
                      /*: IconButton(
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
                            ),*/
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
                          icon: const Icon(Icons.shopping_bag_outlined),
                          color: Colors.white,
                          iconSize: 32,
                          onPressed: () {},
                        ),
                        Text(
                          (Provider.of<Canasta>(context)
                                      .alimentoCantidadCanasta(
                                          idAlimento: widget.idAlimento,
                                          idCanasta: '0001') ??
                                  0)
                              .toStringAsFixed(0),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_sweep_outlined),
                          color: Colors.white,
                          iconSize: 32,
                          onPressed: () {
                            Provider.of<Canasta>(context, listen: false)
                                .eliminaAlimentoCanasta(
                                    idAlimento: widget.idAlimento,
                                    idCanasta: '0001');
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
