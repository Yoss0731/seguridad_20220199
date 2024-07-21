import 'package:flutter/material.dart';
import 'dart:io';
import 'package:seguridad_20220199/models/incidencias.dart';
import 'package:audioplayers/audioplayers.dart';

class IncidenciaDetail extends StatelessWidget {
  final Incidencia incidencia;

  IncidenciaDetail({required this.incidencia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(incidencia.titulo),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              incidencia.descripcion,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            incidencia.foto.isNotEmpty
                ? Image.file(File(incidencia.foto))
                : Text('No hay imagen disponible'),
            SizedBox(height: 20),
            incidencia.audio.isNotEmpty
                ? AudioPlayerWidget(audioPath: incidencia.audio)
                : Text('No hay audio disponible'),
          ],
        ),
      ),
    );
  }
}

class AudioPlayerWidget extends StatefulWidget {
  final String audioPath;

  AudioPlayerWidget({required this.audioPath});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(widget.audioPath as Source);
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: _togglePlayPause,
        ),
        Text(isPlaying ? 'Reproduciendo...' : 'Pausado'),
      ],
    );
  }
}
