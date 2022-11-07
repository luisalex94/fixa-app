import 'package:fixa_app/screens/screens_recetas/screens/detalle_receta_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/canasta_provider.dart';
import '../../../providers/recetas_provider.dart';

class RecetaItemCard002 extends StatefulWidget {
  const RecetaItemCard002({Key key, this.idReceta, this.cantidadReceta})
      : super(key: key);
  //static const routeName = './receta_item_card';

  final double cantidadReceta;
  final String idReceta;

  @override
  State<RecetaItemCard002> createState() => _RecetaItemCard002State();
}

class _RecetaItemCard002State extends State<RecetaItemCard002> {
  @override
  Widget build(BuildContext context) {
    //Calcula kcal por receta
    final recetaInformacion =
        Provider.of<Receta>(context).recetaPorId(widget.idReceta);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DetalleRecetaScreen.routeName,
            arguments: widget.idReceta);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white24,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(5),
              alignment: Alignment.center,
              constraints: const BoxConstraints(minHeight: 40),
              child: Text(
                recetaInformacion.nombre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              constraints: const BoxConstraints(minHeight: 10),
              child: Text(
                recetaInformacion.resumen,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.people_outline,
                        size: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        (widget.cantidadReceta * recetaInformacion.porciones)
                            .toStringAsFixed(0),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.cantidadReceta.toStringAsFixed(0),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: () {
                          Provider.of<Canasta>(context, listen: false)
                              .restaUnoPorRecetaId(widget.idReceta);
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle_outline_sharp,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: () {
                          Provider.of<Canasta>(context, listen: false)
                              .sumaUnoPorRecetaId(widget.idReceta);
                          setState(() {});
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
