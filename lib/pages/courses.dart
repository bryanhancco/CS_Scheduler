import 'package:flutter/material.dart';
import 'package:scheduler/pages/home.dart';
import 'package:scheduler/utilities/courses_tile.dart';
import 'package:scheduler/utilities/create_dialog_box.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  final _controller = TextEditingController();

  List coursesList = [
    "Metodos Numericos",
    "Redes",
  ];
  
  void saveNewCourse() {
    setState(() {
      coursesList.add(_controller.text);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewCourse() {
    showDialog(
      context: context, 
      builder: (context) {
        return CreateDialogBox(
          controller: _controller,
          onSave: saveNewCourse,
          onCancel: () => Navigator.of(context).pop(),
        );
    },);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Cursos",
            style: TextStyle(
              color: Color.fromRGBO(0, 137, 236, 1),
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
          
          leading: ElevatedButton(
            child: Icon(Icons.arrow_circle_left_outlined, color: Colors.black,),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          ), 
          
          actions: [
            IconButton(onPressed: createNewCourse,  icon: Icon(Icons.add_circle, color: Colors.black,))
          ],
        ),
        body: ListView.builder(
        itemCount: coursesList.length,
        itemBuilder: (context, index) {
          return CoursesTile(
            courseName: coursesList[index],
          );
        },
      ),
        /*body: Container(
          child: SfCalendar(),
        )*/
      );
  }
}