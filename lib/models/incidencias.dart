class Incidencia {
  int? id;
  String titulo;
  DateTime fecha;
  String descripcion;
  String foto;
  String audio;

  Incidencia({
    this.id,
    required this.titulo,
    required this.fecha,
    required this.descripcion,
    required this.foto,
    required this.audio,
  });

  // Método para convertir la instancia a un Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'fecha': fecha.toIso8601String(),
      'descripcion': descripcion,
      'foto': foto,
      'audio': audio,
    };
  }

  // Método para crear una instancia desde un Map
  factory Incidencia.fromMap(Map<String, dynamic> map) {
    return Incidencia(
      id: map['id'],
      titulo: map['titulo'],
      fecha: DateTime.parse(map['fecha']),
      descripcion: map['descripcion'],
      foto: map['foto'],
      audio: map['audio'],
    );
  }
}
