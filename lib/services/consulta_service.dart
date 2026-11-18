import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/consulta.dart';
import 'auth_service.dart';

// CRUD = Create, Read, Update, Delete (criar, ler, atualizar, excluir).
class ConsultaService {
  static Future<String> _chave() async => 'consultas_${await AuthService.usuarioAtual()}';

  static Future<List<Consulta>> listar() async {
    final prefs = await SharedPreferences.getInstance();
    final dados = prefs.getString(await _chave()) ?? '[]';
    final lista = jsonDecode(dados) as List<dynamic>;
    return lista.map((item) => Consulta.fromMap(Map<String, dynamic>.from(item))).toList();
  }

  static Future<void> adicionar(Consulta consulta) async {
    final itens = await listar();
    itens.add(consulta);
    await _salvar(itens);
  }

  static Future<void> atualizar(Consulta atualizada) async {
    final itens = await listar();
    final i = itens.indexWhere((item) => item.id == atualizada.id);
    if (i != -1) { itens[i] = atualizada; await _salvar(itens); }
  }

  static Future<void> excluir(String id) async {
    final itens = await listar();
    itens.removeWhere((item) => item.id == id);
    await _salvar(itens);
  }

  static Future<void> _salvar(List<Consulta> itens) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(await _chave(), jsonEncode(itens.map((item) => item.toMap()).toList()));
  }
}
