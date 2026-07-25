import 'package:cloud_firestore/cloud_firestore.dart';

class CadernoErroModel {
  final String? id;
  final String sessaoId;
  final String pergunta;
  final String erroCometido;
  final String explicacaoTecnica;
  final bool statusRevisado;

  CadernoErroModel({
    this.id,
    required this.sessaoId,
    required this.pergunta,
    required this.erroCometido,
    required this.explicacaoTecnica,
    this.statusRevisado = false,
  });

  factory CadernoErroModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CadernoErroModel(
      id: doc.id,
      sessaoId: data['sessao_id'] as String,
      pergunta: data['pergunta'] as String,
      erroCometido: data['erro_cometido'] as String,
      explicacaoTecnica: data['explicacao_tecnica'] as String,
      statusRevisado: data['status_revisado'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sessao_id': sessaoId,
      'pergunta': pergunta,
      'erro_cometido': erroCometido,
      'explicacao_tecnica': explicacaoTecnica,
      'status_revisado': statusRevisado,
    };
  }
}
