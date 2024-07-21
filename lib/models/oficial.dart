class Oficial {
  int id;
  String foto;
  String nombre;
  String apellido;
  String matricula;

  Oficial({
    required this.id,
    required this.foto,
    required this.nombre,
    required this.apellido,
    required this.matricula,
  });

  // Método para convertir la instancia a un Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'foto': foto,
      'nombre': nombre,
      'apellido': apellido,
      'matricula': matricula,
    };
  }

  // Método para crear una instancia desde un Map
  factory Oficial.fromMap(Map<String, dynamic> map) {
    return Oficial(
      id: map['id'],
      foto: map['foto'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      matricula: map['matricula'],
    );
  }
}
