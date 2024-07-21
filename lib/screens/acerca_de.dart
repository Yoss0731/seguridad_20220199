import 'package:flutter/material.dart';

class AcercaDe extends StatelessWidget {
  final String nombre = 'Yosser';
  final String apellido = 'Batista';
  final String matricula = '2022-0199';
  final String reflexion =
      'La seguridad es un derecho y una responsabilidad de todos.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/icons/Yo.jpg'), // Asegúrate de tener esta imagen en tu proyecto
            ),
            SizedBox(height: 20),
            Text(
              '$nombre $apellido',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Matrícula: $matricula',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Text(
              reflexion,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
