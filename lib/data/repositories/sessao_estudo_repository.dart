import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sessao_estudo_model.dart';

class SessaoEstudoRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('sessoes_estudo');

  Future<void> salvarSessao(SessaoEstudoModel sessao) {
    return _collection.add(sessao.toMap());
  }

  Stream<List<SessaoEstudoModel>> getUltimasSessoes({int limite = 20}) {
    return _collection
        .orderBy('data_estudo', descending: true)
        .limit(limite)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => SessaoEstudoModel.fromFirestore(doc))
              .toList(),
        );
  }
}
