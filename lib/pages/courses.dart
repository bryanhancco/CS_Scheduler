import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/database/firebase_operations.dart';
import 'package:scheduler/providers/provider.dart';
import 'package:scheduler/utilities/courses_tile.dart';
import 'package:scheduler/utilities/create_course_dialog_box.dart';
import 'package:scheduler/database/scheduler_database.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  final _controllerCourseShortName = TextEditingController();
  final _controllerCourseName = TextEditingController();
  final _controllerCategoria = TextEditingController();
  int categoria = 1;

  Future<void> addCourse(Curso course) async {
    await createCourse(curso: course);
    setState(() {
      response = readCourses();
    });
  }

  saveNewCourse() {
    setState(() {
      categoria = (_controllerCategoria.text == 'Obligatorio') ? 1 : 0;
      Curso curso = Curso.empty(_controllerCourseShortName.text,
          _controllerCourseName.text, categoria);
      addCourse(curso);
      _controllerCourseShortName.clear();
      _controllerCourseName.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewCourse() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateCourseDialogBox(
          controllerCourseShortName: _controllerCourseShortName,
          controllerCourseName: _controllerCourseName,
          onSave: saveNewCourse,
          onCancel: () => Navigator.of(context).pop(),
          categoria: _controllerCategoria,
        );
      },
    );
  }

  List<Curso> cursos = <Curso>[];

  late Future<List> response;
  @override
  void initState() {
    super.initState();
    response = readCourses();
  }

  @override
  Widget build(BuildContext context) {
    final shiftProvider = Provider.of<ShiftProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context);
    List<Curso> cursosAnt = [...courseProvider.cursos];
    int i = 0;
    bool insert = false;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 137, 236, 1),
          title: const Text(
            "Cursos",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
          actions: [
            IconButton(
                onPressed: createNewCourse,
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.black,
                ))
          ],
        ),
        body: FutureBuilder(
            future: response,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  cursos.clear();
                  cursosAnt.add(Curso.empty('', '', 1));
                  for (var data in snapshot.data!) {
                    print(i.toString());
                    cursos.add(Curso.fromJson(data));
                    if (cursos.last.CurCod != cursosAnt[i].CurCod && !insert) {
                      print("Es diferente " + i.toString());
                      shiftProvider.addItem(i);
                      insert = !insert;
                      i--;
                    }
                    i++;
                  }
                  courseProvider.cursos = cursos;
                  /*snapshot.data?.forEach((data) {
                    cursos.add(Curso.fromJson(data));
                    if(cursos.last.CurCod != 0){
                      break;
                    }
                  });*/
                  print(shiftProvider.checked.length);
                  print(shiftProvider.turnos.length);
                  return cursos.isEmpty
                      ? const Center(
                          child: Text(
                          "No se han ingresado cursos!",
                          style: TextStyle(fontSize: 20),
                        ))
                      : ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return CoursesTile(curso: cursos[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            height: 5,
                          ),
                          itemCount: cursos.length,
                        );
                } else {
                  return const Center(
                    child: Text(
                      "No se han ingresado cursos!",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
