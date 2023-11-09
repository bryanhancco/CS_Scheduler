import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/utilities/courses_tile.dart';
import 'package:scheduler/utilities/create_dialog_box.dart';
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
    await SchedulerDatabase.instance.insertCourse(course);
  }
  saveNewCourse() {
    setState(() {
      // print('categoria ' + _categoria.text);
      categoria = (_controllerCategoria.text == 'Obligatorio') ? 1 : 0;
      Curso curso = Curso.empty(_controllerCourseShortName.text, _controllerCourseName.text, categoria);
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
        return CreateDialogBox (
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
      body: FutureBuilder(
        future: SchedulerDatabase.instance.getAllCursos(), 
        builder: (BuildContext context, AsyncSnapshot<List<Curso>> snapshot) {
          if (snapshot.hasData) {
          List<Curso> courses = snapshot.data!;
          return courses.isEmpty 
            ? Center(child: Text("No hay Cursos!", style: TextStyle(fontSize: 20),)) 
            : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return CoursesTile(curso: courses[index]);
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 10,
              ),
              itemCount: courses.length,
            );
          }
          else {
            return const Center(
              child: Text("No se han ingresado cursos!", style: TextStyle(fontSize: 20),),
            );
          }
        }
      ) 
    );
  }
}
