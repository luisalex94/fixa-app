import 'package:flutter/material.dart';

import 'package:fixa_app/providers/alimentos_provider.dart';
import 'package:fixa_app/providers/canasta_provider.dart';
import 'package:fixa_app/screens/screens_alimentos/screens/alimentos_categorias_screen.dart';
import 'package:fixa_app/screens/screens_canasta/widgets/alimentos_item_card_002.dart';
import 'package:fixa_app/screens/screens_canasta/widgets/alimentos_item_card_003.dart';
import 'package:fixa_app/screens/screens_canasta/widgets/receta_item_card_002.dart';
import 'package:fixa_app/screens/screens_recetas/screens/recetas_screen.dart';
import 'package:provider/provider.dart';

import '../../../providers/carrito_provider.dart';
import '../../../providers/navegador_helper.dart';
import '../../../providers/recetas_provider.dart';

class CanastaScreen extends StatefulWidget {
  const CanastaScreen({Key key}) : super(key: key);
  static const routeName = './canasta_screen';

  @override
  State<CanastaScreen> createState() => _CanastaScreenState();
}

bool alimentosButton = true;
bool recetasButton = false;
bool carroButton = false;

//Mapeos
Map<String, double> alimentosAlimentos;
Map<String, double> alimentosRecetas;
Map<String, DetalleCarrito> alimentosTotalesFinal;
Map<String, DetalleCarrito> alimentosTotalesFinalCarrito;
Map<String, DetalleCarrito> alimentosTotales;

//OJO NO ESTAS REINICIANDO ALIMENTOS TOTALES, TENER CUIDADO
Map<String, DetalleCarrito> _actualizaCanasta(
    Map<String, double> alimentosAlimentosEntry,
    Map<String, double> alimentosRecetasEntry) {
  alimentosTotales ??= {};
  //Reinicia a cero el Map respuesta alimentosTotales
  //alimentosTotales = {};
  //CEREA CANTIDAD ALIMENTOS CARRITO
  alimentosTotales.forEach((key, value) {
    value.carrito = 0.0;
  });
  //AGREGA LOS ALIMENTOS DE ALIMENTOS
  alimentosAlimentosEntry.forEach(
    (idAlimento, cantidadAlimento) {
      if (alimentosTotales.containsKey(idAlimento)) {
        alimentosTotales.update(
            idAlimento,
            (value) => DetalleCarrito(
                carrito: cantidadAlimento,
                enCasa: value.enCasa,
                listo: value.listo));
      } else {
        alimentosTotales.putIfAbsent(
          idAlimento,
          () => DetalleCarrito(
            carrito: cantidadAlimento,
            enCasa: 0,
            listo: false,
          ),
        );
      }
    },
  );
  //AGREGA LOS ALIMENTOS DE LAS RECETAS
  alimentosRecetasEntry.forEach(
    (idAlimento, cantidadAlimento) {
      if (alimentosTotales.containsKey(idAlimento)) {
        alimentosTotales.update(
            idAlimento,
            (value) => DetalleCarrito(
                carrito: value.carrito + cantidadAlimento,
                enCasa: value.enCasa,
                listo: value.listo));
      } else {
        alimentosTotales.putIfAbsent(
          idAlimento,
          () => DetalleCarrito(
            carrito: cantidadAlimento,
            enCasa: 0,
            listo: false,
          ),
        );
      }
    },
  );
  //AQUI RETIRA LOS ALIMENTOS CON CEROS DE CANTIDAD
  alimentosTotales != null
      ? alimentosTotales.removeWhere((key, value) => value.carrito == 0.0)
      : alimentosTotales = {};
  return alimentosTotales;
}

bool inicio = true;

class _CanastaScreenState extends State<CanastaScreen> {
  @override
  void didChangeDependencies() {
    if (inicio) {
      Provider.of<Canasta>(context, listen: false).setCanastaItem();
      Provider.of<Receta>(context, listen: false).setRecetaItems();
      Provider.of<Carrito>(context, listen: false).setCarritoItemsLS();
    }
    inicio = false;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CanastaScreen oldWidget) {
    actualizaCarrito();
    super.didUpdateWidget(oldWidget);
  }

