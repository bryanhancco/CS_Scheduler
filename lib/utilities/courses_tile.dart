import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/pages/detallesCursoPage.dart';
import 'package:scheduler/database/firebase_operations.dart';

class CoursesTile extends StatelessWidget {
  final Curso curso;
  final VoidCallback onDelete;
  final controllerDelete;
  const CoursesTile({
    super.key,
    required this.curso,
    required this.onDelete,
    required this.controllerDelete,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    controllerDelete.text = curso.CurCod;
    return GestureDetector(
      onTap: () {
        // Aquí puedes definir la acción que se ejecutará al tocar el elemento de la lista
        // Por ejemplo, navegación a otra página:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return DetallesCursoPage(curso: curso);
          },
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 18, left: 15, right: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Dismissible(
            key: Key(curso.CurCod),
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
            /*
            confirmDismiss:(direction) async {
              bool result = false;
              result = await showDialog(
                context: context, 
                builder: ((context) {
                  return AlertDialog(
                    title: Text("¿Estás seguro de elminar el curso de ${curso.CurNom}?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          return Navigator.pop(
                            context, false,
                          );
                        }, 
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.red)
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          return Navigator.pop(
                            context, true,
                          );
                        }, 
                        child: const Text("Aceptar")
                      ),
                    ],
                  );
                })
              );
            },
            */
            onDismissed: (direction) {
              onDelete();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${curso.CurNom} ha sido eliminado'),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.green[50],
                border: Border.all(),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Icon(Icons.question_mark_rounded),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      curso.CurNom,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
