import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/materia_model.dart';

class MateriaRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('materias');

  Stream<List<MateriaModel>> getMaterias() {
    return _collection.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => MateriaModel.fromFirestore(doc))
              .toList(),
        );
  }
}
