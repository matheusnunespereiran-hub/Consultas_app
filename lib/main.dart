import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';

void main() => runApp(const MeuApp());

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhas Consultas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), useMaterial3: true),
      // Abre a Home se já houver sessão; caso contrário, mostra o Login.
      home: FutureBuilder<bool>(
        future: AuthService.estaLogado(),
        builder: (context, resultado) {
          if (!resultado.hasData) return const Scaffold(body: Center(child: CircularProgressIndicator()));
          return resultado.data! ? const HomeScreen() : const LoginScreen();
        },
      ),
    );
  }
}
