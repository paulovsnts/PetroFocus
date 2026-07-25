import 'package:cloud_firestore/cloud_firestore.dart';

class SessaoEstudoModel {
  final String materiaId;
  final String topico;
  final DateTime dataEstudo;
  final int minutosTotais;

  SessaoEstudoModel({
    required this.materiaId,
    this.topico = '',
    required this.dataEstudo,
    required this.minutosTotais,
  });

  // 'questoes' é preenchido depois, na tela de fechamento do Pomodoro (Sprint 3).
  Map<String, dynamic> toMap() {
    return {
      'materia_id': materiaId,
      'topico': topico,
      'data_estudo': Timestamp.fromDate(dataEstudo),
      'minutos_totais': minutosTotais,
    };
  }
}
