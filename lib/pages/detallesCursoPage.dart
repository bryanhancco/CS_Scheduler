import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/utilities/create_dialog_box.dart';
import 'package:scheduler/utilities/turnos_tile.dart';

class DetallesCursoPage extends StatefulWidget {
  final Curso curso;
  const DetallesCursoPage({super.key, required this.curso});

  @override
  State<DetallesCursoPage> createState() => _DetallesCursoPageState();
}

class _DetallesCursoPageState extends State<DetallesCursoPage> {
  final _controllerCourseCod = TextEditingController();  
  final _controllerCourseName = TextEditingController();
  final _categoria = TextEditingController();
  int categoria = 1;
  /*
  List coursesList = Curso.ejemplos;

  void saveNewCourse() {
    setState(() {
      // print('categoria ' + _categoria.text);
      categoria = (_categoria.text == 'Obligatorio') ? 1 : 0;
      Curso curso = Curso.empty(_controllerCourseCod.text, _controllerCourseName.text, categoria);
      /*print('se creo ruso ' +
          curso.nombre.toString() +
          curso.obligatorio.toString());*/
      coursesList.add(curso);
      _controllerCourseCod.clear();
      _controllerCourseName.clear();
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
          categoria: _categoria,
        );
      },
    );
  }
  */
  @override
  Widget build(BuildContext context) {
    return Placeholder();
    /*
    Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 137, 236, 1),
        title: Text(
          widget.curso.cu.toString(),
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
        itemCount: widget.curso.turnos.length,
        itemBuilder: (context, index) {
          if (widget.curso.turnos.isEmpty) {
            print('esta vacio');
            return const Center(
              child: Text('Aun no tiene turnos este curso'),
            );
          }
          return TurnosTile(
            turno: widget.curso.turnos[index],
          );
        },
      ),
      /*body: Container(
          child: SfCalendar(),
        )*/
    );*/
  }
}
