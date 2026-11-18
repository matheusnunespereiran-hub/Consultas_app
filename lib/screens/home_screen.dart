import 'package:flutter/material.dart';
import '../models/consulta.dart';
import '../services/auth_service.dart';
import '../services/consulta_service.dart';
import 'formulario_consulta_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Consulta>> consultas;
  @override
  void initState() { super.initState(); carregar(); }
  void carregar() { consultas = ConsultaService.listar(); }

  Future<void> abrirFormulario([Consulta? consulta]) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => FormularioConsultaScreen(consulta: consulta)));
    if (mounted) setState(carregar);
  }

  Future<void> excluir(String id) async {
    await ConsultaService.excluir(id);
    if (mounted) setState(carregar);
  }

  Future<void> sair() async {
    await AuthService.sair();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Minhas consultas'), actions: [IconButton(onPressed: sair, icon: const Icon(Icons.logout), tooltip: 'Sair')]),
    body: FutureBuilder<List<Consulta>>(
      future: consultas,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (snapshot.hasError) return const Center(child: Text('Erro ao carregar consultas.'));
        final lista = snapshot.data ?? [];
        if (lista.isEmpty) return const Center(child: Text('Nenhuma consulta cadastrada. Toque em + para adicionar.'));
        return ListView.builder(itemCount: lista.length, itemBuilder: (context, i) {
          final item = lista[i];
          return ListTile(
            title: Text(item.paciente),
            subtitle: Text('${item.data} às ${item.horario}\n${item.motivo}'),
            isThreeLine: true,
            onTap: () => abrirFormulario(item),
            trailing: IconButton(icon: const Icon(Icons.delete_outline), tooltip: 'Excluir', onPressed: () => excluir(item.id)),
          );
        });
      },
    ),
    floatingActionButton: FloatingActionButton(onPressed: () => abrirFormulario(), child: const Icon(Icons.add)),
  );
}
