import 'package:flutter/material.dart';
import 'package:scheduler/classes/curso.dart';
import 'package:scheduler/utilities/create_dialog_box.dart';
import 'package:scheduler/utilities/turnos_tile.dart';

class DetallesCursoPage extends StatefulWidget {
  final Curso curso;
  const DetallesCursoPage({Key? key, required this.curso});

  @override
  State<DetallesCursoPage> createState() => _DetallesCursoPageState();
}

class _DetallesCursoPageState extends State<DetallesCursoPage> {
  final _controller = TextEditingController();
  final _categoria = TextEditingController();
  bool categoria = true;

  List coursesList = Curso.ejemplos;

  void saveNewCourse() {
    setState(() {
      // print('categoria ' + _categoria.text);
      categoria = (_categoria.text == 'Obligatorio') ? true : false;
      Curso curso = Curso.empty(_controller.text, categoria);
      /*print('se creo ruso ' +
          curso.nombre.toString() +
          curso.obligatorio.toString());*/
      coursesList.add(curso);
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
          categoria: _categoria,
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
        title: Text(
          widget.curso.nombre.toString(),
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
          } else {
            return TurnosTile(
              turno: widget.curso.turnos[index],
            );
          }
        },
      ),
      /*body: Container(
          child: SfCalendar(),
        )*/
    );
  }
}
