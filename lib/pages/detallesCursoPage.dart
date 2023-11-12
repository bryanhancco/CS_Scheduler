import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/utilities/create_shift_dialog_box.dart';
import 'package:scheduler/utilities/shifts_tile.dart';
import 'package:scheduler/database/scheduler_database.dart';

class DetallesCursoPage extends StatefulWidget {
  final String curCod;
  const DetallesCursoPage({super.key, required this.curCod});

  @override
  State<DetallesCursoPage> createState() => _DetallesCursoPageState();
}

class _DetallesCursoPageState extends State<DetallesCursoPage> {
  List<int> horas = [];
  final _controllerTurnoLetra = TextEditingController();
  final _controllerTurnoDocente = TextEditingController();

  Future<void> addShift(Turno shift) async {
    //print('A addshift ');
    await SchedulerDatabase.instance.insertShift(shift);
  }

  Future<void> addShiftsHours(String turCod, List<int> items) async {
    //print('a Addhshifhours');
    await SchedulerDatabase.instance
        .insertShiftsHours(widget.curCod + _controllerTurnoLetra.text, items);
  }

  void saveNewShift() {
    setState(() {
      Turno shift = Turno.empty(
          widget.curCod + _controllerTurnoLetra.text,
          widget.curCod,
          _controllerTurnoLetra.text,
          _controllerTurnoDocente.text);

      addShift(shift);
      addShiftsHours(widget.curCod + _controllerTurnoLetra.text, horas);
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
          curCod: widget.curCod,
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
            future: SchedulerDatabase.instance.getAllTurnos(widget.curCod),
            builder:
                (BuildContext context, AsyncSnapshot<List<Turno>> snapshot) {
              if (snapshot.hasData) {
                List<Turno> turnos = snapshot.data!;
                return turnos.isEmpty
                    ? Center(
                        child: Text(
                        "No hay Turnos!",
                        style: TextStyle(fontSize: 20),
                      ))
                    : ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return ShiftsTile(turno: turnos[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          height: 5,
                        ),
                        itemCount: turnos.length,
                      );
              } else {
                return const Center(
                  child: Text(
                    "No se han ingresado turnos!",
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }
            }));
  }
}
