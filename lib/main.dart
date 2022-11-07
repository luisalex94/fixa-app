import 'package:fixa_app/screens/screens_alimentos/screens/alimentos_categorias_screen.dart';
import 'package:fixa_app/screens/screens_canasta/screens/canasta_screen.dart';
import 'package:fixa_app/screens/screens_info/consejos_screen.dart';
import 'package:fixa_app/screens/screens_info/informacion_complementaria.dart';
import 'package:fixa_app/screens/screens_info/super_admin_screen.dart';
import 'package:fixa_app/screens/screens_recetas/screens/agrega_receta_screen.dart';
import 'package:fixa_app/screens/screens_recetas/screens/edita_receta_screen.dart';
import 'package:fixa_app/screens/screens_recetas/screens/recetas_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './providers/temporales.dart' show Temporales;
import './providers/alimentos_provider.dart' show Alimentos;
import './providers/recetas_provider.dart' show Receta;
import './providers/canasta_provider.dart' show Canasta;
import './providers/carrito_provider.dart' show Carrito;
import './providers/navegador_helper.dart' show NavegadorHelper;
import 'screens/main_screen.dart';
import 'package:fixa_app/screens/screens_alimentos/screens/agrega_alimento_screen.dart';
import 'screens/screens_alimentos/screens/alimentos_filtrados_categoria_screen.dart';
import 'screens/screens_recetas/screens/detalle_receta_screen.dart';

void main() {
  //Evita que el dispositivo cambie a pantalla horizontal
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Alimentos(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Receta(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Temporales(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Canasta(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Carrito(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => NavegadorHelper(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.grey,
              textTheme:
                  const TextTheme(titleSmall: TextStyle(color: Colors.white))),
          home: const MainScreen(title: 'Flutter Demo Home Page'),
          routes: {
            AgregaAlimentoScreen.routeName: (context) =>
                const AgregaAlimentoScreen(),
            RecetasScreen.routeName: (context) => const RecetasScreen(),
            AgregaRecetaScreen.routeName: (context) =>
                const AgregaRecetaScreen(),
            AlimentosCategoriasScreen.routeName: (context) =>
                const AlimentosCategoriasScreen(),
            AlimentosFiltradosCategoria.routeName: (context) =>
                const AlimentosFiltradosCategoria(),
            DetalleRecetaScreen.routeName: (context) =>
                const DetalleRecetaScreen(),
            EditaRecetaScreen.routeName: (context) => const EditaRecetaScreen(),
            CanastaScreen.routeName: (context) => const CanastaScreen(),
            ConsejosScreen.routeName: (context) => const ConsejosScreen(),
            SuperAdminScreen.routeName: (context) => const SuperAdminScreen(),
            InformacionComplementaria.routeName: (context) =>
                const InformacionComplementaria(),
          }),
    );
  }
}
