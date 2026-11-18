import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});
  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final email = TextEditingController();
  final senha = TextEditingController();

  Future<void> cadastrar() async {
    if (email.text.trim().isEmpty || senha.text.isEmpty) { mensagem('Preencha todos os campos.'); return; }
    final erro = await AuthService.cadastrar(email.text.trim(), senha.text);
    if (!mounted) return;
    if (erro != null) { mensagem(erro); return; }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (_) => false);
  }

  void mensagem(String texto) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  @override
  void dispose() { email.dispose(); senha.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Criar conta')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'E-mail')),
      TextField(controller: senha, obscureText: true, decoration: const InputDecoration(labelText: 'Senha (mínimo 6 caracteres)')),
      const SizedBox(height: 20),
      ElevatedButton(onPressed: cadastrar, child: const Text('Cadastrar')),
    ])),
  );
}
