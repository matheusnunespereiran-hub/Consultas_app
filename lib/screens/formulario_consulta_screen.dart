import 'package:flutter/material.dart';
import '../models/consulta.dart';
import '../services/consulta_service.dart';

class FormularioConsultaScreen extends StatefulWidget {
  final Consulta? consulta;

  const FormularioConsultaScreen({super.key, this.consulta});

  @override
  State<FormularioConsultaScreen> createState() =>
      _FormularioConsultaScreenState();
}

class _FormularioConsultaScreenState
    extends State<FormularioConsultaScreen> {
  final _paciente = TextEditingController();
  final _data = TextEditingController();
  final _horario = TextEditingController();
  final _motivo = TextEditingController();

  @override
  void initState() {
    super.initState();

    final consulta = widget.consulta;
    if (consulta != null) {
      _paciente.text = consulta.paciente;
      _data.text = consulta.data;
      _horario.text = consulta.horario;
      _motivo.text = consulta.motivo;
    }
  }

  Future<void> _salvar() async {
    if (_paciente.text.trim().isEmpty ||
        _data.text.trim().isEmpty ||
        _horario.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha paciente, data e horário.')),
      );
      return;
    }

    final consulta = Consulta(
      id: widget.consulta?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      paciente: _paciente.text.trim(),
      data: _data.text.trim(),
      horario: _horario.text.trim(),
      motivo: _motivo.text.trim(),
    );

    if (widget.consulta == null) {
      await ConsultaService.adicionar(consulta);
    } else {
      await ConsultaService.atualizar(consulta);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _paciente.dispose();
    _data.dispose();
    _horario.dispose();
    _motivo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.consulta != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? 'Editar consulta' : 'Nova consulta'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _paciente,
            decoration: const InputDecoration(labelText: 'Nome do paciente'),
          ),
          TextField(
            controller: _data,
            decoration: const InputDecoration(
              labelText: 'Data (ex.: 20/11/2026)',
            ),
          ),
          TextField(
            controller: _horario,
            decoration: const InputDecoration(
              labelText: 'Horário (ex.: 14:30)',
            ),
          ),
          TextField(
            controller: _motivo,
            decoration: const InputDecoration(labelText: 'Motivo (opcional)'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _salvar,
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}

