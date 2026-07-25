import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../data/models/sessao_estudo_model.dart';
import '../data/repositories/sessao_estudo_repository.dart';

class FechamentoSessaoScreen extends StatefulWidget {
  const FechamentoSessaoScreen({
    super.key,
    required this.materiaId,
    required this.minutosTotais,
  });

  final String materiaId;
  final int minutosTotais;

  @override
  State<FechamentoSessaoScreen> createState() => _FechamentoSessaoScreenState();
}

class _FechamentoSessaoScreenState extends State<FechamentoSessaoScreen> {
  final _sessaoEstudoRepository = SessaoEstudoRepository();
  int _certas = 0;
  int _erradas = 0;
  int _brancas = 0;
  bool _salvando = false;

  int get _notaLiquida => _certas - _erradas;

  Future<void> _salvar() async {
    setState(() => _salvando = true);
    await _sessaoEstudoRepository.salvarSessao(
      SessaoEstudoModel(
        materiaId: widget.materiaId,
        dataEstudo: DateTime.now(),
        minutosTotais: widget.minutosTotais,
        certas: _certas,
        erradas: _erradas,
        brancas: _brancas,
      ),
    );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final petroFocusColors = Theme.of(context).extension<PetroFocusColors>()!;
    final notaCor = _notaLiquida >= 0 ? petroFocusColors.acerto : petroFocusColors.erro;

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.contentMargin,
        right: AppSpacing.contentMargin,
        top: AppSpacing.xl,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Fechamento do ciclo', style: AppTypography.h1),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Registre seu desempenho nas questões deste bloco de estudo.',
            style: AppTypography.bodySecondary,
          ),
          const SizedBox(height: AppSpacing.xl),
          _ContadorQuestao(
            label: 'Certas',
            valor: _certas,
            cor: petroFocusColors.acerto,
            onDecrementar: () => setState(() => _certas = (_certas - 1).clamp(0, 999)),
            onIncrementar: () => setState(() => _certas++),
          ),
          const SizedBox(height: AppSpacing.md),
          _ContadorQuestao(
            label: 'Erradas',
            valor: _erradas,
            cor: petroFocusColors.erro,
            onDecrementar: () => setState(() => _erradas = (_erradas - 1).clamp(0, 999)),
            onIncrementar: () => setState(() => _erradas++),
          ),
          const SizedBox(height: AppSpacing.md),
          _ContadorQuestao(
            label: 'Brancas',
            valor: _brancas,
            cor: petroFocusColors.textTertiary,
            onDecrementar: () => setState(() => _brancas = (_brancas - 1).clamp(0, 999)),
            onIncrementar: () => setState(() => _brancas++),
          ),
          const SizedBox(height: AppSpacing.xl),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.base,
            ),
            decoration: BoxDecoration(
              color: petroFocusColors.surfaceElevated,
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            child: Column(
              children: [
                Text('NOTA LÍQUIDA', style: AppTypography.caption),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _notaLiquida.toString(),
                  style: AppTypography.displayNotaLiquida.copyWith(color: notaCor),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: _salvando ? null : () => Navigator.of(context).pop(),
                  child: const Text('Descartar'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ElevatedButton(
                  onPressed: _salvando ? null : _salvar,
                  child: Text(_salvando ? 'Salvando...' : 'Salvar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContadorQuestao extends StatelessWidget {
  const _ContadorQuestao({
    required this.label,
    required this.valor,
    required this.cor,
    required this.onDecrementar,
    required this.onIncrementar,
  });

  final String label;
  final int valor;
  final Color cor;
  final VoidCallback onDecrementar;
  final VoidCallback onIncrementar;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTypography.body)),
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: onDecrementar,
        ),
        SizedBox(
          width: 32,
          child: Text(
            valor.toString(),
            textAlign: TextAlign.center,
            style: AppTypography.metricNumber.copyWith(color: cor),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: onIncrementar,
        ),
      ],
    );
  }
}
