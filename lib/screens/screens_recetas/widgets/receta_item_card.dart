import 'package:fixa_app/screens/screens_recetas/screens/detalle_receta_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/alimentos_provider.dart';
import '../../../providers/recetas_provider.dart';

class RecetaItemCard extends StatefulWidget {
  const RecetaItemCard({Key key, this.idReceta}) : super(key: key);

  final String idReceta;

  @override
  State<RecetaItemCard> createState() => _RecetaItemCardState();
}

class _RecetaItemCardState extends State<RecetaItemCard> {
  @override
  Widget build(BuildContext context) {
    //Calcula kcal por receta
    double cantidadKcalReceta = Provider.of<Alimentos>(context)
        .getKcalPorRecetaId(
            Provider.of<Receta>(context).getAlimentosReceta(widget.idReceta));
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
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Porciones: ${recetaInformacion.porciones.toStringAsFixed(0)}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Energía total: ${cantidadKcalReceta.toStringAsFixed(0)} Kcal',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                )
              ],
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
