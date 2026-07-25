import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  static const int estudoMinutos = 25;
  static const int descansoMinutos = 5;

  Timer? _timer;
  int _secondsRemaining = estudoMinutos * 60;
  bool _isRunning = false;
  bool _isBreak = false;
  int _ciclosDeEstudoConcluidos = 0;

  int get secondsRemaining => _secondsRemaining;
  bool get isRunning => _isRunning;
  bool get isBreak => _isBreak;
  int get ciclosDeEstudoConcluidos => _ciclosDeEstudoConcluidos;

  String get timerString {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          notifyListeners();
        } else {
          _completeCycle();
        }
      });
    }
    _isRunning = !_isRunning;
    notifyListeners();
  }

  void _completeCycle() {
    _timer?.cancel();
    _isRunning = false;
    if (!_isBreak) {
      // Ciclo de estudo concluído, inicia descanso
      _ciclosDeEstudoConcluidos++;
      _isBreak = true;
      _secondsRemaining = descansoMinutos * 60;
    } else {
      // Descanso concluído, volta para o estudo
      _isBreak = false;
      _secondsRemaining = estudoMinutos * 60;
    }
    notifyListeners();
  }

  void resetTimer() {
    _timer?.cancel();
    _isRunning = false;
    _isBreak = false;
    _secondsRemaining = estudoMinutos * 60;
    notifyListeners();
  }
}