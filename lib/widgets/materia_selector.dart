import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/materia_model.dart';
import '../providers/materia_provider.dart';

class MateriaSelector extends StatelessWidget {
  const MateriaSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final materiaProvider = context.watch<MateriaProvider>();

    if (materiaProvider.isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    if (materiaProvider.materias.isEmpty) {
      return const Text('Nenhuma matéria cadastrada');
    }

    return DropdownButton<MateriaModel>(
      value: materiaProvider.materiaSelecionada,
      items: materiaProvider.materias
          .map(
            (materia) => DropdownMenuItem(
              value: materia,
              child: Text('${materia.nome} (${materia.bloco})'),
            ),
          )
          .toList(),
      onChanged: (materia) {
        if (materia != null) {
          materiaProvider.selecionarMateria(materia);
        }
      },
    );
  }
}
