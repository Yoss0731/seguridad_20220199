import 'package:flutter/material.dart';
import 'package:seguridad_20220199/models/incidencias.dart';
import 'package:seguridad_20220199/database/database_helper.dart';
import 'package:seguridad_20220199/screens/incidencia_detail.dart';

class IncidenciaList extends StatefulWidget {
  @override
  _IncidenciaListState createState() => _IncidenciaListState();
}

class _IncidenciaListState extends State<IncidenciaList> {
  late Future<List<Incidencia>> _incidencias;

  @override
  void initState() {
    super.initState();
    _incidencias = DatabaseHelper().getIncidencias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Incidencias'),
      ),
      body: FutureBuilder<List<Incidencia>>(
        future: _incidencias,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay incidencias registradas'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Incidencia incidencia = snapshot.data![index];
                return ListTile(
                  title: Text(incidencia.titulo),
                  subtitle: Text(incidencia.fecha.toLocal().toString()),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            IncidenciaDetail(incidencia: incidencia),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
