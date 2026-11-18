class Consulta {
  final String id;
  final String paciente;
  final String data;
  final String horario;
  final String motivo;

  const Consulta({
    required this.id,
    required this.paciente,
    required this.data,
    required this.horario,
    required this.motivo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'paciente': paciente,
      'data': data,
      'horario': horario,
      'motivo': motivo,
    };
  }

  factory Consulta.fromMap(Map<String, dynamic> map) {
    return Consulta(
      id: map['id'],
      paciente: map['paciente'],
      data: map['data'],
      horario: map['horario'],
      motivo: map['motivo'],
    );
  }
}

