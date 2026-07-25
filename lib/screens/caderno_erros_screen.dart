import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../data/models/sessao_estudo_model.dart';
import '../data/repositories/sessao_estudo_repository.dart';
import '../providers/caderno_erro_provider.dart';
import '../providers/materia_provider.dart';

class CadernoErrosScreen extends StatelessWidget {
  const CadernoErrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CadernoErroProvider>();
    final petroFocusColors = Theme.of(context).extension<PetroFocusColors>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('Caderno de Erros')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.erros.isEmpty
              ? Center(
                  child: Text(
                    'Nenhum erro registrado ainda.',
                    style: AppTypography.bodySecondary,
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.contentMargin),
                  itemCount: provider.erros.length,
                  separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final erro = provider.erros[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.base),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(erro.pergunta, style: AppTypography.h2),
                                ),
                                Checkbox(
                                  value: erro.statusRevisado,
                                  activeColor: petroFocusColors.acerto,
                                  onChanged: (_) =>
                                      context.read<CadernoErroProvider>().alternarRevisado(erro),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text('Erro cometido: ${erro.erroCometido}',
                                style: AppTypography.bodySecondary),
                            const SizedBox(height: AppSpacing.xs),
                            Text(erro.explicacaoTecnica, style: AppTypography.body),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => const _NovoErroForm(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _NovoErroForm extends StatefulWidget {
  const _NovoErroForm();

  @override
  State<_NovoErroForm> createState() => _NovoErroFormState();
}

class _NovoErroFormState extends State<_NovoErroForm> {
  final _sessaoEstudoRepository = SessaoEstudoRepository();
  final _perguntaController = TextEditingController();
  final _erroCometidoController = TextEditingController();
  final _explicacaoController = TextEditingController();
  SessaoEstudoModel? _sessaoSelecionada;
  bool _salvando = false;

  @override
  void dispose() {
    _perguntaController.dispose();
    _erroCometidoController.dispose();
    _explicacaoController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_sessaoSelecionada == null ||
        _perguntaController.text.trim().isEmpty ||
        _erroCometidoController.text.trim().isEmpty ||
        _explicacaoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos e selecione uma sessão.')),
      );
      return;
    }

    setState(() => _salvando = true);
    await context.read<CadernoErroProvider>().adicionarErro(
          sessaoId: _sessaoSelecionada!.id!,
          pergunta: _perguntaController.text.trim(),
          erroCometido: _erroCometidoController.text.trim(),
          explicacaoTecnica: _explicacaoController.text.trim(),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final materias = context.read<MateriaProvider>().materias;

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.contentMargin,
        right: AppSpacing.contentMargin,
        top: AppSpacing.xl,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Novo erro', style: AppTypography.h1),
            const SizedBox(height: AppSpacing.lg),
            StreamBuilder<List<SessaoEstudoModel>>(
              stream: _sessaoEstudoRepository.getUltimasSessoes(),
              builder: (context, snapshot) {
                final sessoes = snapshot.data ?? [];
                return DropdownButtonFormField<SessaoEstudoModel>(
                  initialValue: _sessaoSelecionada,
                  decoration: const InputDecoration(labelText: 'Sessão de estudo'),
                  items: sessoes.map((sessao) {
                    final materiasCorrespondentes = materias
                        .where((materia) => materia.id == sessao.materiaId);
                    final materiaNome = materiasCorrespondentes.isEmpty
                        ? sessao.materiaId
                        : materiasCorrespondentes.first.nome;
                    final data = sessao.dataEstudo;
                    return DropdownMenuItem(
                      value: sessao,
                      child: Text(
                        '$materiaNome — ${data.day.toString().padLeft(2, '0')}/'
                        '${data.month.toString().padLeft(2, '0')} '
                        '${data.hour.toString().padLeft(2, '0')}:${data.minute.toString().padLeft(2, '0')}',
                      ),
                    );
                  }).toList(),
                  onChanged: (sessao) => setState(() => _sessaoSelecionada = sessao),
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _perguntaController,
              decoration: const InputDecoration(labelText: 'Pergunta'),
              maxLines: 2,
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _erroCometidoController,
              decoration: const InputDecoration(labelText: 'Erro cometido'),
              maxLines: 2,
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _explicacaoController,
              decoration: const InputDecoration(labelText: 'Explicação técnica'),
              maxLines: 3,
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton(
              onPressed: _salvando ? null : _salvar,
              child: Text(_salvando ? 'Salvando...' : 'Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
