import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';
import '../providers/materia_provider.dart';
import '../data/models/sessao_estudo_model.dart';
import '../data/repositories/sessao_estudo_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/materia_selector.dart';
import '../core/theme.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  final _sessaoEstudoRepository = SessaoEstudoRepository();
  late int _ultimoCicloRegistrado;

  @override
  void initState() {
    super.initState();
    final timerProvider = context.read<TimerProvider>();
    _ultimoCicloRegistrado = timerProvider.ciclosDeEstudoConcluidos;
    timerProvider.addListener(_registrarCicloSeConcluido);
  }

  @override
  void dispose() {
    context.read<TimerProvider>().removeListener(_registrarCicloSeConcluido);
    super.dispose();
  }

  void _registrarCicloSeConcluido() {
    final timerProvider = context.read<TimerProvider>();
    if (timerProvider.ciclosDeEstudoConcluidos <= _ultimoCicloRegistrado) return;
    _ultimoCicloRegistrado = timerProvider.ciclosDeEstudoConcluidos;

    final materiaSelecionada = context.read<MateriaProvider>().materiaSelecionada;
    if (materiaSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione uma matéria para registrar a sessão de estudo.'),
        ),
      );
      return;
    }

    _sessaoEstudoRepository.salvarSessao(
      SessaoEstudoModel(
        materiaId: materiaSelecionada.id,
        dataEstudo: DateTime.now(),
        minutosTotais: TimerProvider.estudoMinutos,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    final petroFocusColors = Theme.of(context).extension<PetroFocusColors>()!;

    return Scaffold(
      backgroundColor:
          timerProvider.isBreak ? petroFocusColors.descanso : petroFocusColors.foco,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timerProvider.isBreak ? 'Descanso' : 'Foco Total',
              style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const MateriaSelector(),
            const SizedBox(height: 20),
            Text(
              timerProvider.timerString,
              style: AppTypography.displayTimer,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: timerProvider.toggleTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(timerProvider.isRunning ? 'Pausar' : 'Iniciar',
                             style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: timerProvider.resetTimer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
