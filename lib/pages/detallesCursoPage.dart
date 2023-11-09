import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/utilities/create_dialog_box.dart';
import 'package:scheduler/utilities/turnos_tile.dart';
import 'package:scheduler/database/scheduler_database.dart';

class DetallesCursoPage extends StatefulWidget {
  final String curCod;
  const DetallesCursoPage({super.key, required this.curCod});

  @override
  State<DetallesCursoPage> createState() => _DetallesCursoPageState(curCod: curCod);

}

class _DetallesCursoPageState extends State<DetallesCursoPage> {
  final String curCod;
  final _controllerTurnoLetra = TextEditingController();  
  final _controllerTurnoDocente = TextEditingController();
  _DetallesCursoPageState({required this.curCod});

  void saveNewShift() {
    setState(() {
      // print('categoria ' + _categoria.text);
      Turno shift = Turno.empty(curCod + _controllerTurnoLetra.text, curCod, _controllerTurnoLetra.text, _controllerTurnoDocente.text);
      _controllerTurnoLetra.clear();
      _controllerTurnoDocente.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewShift() {
    showDialog(
      context: context,
      builder: (context) {
        return Placeholder();
        /*
        return CreateDialogBox(
          controller: _controller,
          onSave: saveNewCourse,
          onCancel: () => Navigator.of(context).pop(),
          categoria: _categoria,
        );
        */
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
          "Turnos",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),

        actions: [
          IconButton(
              onPressed: createNewShift,
              icon: const Icon(
                Icons.add_circle,
                color: Colors.black,
              ))
        ],
      ),
      body: FutureBuilder(
        future: SchedulerDatabase.instance.getAllTurnos(curCod), 
        builder: (BuildContext context, AsyncSnapshot<List<Turno>> snapshot) {
          if (snapshot.hasData) {
          List<Turno> turnos = snapshot.data!;
          return turnos.isEmpty 
            ? Center(child: Text("No hay Turnos!", style: TextStyle(fontSize: 20),)) 
            : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Placeholder();
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 10,
              ),
              itemCount: turnos.length,
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
