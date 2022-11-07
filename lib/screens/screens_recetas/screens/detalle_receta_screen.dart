import 'package:fixa_app/providers/navegador_helper.dart';
import 'package:fixa_app/screens/screens_recetas/screens/edita_receta_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/alimentos_provider.dart';
import '../../../providers/canasta_provider.dart';
import '../../../providers/recetas_provider.dart';
import '../widgets/alimentos_item_receta_card.dart';
import '../../screens_alimentos/screens/alimentos_categorias_screen.dart';

class DetalleRecetaScreen extends StatefulWidget {
  const DetalleRecetaScreen({Key key}) : super(key: key);
  static const routeName = './detalle_receta_screen';

  @override
  State<DetalleRecetaScreen> createState() => _DetalleRecetaScreenState();
}

//Variables de inicio
bool inicio = true;
double agregarCanastaVal = 1.0;

class _DetalleRecetaScreenState extends State<DetalleRecetaScreen> {
  @override
  Widget build(BuildContext context) {
    final recetaIdWidget = ModalRoute.of(context).settings.arguments as String;
    //NAVEGADOR
    Provider.of<NavegadorHelper>(context, listen: false)
        .setNavegadorDetalleAlimento(
      agregar_canasta: false,
      agregar_receta: true,
      ver_alimento: false,
      ver_canasta: false,
      ver_receta: false,
      idAlimento: '',
      idCanasta: '',
      idReceta: recetaIdWidget,
    );
    final recetaItem = Provider.of<Receta>(context).recetaPorId(recetaIdWidget);
    final alimentosItems =
        Provider.of<Alimentos>(context).alimentosReceta(recetaItem.alimentos);
    final pesoBrutoReceta = Provider.of<Alimentos>(context)
        .getPesoBrutoPorReceta(recetaItem.alimentos);
    final energiaKcalReceta = Provider.of<Alimentos>(context)
        .getEnergiaKcalPorReceta(recetaItem.alimentos);
    final proteinaReceta = Provider.of<Alimentos>(context, listen: false)
        .getProteinaPorReceta(recetaItem.alimentos);
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
        image: DecorationImage(
            image: AssetImage('assets/images/especias.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<Receta>(context, listen: false)
                    .eliminaReceta(recetaIdWidget);
                Provider.of<Canasta>(context, listen: false)
                    .eliminaRecetaCanasta(idReceta: recetaIdWidget);
                //Provider.of<Carrito>(context)
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditaRecetaScreen.routeName,
                  arguments: recetaIdWidget,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_to_photos_outlined),
              onPressed: () {
                /*Provider.of<Receta>(context, listen: false)
                    .setIdRecetaEdicion(recetaIdWidget);*/
                Navigator.of(context)
                    .pushNamed(AlimentosCategoriasScreen.routeName);
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                recetaItem.nombre,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w300),
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.center,
                child: Text(
                  recetaItem.resumen,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                )),
            const Divider(
              color: Colors.white,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.white,
                          size: 32,
                        ),
                        /*padding: const EdgeInsets.only(
                          bottom: 20,
                          top: 15,
                          left: 15,
                          right: 15,
                        ),
                        constraints: const BoxConstraints(),*/
                        onPressed: () {
                          if (agregarCanastaVal > 1) {
                            agregarCanastaVal = agregarCanastaVal - 1;
                          }
                          setState(() {});
                        },
                      ),
                      Text(
                        agregarCanastaVal.toStringAsFixed(0),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle_outline_sharp,
                          color: Colors.white,
                          size: 32,
                        ),
                        /*padding: const EdgeInsets.only(
                          bottom: 20,
                          top: 15,
                          left: 15,
                          right: 15,
                        ),
                        constraints: const BoxConstraints(),*/
                        onPressed: () {
                          if (agregarCanastaVal < 999) {
                            agregarCanastaVal = agregarCanastaVal + 1;
                          }
                          setState(() {});
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white24,
                          elevation: 0,
                        ),
                        child: const Text('Agregar a la canasta',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                        onPressed: () {
                          Provider.of<Canasta>(context, listen: false)
                              .adicionarCantidadRecetaCanasta(
                            idReceta: recetaIdWidget,
                            idCanasta: '0001',
                            cantidad: agregarCanastaVal,
                          );
                          agregarCanastaVal = 1.0;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 32,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      /*const SizedBox(
                        width: 10,
                      ),*/
                      Text(
                        (Provider.of<Canasta>(context, listen: false)
                                    .getCantidadRecetaId(recetaIdWidget) ??
                                0)
                            .toStringAsFixed(0),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          size: 32,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Provider.of<Canasta>(context, listen: false)
                              .eliminaRecetaCanasta(idReceta: recetaIdWidget);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Peso de la receta: $pesoBrutoReceta g',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    'Contenido energético: $energiaKcalReceta Kcal',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    'Contenido de proteína: ${proteinaReceta.toStringAsFixed(1)} g',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    'Porciones: ${recetaItem.porciones.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: recetaItem.alimentos.length,
                itemBuilder: (context, index) => AlimentosItemRecetaCard(
                  idAlimento: alimentosItems.values.toList()[index].id,
                  alimentoInformacion: alimentosItems.values.toList()[index],
                  idReceta: recetaIdWidget,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
