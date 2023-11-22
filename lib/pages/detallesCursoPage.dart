import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/database/firebase_operations.dart';
import 'package:scheduler/utilities/create_shift_dialog_box.dart';
import 'package:scheduler/utilities/shifts_tile.dart';
import 'package:scheduler/database/scheduler_database.dart';

class DetallesCursoPage extends StatefulWidget {
  final Curso curso;
  const DetallesCursoPage({super.key, required this.curso});

  @override
  State<DetallesCursoPage> createState() => _DetallesCursoPageState();
}

class _DetallesCursoPageState extends State<DetallesCursoPage> {
  List<int> horas = [];
  final _controllerTurnoLetra = TextEditingController();
  final _controllerTurnoDocente = TextEditingController();

  Future<void> addShift(Turno shift) async {
    //print('A addshift ');
    widget.curso.addShift(shift);
    await updateCourse(courseId: widget.curso.CurCod, curso: widget.curso);
  }

  void saveNewShift() {
    setState(() {
      Turno shift = Turno(
          TurLet: _controllerTurnoLetra.text,
          TurDoc: _controllerTurnoDocente.text,
          horas: [...horas],
          preferido: 1);

      addShift(shift);
      horas.clear();
      _controllerTurnoLetra.clear();
      _controllerTurnoDocente.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewShift() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateTurnoDialogBox(
          horasSelec: horas,
          controllerTurnoLetra: _controllerTurnoLetra,
          controllerTurnoDocente: _controllerTurnoDocente,
          onSave: saveNewShift,
          onCancel: () => Navigator.of(context).pop(),
          curCod: widget.curso.CurCod,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Turno> turnos = widget.curso.CurTur;
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
      body: turnos.isEmpty
          ? Center(
              child: Text(
              "No hay Turnos!",
              style: TextStyle(fontSize: 20),
            ))
          : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ShiftsTile(turno: turnos[index]);
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 5,
              ),
              itemCount: turnos.length,
            ),
    );
  }
}
