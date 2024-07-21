import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:seguridad_20220199/database/database_helper.dart';
import 'package:seguridad_20220199/models/incidencias.dart';

class IncidenciaForm extends StatefulWidget {
  @override
  _IncidenciaFormState createState() => _IncidenciaFormState();
}

class _IncidenciaFormState extends State<IncidenciaForm> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  File? _image;
  File? _video;
  File? _audio;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _pickVideo() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      setState(() {
        _video = File(video.path);
      });
    }
  }

  Future<void> _pickAudio() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      setState(() {
        _audio = File(result.files.single.path!);
      });
    }
  }

  Future<void> _submitForm() async {
    final String titulo = _tituloController.text;
    final String descripcion = _descripcionController.text;

    if (titulo.isNotEmpty && descripcion.isNotEmpty) {
      final dbHelper = DatabaseHelper();
      final data = {
        'titulo': titulo,
        'descripcion': descripcion,
        'foto': _image?.path ?? '',
        'video': _video?.path ?? '',
        'audio': _audio?.path ?? '',
      };

      await dbHelper.insertIncidencia(data as Incidencia);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incidencia registrada'),
        ),
      );

      // Limpia los campos después de enviar el formulario
      _tituloController.clear();
      _descripcionController.clear();
      setState(() {
        _image = null;
        _video = null;
        _audio = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, complete todos los campos'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Incidencia'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            SizedBox(height: 20),
            _image == null
                ? Text('No hay imagen seleccionada.')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Seleccionar Imagen'),
            ),
            SizedBox(height: 20),
            _video == null
                ? Text('No hay video seleccionado.')
                : Text('Video seleccionado: ${_video!.path}'),
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Seleccionar Video'),
            ),
            SizedBox(height: 20),
            _audio == null
                ? Text('No hay audio seleccionado.')
                : Text('Audio seleccionado: ${_audio!.path}'),
            ElevatedButton(
              onPressed: _pickAudio,
              child: Text('Seleccionar Audio'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Enviar Incidencia'),
            ),
          ],
        ),
      ),
    );
  }
}
