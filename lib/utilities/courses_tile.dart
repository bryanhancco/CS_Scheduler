import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/pages/detallesCursoPage.dart';
import 'package:scheduler/database/scheduler_database.dart';

class CoursesTile extends StatelessWidget {
  final Curso curso;

  const CoursesTile({
    super.key,
    required this.curso,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Aquí puedes definir la acción que se ejecutará al tocar el elemento de la lista
        // Por ejemplo, navegación a otra página:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return DetallesCursoPage(curCod: curso.CurCod);
          },
        ));
      },
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
                curso.CurNom,
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
