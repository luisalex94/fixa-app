import 'package:flutter/material.dart';

class ConsejosScreen extends StatelessWidget {
  const ConsejosScreen({Key key}) : super(key: key);
  static const routeName = './consejos_screen.dart';

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
        image: DecorationImage(
            image: AssetImage('assets/images/arbol2.png'),
            fit: BoxFit.fitWidth),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Consejos e información',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            //Tarjeta 001
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.white30,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          size: 46,
                          color: Colors.white,
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Canasta de compras',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        'Este icono indica cuando un alimento o receta está agregado o no a la canasta (carro de compras).',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Tarjeta 002
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.white30,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Icon(
                          Icons.people_outline,
                          size: 46,
                          color: Colors.white,
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Porciones de platillos',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        'Indica la cantidad de platillos que se preparan con determinada receta. También indica la cantidad de platillos que se preparan con la cantidad de receta las veces agregada a la canasta (carro de compras).',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Tarjeta 003
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.white30,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.star_border,
                              size: 46,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 46,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.star,
                              size: 46,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Favoritos',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Text(
                        'Agrega a favoritos tus alimentos favoritos, para que siempre esten a la mano de una manera más rápida para tus recetas favoritas.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