  void actualizaCarrito() {
    //Alimentos totales:
    alimentosTotales =
        Provider.of<Carrito>(context, listen: false).carritoTotal();
    alimentosAlimentos = Provider.of<Canasta>(context, listen: false).alimentos;
    //Obtenemos un Map<String, double> de la suma total de alimentos de recetas y sus cantidades
    alimentosRecetas = Provider.of<Receta>(context, listen: false)
        .resumenRecetasParaCarrito(
            Provider.of<Canasta>(context, listen: false).recetas);
    //Suma de alimentos final (recetas mas alimentos)
    alimentosTotalesFinal =
        _actualizaCanasta(alimentosAlimentos, alimentosRecetas);
    //Dispara actualizar carrito
    Provider.of<Carrito>(context, listen: false)
        .actualizaCarrito(alimentosTotalesFinal);
    alimentosTotalesFinalCarrito =
        Provider.of<Carrito>(context, listen: false).carritoTotal();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final canastas = Provider.of<Canasta>(context);
    Map<String, AlimentoItem> alimentosCanasta =
        Provider.of<Alimentos>(context, listen: false)
            .getAlimentosCanasta(canastas.alimentos);
    double alturaBottomBar = 60.0;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromARGB(255, 15, 167, 152),
            Color.fromARGB(255, 242, 192, 43),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: carroButton
              ? const Text(
                  'Lista de compras',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              : const Text(
                  'Canasta',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
          /*actions: [
            IconButton(
              icon: const Icon(Icons.print),
              onPressed: () {
                Provider.of<Carrito>(context, listen: false).imprimeArchivoLS();
              },
            )
          ],*/
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white24,
          elevation: 0,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    alimentosButton = true;
                    recetasButton = false;
                    carroButton = false;
                    setState(() {});
                    Provider.of<NavegadorHelper>(context, listen: false)
                        .setNavegadorDetalleAlimento(
                      agregar_canasta: false,
                      agregar_receta: false,
                      ver_alimento: false,
                      ver_canasta: false,
                      ver_receta: false,
                      idAlimento: '',
                      idCanasta: '',
                      idReceta: '',
                    );
                  },
                  child: Container(
                    color:
                        alimentosButton ? Colors.white38 : Colors.transparent,
                    height: alturaBottomBar,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add,
                          size: 22,
                          color: Colors.white,
                        ),
                        Text(
                          'Alimentos',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    alimentosButton = false;
                    recetasButton = true;
                    carroButton = false;
                    setState(() {});
                  },
                  child: Container(
                    color: recetasButton ? Colors.white38 : Colors.transparent,
                    height: alturaBottomBar,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add,
                          size: 22,
                          color: Colors.white,
                        ),
                        Text(
                          'Recetas',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    alimentosButton = false;
                    recetasButton = false;
                    carroButton = true;
                    actualizaCarrito();
                  },
                  child: Container(
                    color: carroButton ? Colors.white38 : Colors.transparent,
                    height: alturaBottomBar,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 22,
                          color: Colors.white,
                        ),
                        FittedBox(
                          child: Text(
                            'Lista de compras',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            alimentosButton
                ? GestureDetector(
                    onTap: () {
                      Provider.of<NavegadorHelper>(context, listen: false)
                          .setNavegadorDetalleAlimento(
                        agregar_canasta: false,
                        agregar_receta: false,
                        ver_alimento: false,
                        ver_canasta: false,
                        ver_receta: false,
                        idAlimento: '',
                        idCanasta: '',
                        idReceta: '',
                      );
                      Navigator.of(context)
                          .pushNamed(AlimentosCategoriasScreen.routeName);
                    },
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white24,
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Agregar alimento',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            recetasButton
                ? GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(RecetasScreen.routeName);
                    },
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white24,
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Agregar receta',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            alimentosButton
                ? Expanded(
                    child: ListView.builder(
                      itemCount: alimentosCanasta.length,
                      itemBuilder: (context, index) => AlimentosItemCard002(
                        idAlimento: alimentosCanasta.values.toList()[index].id,
                        alimentoInformacion:
                            alimentosCanasta.values.toList()[index],
                      ),
                    ),
                  )
                : const SizedBox(),
            recetasButton
                ? Expanded(
                    child: ListView.builder(
                      itemCount: canastas.recetas.length,
                      itemBuilder: (context, index) => RecetaItemCard002(
                        idReceta: canastas.recetas.keys.toList()[index],
                        cantidadReceta: canastas.recetas.values.toList()[index],
                      ),
                    ),
                  )
                : const SizedBox(),
            carroButton
                ? Expanded(
                    child: ListView.builder(
                      itemCount: alimentosTotalesFinalCarrito.length,
                      itemBuilder: (context, index) => AlimentosItemCard003(
                        idAlimento:
                            alimentosTotalesFinalCarrito.keys.toList()[index],
                        detalleCarritoAlimento:
                            alimentosTotalesFinalCarrito.values.toList()[index],
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
