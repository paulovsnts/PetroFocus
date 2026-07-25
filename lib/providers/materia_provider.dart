import 'dart:async';
import 'package:flutter/material.dart';
import '../data/models/materia_model.dart';
import '../data/repositories/materia_repository.dart';

class MateriaProvider with ChangeNotifier {
  final MateriaRepository _repository;
  StreamSubscription<List<MateriaModel>>? _subscription;

  List<MateriaModel> _materias = [];
  MateriaModel? _materiaSelecionada;
  bool _isLoading = true;

  MateriaProvider({MateriaRepository? repository})
      : _repository = repository ?? MateriaRepository() {
    _subscription = _repository.getMaterias().listen((materias) {
      _materias = materias;
      _isLoading = false;
      if (_materiaSelecionada == null && materias.isNotEmpty) {
        _materiaSelecionada = materias.first;
      }
      notifyListeners();
    });
  }

  List<MateriaModel> get materias => _materias;
  MateriaModel? get materiaSelecionada => _materiaSelecionada;
  bool get isLoading => _isLoading;

  void selecionarMateria(MateriaModel materia) {
    _materiaSelecionada = materia;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
