import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _chaveUsuarios = 'usuarios';
  static const String _chaveLogado = 'usuario_logado';

  static Future<String?> cadastrar(String email, String senha) async {
    final prefs = await SharedPreferences.getInstance();

    final textoSalvo = prefs.getString(_chaveUsuarios) ?? '{}';
    final Map<String, dynamic> usuarios = jsonDecode(textoSalvo);

    if (usuarios.containsKey(email)) {
      return 'Este e-mail já está cadastrado.';
    }

    // Apenas para estudo: não guarde senhas assim em um app real.
    usuarios[email] = senha;

    await prefs.setString(_chaveUsuarios, jsonEncode(usuarios));
    await prefs.setString(_chaveLogado, email);

    return null;
  }

  static Future<String?> entrar(String email, String senha) async {
    final prefs = await SharedPreferences.getInstance();

    final textoSalvo = prefs.getString(_chaveUsuarios) ?? '{}';
    final Map<String, dynamic> usuarios = jsonDecode(textoSalvo);

    if (usuarios[email] != senha) {
      return 'E-mail ou senha incorretos.';
    }

    await prefs.setString(_chaveLogado, email);
    return null;
  }

  static Future<void> sair() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chaveLogado);
  }

  static Future<bool> estaLogado() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_chaveLogado);
  }
}

