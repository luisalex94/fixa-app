import 'package:fixa_app/screens/screens_alimentos/screens/alimentos_filtrados_categoria_screen.dart';
import 'package:fixa_app/screens/screens_alimentos/widgets/alimentos_categoria_card.dart';
import 'package:flutter/material.dart';

import '../../../providers/constantes.dart' as constantes;

class AlimentosCategoriasScreen extends StatelessWidget {
  const AlimentosCategoriasScreen({Key key}) : super(key: key);
  static const routeName = './alimentos_categorias_screen';

  @override
  Widget build(BuildContext context) {
    const listaCategorias = constantes.TIPO_ALIMENTO_LIST;
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
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: const Text('Categorías alimentos',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          AlimentosFiltradosCategoria.routeName,
                          arguments: 'Favoritos');
                    },
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 80),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white24),
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: const [
                          Icon(Icons.star, size: 32, color: Colors.white),
                          Text(
                            'Favoritos',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          AlimentosFiltradosCategoria.routeName,
                          arguments: 'Todos');
                    },
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 80),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white24),
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: const [
                          Icon(Icons.all_inclusive,
                              size: 32, color: Colors.white),
                          Text(
                            'Todos',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: listaCategorias.length,
                itemBuilder: (context, index) =>
                    AlimentosCategoriaCard(listaCategorias[index]),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
