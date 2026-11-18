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
  late Future<List<Consulta>> _consultas;

  @override
  void initState() {
    super.initState();
    _carregarConsultas();
  }

  void _carregarConsultas() {
    _consultas = ConsultaService.listar();
  }

  Future<void> _abrirFormulario([Consulta? consulta]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormularioConsultaScreen(consulta: consulta),
      ),
    );

    setState(_carregarConsultas);
  }

  Future<void> _excluir(String id) async {
    await ConsultaService.excluir(id);
    setState(_carregarConsultas);
  }

  Future<void> _sair() async {
    await AuthService.sair();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (rota) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas consultas'),
        actions: [
          IconButton(
            onPressed: _sair,
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
          ),
        ],
      ),
      body: FutureBuilder<List<Consulta>>(
        future: _consultas,
        builder: (context, resultado) {
          if (!resultado.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final consultas = resultado.data!;

          if (consultas.isEmpty) {
            return const Center(child: Text('Nenhuma consulta cadastrada.'));
          }

          return ListView.builder(
            itemCount: consultas.length,
            itemBuilder: (context, indice) {
              final consulta = consultas[indice];

              return ListTile(
                title: Text(consulta.paciente),
                subtitle: Text(
                  '<LaTex>{consulta.data} às</LaTex>{consulta.horario}\n${consulta.motivo}',
                ),
                isThreeLine: true,
                onTap: () => _abrirFormulario(consulta),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Excluir',
                  onPressed: () => _excluir(consulta.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormulario(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

