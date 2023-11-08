import 'package:flutter/material.dart';
import 'package:scheduler/classes/curso.dart';
import 'package:scheduler/pages/detallesCursoPage.dart';
import 'package:scheduler/utilities/create_dialog_box.dart';
import 'package:scheduler/utilities/create_dialog_boxTurno.dart';

class TurnosTile extends StatelessWidget {
  final Turno turno;

  const TurnosTile({
    super.key,
    required this.turno,
  });
  void saveDataTurno() {
    print('Aqui se graba y se envia a la BD');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return CreateDialogBoxTurno(
              onSave: saveDataTurno,
              onCancel: () => Navigator.of(context).pop(),
            );
          },
        );
      },
      // Aquí puedes definir la acción que se ejecutará al tocar el elemento de la lista
      // Por ejemplo, navegacturna otra página:
      child: Padding(
        padding: const EdgeInsets.only(top: 18, left: 15, right: 15),
        child: Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              //Icon(Icons.question_mark_rounded),
              const Icon(Icons.question_mark_rounded),
              const SizedBox(
                width: 20,
              ),
              Text(
                turno.turnoName,
                style: const TextStyle(
                  fontSize: 27,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
