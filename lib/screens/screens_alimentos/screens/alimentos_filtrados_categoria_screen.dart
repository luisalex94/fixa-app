import 'package:fixa_app/screens/screens_alimentos/widgets/alimentos_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/alimentos_provider.dart';
import 'agrega_alimento_screen.dart';

class AlimentosFiltradosCategoria extends StatefulWidget {
  const AlimentosFiltradosCategoria({Key key}) : super(key: key);
  static const routeName = './alimentos_filtrados_categoria';

  @override
  State<AlimentosFiltradosCategoria> createState() =>
      _AlimentosFiltradosCategoriaState();
}

Map<String, AlimentoItem> alimentosFiltradosCategoria = {};
Map<String, AlimentoItem> respuesta = {};

class _AlimentosFiltradosCategoriaState
    extends State<AlimentosFiltradosCategoria> {
  String categoria;

  @override
  void didChangeDependencies() {
    respuesta = {};
    alimentosFiltradosCategoria = {};
    categoria = ModalRoute.of(context).settings.arguments as String;
    if (categoria == 'Favoritos') {
      alimentosFiltradosCategoria =
          Provider.of<Alimentos>(context).alimentosItemFavoritos();
    } else if (categoria == 'Todos') {
      alimentosFiltradosCategoria =
          Provider.of<Alimentos>(context).alimentosItem;
    } else {
      alimentosFiltradosCategoria =
          Provider.of<Alimentos>(context, listen: false)
              .alimentosItemCategoria(categoria);
    }
    super.didChangeDependencies();
  }

  void buscar() {
    respuesta = {};
    alimentosFiltradosCategoria.forEach((key, value) {
      if (value.nombre
              .toLowerCase()
              .contains(buscaController.text.toLowerCase()) ==
          true) {
        respuesta.putIfAbsent(key, () => value);
      }
    });
    setState(() {});
  }

  final buscaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(categoria, style: const TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AgregaAlimentoScreen.routeName);
              },
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: alimentosFiltradosCategoria.isEmpty
            ? SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 38,
                      color: Colors.white,
                    ),
                    Text(
                      'Aún no has agregado nada aquí. Intenta agregar más alimentos a favoritos u otras categorías.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )
            : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: buscaController,
                      decoration: InputDecoration(
                        hintText: 'Busca un alimento',
                        hintStyle: const TextStyle(color: Colors.white),
                        iconColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      onChanged: (value) {
                        buscar();
                      },
                    ),
                  ),
                  respuesta.isEmpty && buscaController.text.isEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: alimentosFiltradosCategoria.length,
                            itemBuilder: (context, index) => AlimentosItemCard(
                              id: alimentosFiltradosCategoria.values
                                  .toList()[index]
                                  .id,
                              alimentoInformacion: alimentosFiltradosCategoria
                                  .values
                                  .toList()[index],
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: respuesta.length,
                            itemBuilder: (context, index) => AlimentosItemCard(
                              id: respuesta.values.toList()[index].id,
                              alimentoInformacion:
                                  respuesta.values.toList()[index],
                            ),
                          ),
                        )
                ],
              ),
      ),
    );
  }
}
