import 'package:fixa_app/providers/navegador_helper.dart';
import 'package:fixa_app/screens/screens_recetas/widgets/alimentos_item_detalle_popup_002.dart';
import 'package:flutter/material.dart';

import '../../../providers/alimentos_provider.dart';
import 'alimentos_item_detalle_popup_001.dart';
import 'package:provider/provider.dart';

class AlimentosItemCard extends StatefulWidget {
  const AlimentosItemCard({Key key, this.id, this.alimentoInformacion})
      : super(key: key);

  //Entrada información
  final String id;
  final AlimentoItem alimentoInformacion;

  @override
  State<AlimentosItemCard> createState() => _AlimentosItemCardState();
}

const Color colorEnviado001 = Color.fromARGB(255, 15, 167, 152);
const Color colorEnviado002 = Color.fromARGB(255, 242, 157, 54);

class _AlimentosItemCardState extends State<AlimentosItemCard> {
  void _alimentosItemDetallePopup() {
    NavegadorDetalleAlimento agregarReceta =
        Provider.of<NavegadorHelper>(context, listen: false)
            .getNavegadorDetalleAlimento;
    if (agregarReceta.agregar_receta == true) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          insetPadding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          backgroundColor: colorEnviado002,
          content: SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: AlimentosItemDetallePopup002(
              idAlimento: widget.id,
              color: colorEnviado002,
            ),
          ),
        ),
      );
    } else if (1 == 2) {
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          insetPadding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          backgroundColor: colorEnviado001,
          content: SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: AlimentosItemDetallePopup001(
              idAlimento: widget.id,
              color: colorEnviado001,
            ),
          ),
        ),
      );
    }
  }

  //Constructor
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      elevation: 0,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              widget.alimentoInformacion.nombre,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Porcion: ${widget.alimentoInformacion.resumen.cant_suge.toStringAsFixed(2)} ${widget.alimentoInformacion.resumen.unidad}(s)',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  '${widget.alimentoInformacion.resumen.peso_bruto_g.toStringAsFixed(1)} g, ${widget.alimentoInformacion.resumen.energia_kcal.toStringAsFixed(1)} kcal',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            trailing: widget.alimentoInformacion.esFavorito
                ? IconButton(
                    icon: const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      Provider.of<Alimentos>(context, listen: false)
                          .cambiaEstadoFavorito(widget.id);
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
                          .cambiaEstadoFavorito(widget.id);
                      setState(() {});
                    },
                  ),
            isThreeLine: true,
            onTap: () {
              _alimentosItemDetallePopup();
            },
          ),
        ],
      ),
    );
  }
}
