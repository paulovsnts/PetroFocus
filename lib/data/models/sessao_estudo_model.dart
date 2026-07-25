import 'package:cloud_firestore/cloud_firestore.dart';

class SessaoEstudoModel {
  final String? id;
  final String materiaId;
  final String topico;
  final DateTime dataEstudo;
  final int minutosTotais;
  final int certas;
  final int erradas;
  final int brancas;

  SessaoEstudoModel({
    this.id,
    required this.materiaId,
    this.topico = '',
    required this.dataEstudo,
    required this.minutosTotais,
    required this.certas,
    required this.erradas,
    required this.brancas,
  });

  int get notaLiquida => certas - erradas;

  int get totalQuestoes => certas + erradas + brancas;

  double get percentualAproveitamento =>
      totalQuestoes == 0 ? 0 : (notaLiquida / totalQuestoes) * 100;

  factory SessaoEstudoModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final questoes = data['questoes'] as Map<String, dynamic>? ?? {};
    return SessaoEstudoModel(
      id: doc.id,
      materiaId: data['materia_id'] as String,
      topico: data['topico'] as String? ?? '',
      dataEstudo: (data['data_estudo'] as Timestamp).toDate(),
      minutosTotais: data['minutos_totais'] as int,
      certas: questoes['certas'] as int? ?? 0,
      erradas: questoes['erradas'] as int? ?? 0,
      brancas: questoes['brancas'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'materia_id': materiaId,
      'topico': topico,
      'data_estudo': Timestamp.fromDate(dataEstudo),
      'minutos_totais': minutosTotais,
      'questoes': {
        'certas': certas,
        'erradas': erradas,
        'brancas': brancas,
        'nota_liquida': notaLiquida,
      },
    };
  }
}
