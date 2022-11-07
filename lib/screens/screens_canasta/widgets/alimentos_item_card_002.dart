import 'package:flutter/material.dart';

import '../../../providers/alimentos_provider.dart';
import '../../../providers/canasta_provider.dart';
import '../../screens_alimentos/widgets/alimentos_item_detalle_popup_001.dart';
import 'package:provider/provider.dart';

class AlimentosItemCard002 extends StatefulWidget {
  const AlimentosItemCard002(
      {Key key, this.idAlimento, this.alimentoInformacion})
      : super(key: key);

  //Entrada información
  final String idAlimento;
  final AlimentoItem alimentoInformacion;

  @override
  State<AlimentosItemCard002> createState() => _AlimentosItemCard002State();
}

const Color colorEnviado001 = Color.fromARGB(255, 15, 167, 152);
const Color colorEnviado002 = Color.fromARGB(255, 242, 157, 54);

class _AlimentosItemCard002State extends State<AlimentosItemCard002> {
  void _alimentosItemDetallePopup() {
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
            idAlimento: widget.idAlimento,
            color: colorEnviado001,
          ),
        ),
      ),
    );
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
            title: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                widget.alimentoInformacion.nombre,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            subtitle: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    size: 24,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Provider.of<Canasta>(context, listen: false)
                        .restaUnoPorAlimentoId(widget.idAlimento);
                    setState(() {});
                  },
                ),
                Text(
                  (Provider.of<Canasta>(context).alimentoCantidadCanasta(
                              idAlimento: widget.idAlimento,
                              idCanasta: '0001') ??
                          0)
                      .toStringAsFixed(0),
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    size: 24,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Provider.of<Canasta>(context, listen: false)
                        .sumaUnoPorAlimentoId(widget.idAlimento);
                  },
                ),
              ],
            ),
            trailing: Text(
              '${widget.alimentoInformacion.resumen.peso_bruto_g.toStringAsFixed(1)} g',
              style: const TextStyle(color: Colors.white, fontSize: 24),
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
