import 'package:flutter/material.dart';
import 'caderno_erros_screen.dart';
import 'pomodoro_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _indiceSelecionado = 0;

  static const _telas = [
    PomodoroScreen(),
    CadernoErrosScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _indiceSelecionado, children: _telas),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indiceSelecionado,
        onDestinationSelected: (indice) => setState(() => _indiceSelecionado = indice),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.timer_outlined), label: 'Pomodoro'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'Caderno de Erros'),
        ],
      ),
    );
  }
}
