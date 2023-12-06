import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/utilities/detail_shift.dart';
import 'package:scheduler/database/scheduler_database.dart';

class ShiftsTile extends StatelessWidget {
  final Turno turno;
  final int index;
  final Function() onDelete;

  ShiftsTile({
    super.key,
    required this.turno,
    required this.index,
    required this.onDelete,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    void showInfo() {
      showDialog(
        context: context,
        builder: (context) {
          return DetailShiftDialogBox(turno: turno);
        },
      );
    }

    List<int> horas = turno.horas;

    return GestureDetector(
        onTap: showInfo,
        child: Padding(
          padding: const EdgeInsets.only(top: 18, left: 15, right: 15),
          child: Dismissible(
            key: Key(turno.TurLet),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            onDismissed: (direction) {
              //controllerDelete.text = curso.;
              onDelete();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${turno.TurLet} ha sido eliminado'),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.question_mark_rounded),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    turno.TurLet,
                    style: const TextStyle(
                      fontSize: 27,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
