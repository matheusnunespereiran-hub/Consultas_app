import 'package:flutter_test/flutter_test.dart';
import 'package:consultas_app/models/consulta.dart';

void main() {
  test('Consulta é convertida para mapa e reconstruída', () {
    const original = Consulta(id: '1', paciente: 'Ana', data: '20/11/2026', horario: '14:30', motivo: 'Rotina');
    final reconstruida = Consulta.fromMap(original.toMap());
    expect(reconstruida.paciente, 'Ana');
    expect(reconstruida.data, '20/11/2026');
    expect(reconstruida.id, '1');
  });
}
