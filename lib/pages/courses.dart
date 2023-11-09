import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/utilities/courses_tile.dart';
import 'package:scheduler/utilities/create_dialog_box.dart';

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

  List coursesList = Curso.ejemplos;

  void saveNewCourse() {
    setState(() {
      // print('categoria ' + _categoria.text);
      categoria = (_controllerCategoria.text == 'Obligatorio') ? 1 : 0;
      Curso curso = Curso.empty(_controllerCourseShortName.text, _controllerCourseName.text, categoria);
      coursesList.add(curso);
      _controllerCourseShortName.clear();
      _controllerCourseName.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewCourse() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateDialogBox(
          controllerCourseShortName: _controllerCourseShortName,
          controllerCourseName: _controllerCourseName,
          onSave: saveNewCourse,
          onCancel: () => Navigator.of(context).pop(),
          categoria: _controllerCategoria,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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

        /*leading: ElevatedButton(
            child: Icon(Icons.arrow_circle_left_outlined, color: Colors.black,),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          ), */

        actions: [
          IconButton(
              onPressed: createNewCourse,
              icon: const Icon(
                Icons.add_circle,
                color: Colors.black,
              ))
        ],
      ),
      body: ListView.builder(
        itemCount: coursesList.length,
        itemBuilder: (context, index) {
          return CoursesTile(
            curso: coursesList[index],
          );
        },
      ),
      /*body: Container(
          child: SfCalendar(),
        )*/
    );
  }
}
