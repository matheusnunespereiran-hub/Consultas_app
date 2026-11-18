// Modelo: representa uma consulta no aplicativo.
class Consulta {
  final String id;
  final String paciente;
  final String data;
  final String horario;
  final String motivo;

  const Consulta({required this.id, required this.paciente, required this.data, required this.horario, required this.motivo});

  // Converte o objeto para um mapa que pode ser salvo como JSON.
  Map<String, dynamic> toMap() => {'id': id, 'paciente': paciente, 'data': data, 'horario': horario, 'motivo': motivo};

  // Cria um objeto Consulta a partir dos dados lidos.
  factory Consulta.fromMap(Map<String, dynamic> map) => Consulta(
    id: map['id'], paciente: map['paciente'], data: map['data'], horario: map['horario'], motivo: map['motivo'],
  );
}
