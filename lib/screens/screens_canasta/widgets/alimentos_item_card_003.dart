import 'package:fixa_app/providers/carrito_provider.dart';
import 'package:flutter/material.dart';

import '../../../providers/alimentos_provider.dart';
import 'package:provider/provider.dart';

//Esta es la tarjeta que aparece en LISTA DE COMPRAS
class AlimentosItemCard003 extends StatefulWidget {
  const AlimentosItemCard003(
      {Key key, this.idAlimento, this.detalleCarritoAlimento})
      : super(key: key);

  //Entrada información
  final String idAlimento;
  final DetalleCarrito detalleCarritoAlimento;

  @override
  State<AlimentosItemCard003> createState() => _AlimentosItemCard003State();
}

const Color colorEnviado001 = Color.fromARGB(255, 15, 167, 152);
const Color colorEnviado002 = Color.fromARGB(255, 242, 157, 54);

class _AlimentosItemCard003State extends State<AlimentosItemCard003> {
  //Constructor
  @override
  Widget build(BuildContext context) {
    final alimentoInformacion = Provider.of<Alimentos>(context, listen: false)
        .alimentoPorId(widget.idAlimento);

    return Card(
      color:
          widget.detalleCarritoAlimento.listo ? Colors.black26 : Colors.white24,
      elevation: 0,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    alimentoInformacion.nombre,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Switch(
                    activeColor: Colors.green[500],
                    value: widget.detalleCarritoAlimento.listo,
                    onChanged: (value) {
                      Provider.of<Carrito>(context, listen: false)
                          .switchPendiente(
                              idAlimentoCarrito: widget.idAlimento);
                      setState(
                        () {},
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, bottom: 4),
                    //color: Colors.blue,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  constraints: const BoxConstraints(),
                                  onPressed: () {},
                                ),
                                Text(
                                  widget.detalleCarritoAlimento.carrito
                                      .toStringAsFixed(0),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                            Text(
                              '${(alimentoInformacion.resumen.peso_bruto_g * widget.detalleCarritoAlimento.carrito).toStringAsFixed(1)} g',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                /*Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 24,
                                ),*/
                                IconButton(
                                  icon: const Icon(
                                    Icons.home_outlined,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  constraints: const BoxConstraints(),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    Provider.of<Carrito>(context, listen: false)
                                        .restaUnoEnCasa(
                                            idAlimento: widget.idAlimento);
                                    setState(() {});
                                  },
                                ),
                                Text(
                                  Provider.of<Carrito>(context, listen: false)
                                      .getEnCasa(idAlimento: widget.idAlimento)
                                      .toStringAsFixed(0),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                /*Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 24,
                                ),*/
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle_outline_sharp,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    Provider.of<Carrito>(context, listen: false)
                                        .sumaUnoEnCasa(
                                            idAlimento: widget.idAlimento);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            Text(
                              '${(alimentoInformacion.resumen.peso_bruto_g * Provider.of<Carrito>(context, listen: false).getEnCasa(idAlimento: widget.idAlimento))} g',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                /*Expanded(
                  child: Container(
                    color: Colors.amber,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [],
                    ),
                  ),
                ),*/

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${((alimentoInformacion.resumen.peso_bruto_g * widget.detalleCarritoAlimento.carrito) - (alimentoInformacion.resumen.peso_bruto_g * Provider.of<Carrito>(context, listen: false).getEnCasa(idAlimento: widget.idAlimento)))} g',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 26),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
