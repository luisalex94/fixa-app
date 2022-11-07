import 'package:fixa_app/screens/screens_recetas/screens/agrega_receta_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/recetas_provider.dart';
import '../widgets/receta_item_card.dart';

class RecetasScreen extends StatefulWidget {
  const RecetasScreen({Key key}) : super(key: key);
  static const routeName = './recetas_screen';

  @override
  State<RecetasScreen> createState() => _RecetasScreenState();
}

bool inicio = true;

class _RecetasScreenState extends State<RecetasScreen> {
  @override
  void didChangeDependencies() {
    if (inicio) {
      Provider.of<Receta>(context, listen: false).setRecetaItems();
    }
    inicio = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final recetasItem = Provider.of<Receta>(context).recetaItem;
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
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Recetas',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AgregaRecetaScreen.routeName);
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: recetasItem.length,
                itemBuilder: (context, index) => RecetaItemCard(
                  idReceta: recetasItem.values.toList()[index].id,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
