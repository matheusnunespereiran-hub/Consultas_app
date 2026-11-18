import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/consulta.dart';

class ConsultaService {
  static const String _chaveConsultas = 'consultas';

  static Future<List<Consulta>> listar() async {
    final prefs = await SharedPreferences.getInstance();
    final textoSalvo = prefs.getString(_chaveConsultas) ?? '[]';

    final List<dynamic> lista = jsonDecode(textoSalvo);

    return lista
        .map((item) => Consulta.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  static Future<void> adicionar(Consulta consulta) async {
    final consultas = await listar();
    consultas.add(consulta);
    await _salvar(consultas);
  }

  static Future<void> atualizar(Consulta consultaAtualizada) async {
    final consultas = await listar();

    final indice = consultas.indexWhere(
      (consulta) => consulta.id == consultaAtualizada.id,
    );

    if (indice != -1) {
      consultas[indice] = consultaAtualizada;
      await _salvar(consultas);
    }
  }

  static Future<void> excluir(String id) async {
    final consultas = await listar();
    consultas.removeWhere((consulta) => consulta.id == id);
    await _salvar(consultas);
  }

  static Future<void> _salvar(List<Consulta> consultas) async {
    final prefs = await SharedPreferences.getInstance();

    final listaMapeada = consultas.map((consulta) => consulta.toMap()).toList();
    await prefs.setString(_chaveConsultas, jsonEncode(listaMapeada));
  }
}

