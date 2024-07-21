import 'package:flutter/material.dart';
import 'package:seguridad_20220199/screens/incidencia_form.dart';
import 'package:seguridad_20220199/screens/incidencia_list.dart';
import 'package:seguridad_20220199/screens/acerca_de.dart';
import 'package:seguridad_20220199/screens/borrar_registros.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seguridad 20220199',
      theme: ThemeData(
        primarySwatch: Colors
            .grey, // Cambiado para reflejar un color de seguridad más neutral
        primaryColor: Colors.grey[800],
        hintColor: Colors.grey[600],
        scaffoldBackgroundColor:
            Colors.black, // Fondo oscuro para mayor discreción
        appBarTheme: AppBarTheme(
          color: Colors.grey[900], // Color oscuro para la AppBar
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.red[700], // Color de botones para alertas
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
              color: Colors.white), // Texto blanco para buen contraste
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge:
              TextStyle(color: Colors.white), // Texto de encabezado en blanco
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenido a Seguridad 20220199',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => IncidenciaForm()),
                );
              },
              child: Text('Registrar Incidencia'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => IncidenciaList()),
                );
              },
              child: Text('Ver Incidencias'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AcercaDe()),
                );
              },
              child: Text('Acerca de'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BorrarRegistros()),
                );
              },
              child: Text('Borrar Registros'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
            ),
          ],
        ),
      ),
    );
  }
}
