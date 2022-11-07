import 'package:fixa_app/providers/alimentos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/canasta_provider.dart';
import '../../providers/recetas_provider.dart';

class SuperAdminScreen extends StatelessWidget {
  const SuperAdminScreen({Key key}) : super(key: key);
  static const routeName = './super_admin_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Super administrador',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Borra recetas locales'),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Provider.of<Receta>(context, listen: false)
                          .eliminaArchivoRecetasLS();
                      Provider.of<Canasta>(context, listen: false)
                          .eliminaTodasLasRecetasCanasta();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Restaura alimentos originales'),
                  IconButton(
                    icon: const Icon(
                      Icons.memory_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Provider.of<Alimentos>(context, listen: false)
                          .restauraAlimentosOriginales();
                      Provider.of<Alimentos>(context, listen: false)
                          .setAlimentoItems();
                      //Elimina recetas con alimentos inexistentes
                      Provider.of<Receta>(context, listen: false)
                          .actualizaRecetasAlimentosInexistentes(
                              Provider.of<Alimentos>(context, listen: false)
                                  .eliminaRecetasConAlimentosInexistentes(
                                      Provider.of<Receta>(context,
                                              listen: false)
                                          .recetaItem));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
