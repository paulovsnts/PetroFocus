import 'dart:async';
import 'package:flutter/material.dart';
import '../data/models/caderno_erro_model.dart';
import '../data/repositories/caderno_erro_repository.dart';

class CadernoErroProvider with ChangeNotifier {
  final CadernoErroRepository _repository;
  StreamSubscription<List<CadernoErroModel>>? _subscription;

  List<CadernoErroModel> _erros = [];
  bool _isLoading = true;

  CadernoErroProvider({CadernoErroRepository? repository})
      : _repository = repository ?? CadernoErroRepository() {
    _subscription = _repository.getErros().listen((erros) {
      _erros = erros;
      _isLoading = false;
      notifyListeners();
    });
  }

  List<CadernoErroModel> get erros => _erros;
  bool get isLoading => _isLoading;

  Future<void> adicionarErro({
    required String sessaoId,
    required String pergunta,
    required String erroCometido,
    required String explicacaoTecnica,
  }) {
    return _repository.salvarErro(
      CadernoErroModel(
        sessaoId: sessaoId,
        pergunta: pergunta,
        erroCometido: erroCometido,
        explicacaoTecnica: explicacaoTecnica,
      ),
    );
  }

  Future<void> alternarRevisado(CadernoErroModel erro) {
    return _repository.atualizarStatusRevisado(erro.id!, !erro.statusRevisado);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
