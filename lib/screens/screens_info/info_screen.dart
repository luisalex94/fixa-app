import 'package:flutter/material.dart';

class InformacionScreen extends StatelessWidget {
  const InformacionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String version = 'Fixa @Versión 0.5.0';
    String fecha = '07 noviembre 2022';
    String informativo001 =
        'Esta es una versión de prueba de Fixa, una APP especialmente diseñada para el control de la nutrición del usuario en base a los requerimientos brindados por un profesional de la salud.';
    String informativo002 =
        'BAJO NINGUNA CIRCUNSTANCIA ESTA APLICACIÓN SUSTITUYE O REEMPLAZA LA FIGURA DE UN PROFESIONAL DE LA SALUD ESPECIALSITA EN MATERIA DE NUTRICIÓN O CUALQUIER OTRO.';
    String informativo003 =
        'El uso de esta aplicación es bajo su propia responsabilidad y FIXA APP y su equipo de desarrollo no se hace responsable bajo ningun caso de cualquier problema de salud. Si no está de acuerdo, deje de utilizar la aplicación de manera inmediata.';
    String informativo004 =
        'Los datos que esta aplicación poseé están basados en el SMAE (Sistema Mexicano de Alimentos).';
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            //color: const Color.fromARGB(255, 15, 167, 152),
            child: Column(
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 46,
                  color: Colors.white,
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Text(
                  version,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  fecha,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Text(
                  informativo002,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Text(
                  informativo001,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Text(
                  informativo003,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Text(
                  informativo004,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
