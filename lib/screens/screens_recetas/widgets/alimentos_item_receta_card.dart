import 'package:fixa_app/providers/temporales.dart';
import 'package:fixa_app/screens/screens_recetas/widgets/alimentos_item_detalle_popup_002.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/alimentos_provider.dart';
import '../../../providers/recetas_provider.dart';

class AlimentosItemRecetaCard extends StatefulWidget {
  const AlimentosItemRecetaCard({
    Key key,
    this.idAlimento,
    this.alimentoInformacion,
    this.idReceta,
  }) : super(key: key);

  //Entrada información
  final String idAlimento;
  final AlimentoItem alimentoInformacion;
  final String idReceta;

  @override
  State<AlimentosItemRecetaCard> createState() =>
      _AlimentosItemRecetaCardState();
}

const Color colorEnviado002 = Color.fromARGB(255, 242, 157, 54);

class _AlimentosItemRecetaCardState extends State<AlimentosItemRecetaCard> {
  void _alimentosItemDetallePopup() {
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
            idAlimento: widget.idAlimento,
            color: colorEnviado002,
          ),
        ),
      ),
    );
  }

  //Constructor
  @override
  Widget build(BuildContext context) {
    double pesoBruto = 0.0;
    double energiaKcal = 0.0;
    Map<String, double> alimentosReceta = {};
    widget.idReceta != null
        ? alimentosReceta = Provider.of<Receta>(context, listen: false)
            .getAlimentosReceta(widget.idReceta)
        : {};
    Map<String, double> alimentosTemp =
        Provider.of<Temporales>(context, listen: false).getTempReceta;
    if (alimentosReceta.isNotEmpty) {
      pesoBruto = Provider.of<Alimentos>(context, listen: false)
          .getPesoBrutoPorAlimentoPorReceta(alimentosReceta, widget.idAlimento);
      energiaKcal = Provider.of<Alimentos>(context, listen: false)
          .getEnergiaKcalPorAlimentoPorReceta(
              alimentosReceta, widget.idAlimento);
    } else {
      pesoBruto = Provider.of<Alimentos>(context, listen: false)
          .getPesoBrutoPorAlimentoPorReceta(alimentosTemp, widget.idAlimento);
      energiaKcal = Provider.of<Alimentos>(context, listen: false)
          .getEnergiaKcalPorAlimentoPorReceta(alimentosTemp, widget.idAlimento);
    }
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
                  'Porciones agregadas: ${widget.alimentoInformacion.porcion.toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  'Aporte energético: ${energiaKcal.toStringAsFixed(0)} Kcal',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
            trailing: Text(
              '${pesoBruto.toStringAsFixed(1)} g',
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
            isThreeLine: true,
            onTap: _alimentosItemDetallePopup,
          ),
        ],
      ),
    );
  }
}
