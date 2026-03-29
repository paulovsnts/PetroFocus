import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    return Scaffold(
      backgroundColor: timerProvider.isBreak ? Colors.green[50] : Colors.blue[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timerProvider.isBreak ? 'Descanso' : 'Foco Total',
              style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              timerProvider.timerString,
              style: GoogleFonts.shareTechMono(fontSize: 80, color: Colors.black87),
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