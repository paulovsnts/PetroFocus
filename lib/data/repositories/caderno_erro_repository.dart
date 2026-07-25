import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/caderno_erro_model.dart';

class CadernoErroRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('caderno_erros');

  Stream<List<CadernoErroModel>> getErros() {
    return _collection.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => CadernoErroModel.fromFirestore(doc))
              .toList(),
        );
  }

  Future<void> salvarErro(CadernoErroModel erro) {
    return _collection.add(erro.toMap());
  }

  Future<void> atualizarStatusRevisado(String id, bool revisado) {
    return _collection.doc(id).update({'status_revisado': revisado});
  }
}
