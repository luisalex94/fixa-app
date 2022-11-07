import 'package:fixa_app/providers/navegador_helper.dart';
import 'package:fixa_app/screens/screens_alimentos/screens/alimentos_categorias_screen.dart';
import 'package:fixa_app/screens/screens_canasta/screens/canasta_screen.dart';
import 'package:fixa_app/screens/screens_info/consejos_screen.dart';
import 'package:fixa_app/screens/screens_info/info_screen.dart';
import 'package:fixa_app/screens/screens_info/informacion_complementaria.dart';
import 'package:fixa_app/screens/screens_recetas/screens/recetas_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/alimentos_provider.dart';
import '../providers/recetas_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key, @required this.title}) : super(key: key);
  static const routeName = './main_screen';

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with ChangeNotifier {
  void informacionScreenPopup() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        backgroundColor: const Color.fromARGB(255, 15, 167, 152),
        content: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: const InformacionScreen(),
        ),
      ),
    );
  }

  //Elimina recetas con alimentos inexistentes
  Future<void> eliminaRecetasConAlimentosInexistentesMain() async {
    Provider.of<Receta>(context, listen: false)
        .actualizaRecetasAlimentosInexistentes(
            Provider.of<Alimentos>(context, listen: false)
                .eliminaRecetasConAlimentosInexistentes(
                    Provider.of<Receta>(context, listen: false).recetaItem));
  }

  void arranqueComprobacion() async {
    await Provider.of<Alimentos>(context, listen: false)
        .setAlimentoItems()
        .then((value) =>
            //Set recetas, si hay LS respeta LS, de lo contrario vacía recetaItems
            Provider.of<Receta>(context, listen: false).setRecetaItems().then(
                  (value) =>
                      //Set alimentos, si hay LS respeta LS, de lo contrario carga la constante alimentos

                      //Elimina recetas donde haya alimentos que no existen en la libreria
                      eliminaRecetasConAlimentosInexistentesMain(),
                ));
  }

  @override
  Widget build(BuildContext context) {
    arranqueComprobacion();
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
            image: AssetImage('assets/images/arbol2.png'),
            fit: BoxFit.fitWidth),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.info_outline,
                size: 32,
                color: Colors.white,
              ),
              onPressed: () {
                informacionScreenPopup();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.gamepad_outlined,
                size: 32,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(InformacionComplementaria.routeName);
              },
            )
            /*IconButton(
              icon: const Icon(
                Icons.settings,
                size: 32,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(SuperAdminScreen.routeName);
              },
            ),*/
            /*IconButton(
              icon: const Icon(Icons.food_bank_outlined),
              onPressed: () {
                Provider.of<Alimentos>(context, listen: false)
                    .setAlimentoItems();
              },
            )*/
            /*IconButton(
              icon: const Icon(Icons.receipt_long_outlined),
              onPressed: () {
                Provider.of<Receta>(context, listen: false)
                    .eliminaArchivoRecetasLS();
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_bag_outlined),
              onPressed: () {
                Provider.of<Canasta>(context, listen: false)
                    .eliminaArchivoCanastaLS();
              },
            ),*/
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Bienvenidos',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 40)),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
                Column(
                  children: [
                    Card(
                      color: Colors.white24,
                      elevation: 0,
                      child: ListTile(
                        title: const Text(
                          'Alimentos',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        subtitle: const Text(
                          'Lista de alimentos.',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        isThreeLine: true,
                        trailing: const Icon(
                          Icons.food_bank,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Provider.of<NavegadorHelper>(context, listen: false)
                              .setNavegadorDetalleAlimento(
                                  /*agregar_canasta: false,
                            agregar_receta: false,
                            ver_alimento: false,
                            ver_canasta: false,
                            ver_receta: false,
                            idAlimento: '',
                            idCanasta: '',
                            idReceta: '',*/
                                  );

                          Navigator.of(context)
                              .pushNamed(AlimentosCategoriasScreen.routeName);
                        },
                      ),
                    ),
                    Card(
                      color: Colors.white24,
                      elevation: 0,
                      child: ListTile(
                        title: const Text(
                          'Recetas',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        subtitle: const Text(
                          'Las recetas de tus alimentos favoritos.',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        isThreeLine: true,
                        trailing: const Icon(
                          Icons.receipt,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RecetasScreen.routeName);
                        },
                      ),
                    ),
                    Card(
                      color: Colors.white24,
                      elevation: 0,
                      child: ListTile(
                        title: const Text(
                          'Lista de compras',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        subtitle: const Text(
                          'Lista con las compras necesarias.',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        isThreeLine: true,
                        trailing: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(CanastaScreen.routeName);
                        },
                      ),
                    ),
                    Card(
                      color: Colors.white24,
                      elevation: 0,
                      child: ListTile(
                        title: const Text(
                          'Consejos e información',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        subtitle: const Text(
                          'Consejos, tips e información para ti.',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        isThreeLine: true,
                        trailing: const Icon(
                          Icons.info_outline,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ConsejosScreen.routeName);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
