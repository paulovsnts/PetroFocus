import 'package:cloud_firestore/cloud_firestore.dart';

class MateriaModel {
  final String id;
  final String nome;
  final String bloco;
  final int enfase;

  MateriaModel({
    required this.id,
    required this.nome,
    required this.bloco,
    required this.enfase,
  });

  factory MateriaModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MateriaModel(
      id: doc.id,
      nome: data['nome'] as String,
      bloco: data['bloco'] as String,
      enfase: data['enfase'] as int,
    );
  }
}
