import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Autenticação local apenas para demonstração; não é segura para produção.
class AuthService {
  static const _usuariosKey = 'usuarios';
  static const _logadoKey = 'usuario_logado';

  static Future<String?> cadastrar(String email, String senha) async {
    final prefs = await SharedPreferences.getInstance();
    final usuarios = Map<String, dynamic>.from(jsonDecode(prefs.getString(_usuariosKey) ?? '{}'));
    if (usuarios.containsKey(email)) return 'Este e-mail já está cadastrado.';
    usuarios[email] = senha; // Não armazene senhas assim em um sistema real.
    await prefs.setString(_usuariosKey, jsonEncode(usuarios));
    await prefs.setString(_logadoKey, email);
    return null;
  }

  static Future<String?> entrar(String email, String senha) async {
    final prefs = await SharedPreferences.getInstance();
    final usuarios = Map<String, dynamic>.from(jsonDecode(prefs.getString(_usuariosKey) ?? '{}'));
    if (usuarios[email] != senha) return 'E-mail ou senha incorretos.';
    await prefs.setString(_logadoKey, email);
    return null;
  }

  static Future<void> sair() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_logadoKey);
  }

  static Future<bool> estaLogado() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_logadoKey);
  }

  static Future<String> usuarioAtual() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_logadoKey) ?? 'visitante';
  }
}
