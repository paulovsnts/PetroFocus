import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.contentMargin),
      child: DropdownButton<MateriaModel>(
        isExpanded: true,
        menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
        value: materiaProvider.materiaSelecionada,
        items: materiaProvider.materias
            .map(
              (materia) => DropdownMenuItem(
                value: materia,
                child: Text(
                  '${materia.nome} (${materia.bloco})',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            )
            .toList(),
        onChanged: (materia) {
          if (materia != null) {
            materiaProvider.selecionarMateria(materia);
          }
        },
      ),
    );
  }
}
