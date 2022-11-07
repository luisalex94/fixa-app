import 'package:fixa_app/screens/screens_alimentos/screens/alimentos_filtrados_categoria_screen.dart';
import 'package:flutter/material.dart';

class AlimentosCategoriaCard extends StatelessWidget {
  const AlimentosCategoriaCard(this.categoria, {Key key}) : super(key: key);

  final String categoria;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AlimentosFiltradosCategoria.routeName,
              arguments: categoria,
            );
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white24),
            margin: const EdgeInsets.all(10),
            child: Text(
              categoria,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
