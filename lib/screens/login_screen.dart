import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'cadastro_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final senha = TextEditingController();

  Future<void> entrar() async {
    if (email.text.trim().isEmpty || senha.text.isEmpty) { mensagem('Preencha e-mail e senha.'); return; }
    final erro = await AuthService.entrar(email.text.trim(), senha.text);
    if (!mounted) return;
    if (erro != null) { mensagem(erro); return; }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  void mensagem(String texto) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));

  @override
  void dispose() { email.dispose(); senha.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Entrar')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'E-mail')),
      TextField(controller: senha, obscureText: true, decoration: const InputDecoration(labelText: 'Senha')),
      const SizedBox(height: 20),
      ElevatedButton(onPressed: entrar, child: const Text('Entrar')),
      TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CadastroScreen())), child: const Text('Criar uma conta')),
    ])),
  );
}
