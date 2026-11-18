import 'package:flutter/material.dart';
import '../models/consulta.dart';
import '../services/consulta_service.dart';

class FormularioConsultaScreen extends StatefulWidget {
  final Consulta? consulta;
  const FormularioConsultaScreen({super.key, this.consulta});
  @override
  State<FormularioConsultaScreen> createState() => _FormularioConsultaScreenState();
}

class _FormularioConsultaScreenState extends State<FormularioConsultaScreen> {
  final paciente = TextEditingController();
  final data = TextEditingController();
  final horario = TextEditingController();
  final motivo = TextEditingController();

  @override
  void initState() {
    super.initState();
    final item = widget.consulta;
    if (item != null) { paciente.text = item.paciente; data.text = item.data; horario.text = item.horario; motivo.text = item.motivo; }
  }

  Future<void> salvar() async {
    if (paciente.text.trim().isEmpty || data.text.trim().isEmpty || horario.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha paciente, data e horário.')));
      return;
    }
    final item = Consulta(
      id: widget.consulta?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      paciente: paciente.text.trim(), data: data.text.trim(), horario: horario.text.trim(), motivo: motivo.text.trim(),
    );
    if (widget.consulta == null) { await ConsultaService.adicionar(item); }
    else { await ConsultaService.atualizar(item); }
    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() { paciente.dispose(); data.dispose(); horario.dispose(); motivo.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.consulta == null ? 'Nova consulta' : 'Editar consulta')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      TextField(controller: paciente, decoration: const InputDecoration(labelText: 'Nome do paciente')),
      TextField(controller: data, decoration: const InputDecoration(labelText: 'Data (ex.: 20/11/2026)')),
      TextField(controller: horario, decoration: const InputDecoration(labelText: 'Horário (ex.: 14:30)')),
      TextField(controller: motivo, decoration: const InputDecoration(labelText: 'Motivo (opcional)')),
      const SizedBox(height: 20),
      ElevatedButton(onPressed: salvar, child: const Text('Salvar')),
    ]),
  );
}
