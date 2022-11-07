import 'package:flutter/material.dart';

class InformacionComplementaria extends StatelessWidget {
  const InformacionComplementaria({Key key}) : super(key: key);
  static const routeName = "./informacion_complementaria";

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
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            "Pruebas en GitHub - Pantalla información complementaria",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 26,
            ),
          ),
        ),
      ),
    );
  }
}
