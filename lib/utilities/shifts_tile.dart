import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/utilities/detail_shift.dart';
import 'package:scheduler/database/scheduler_database.dart';

class ShiftsTile extends StatelessWidget {
  final Turno turno;
  List<TurnoHorario> horas = [];

  ShiftsTile({
    super.key,
    required this.turno,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<void> getHoras(String turCod) async {
      horas = await SchedulerDatabase.instance.getCourseHors(turCod);
      print('Saliendo a get AllHoras ' + horas.toString());
    }

    void showInfo() async {
      await getHoras(turno.TurCod);
      showDialog(
        context: context,
        builder: (context) {
          return DetailShiftDialogBox(turno: turno, turnohoras: horas);
        },
      );
    }

    return GestureDetector(
      onTap: showInfo,
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
    );
  }
}
