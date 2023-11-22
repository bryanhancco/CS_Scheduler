import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/database/scheduler_database.dart';
import 'package:scheduler/utilities/table_input.dart';

class CreateTurnoDialogBox extends StatefulWidget {
  List<int> horasSelec;
  final controllerTurnoLetra;
  final controllerTurnoDocente;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String curCod;

  CreateTurnoDialogBox({
    Key? key,
    required this.horasSelec,
    required this.controllerTurnoLetra,
    required this.controllerTurnoDocente,
    required this.onSave,
    required this.onCancel,
    required this.curCod,
  }) : super(key: key);
  @override
  _CreateTurnoDialogBoxState createState() => _CreateTurnoDialogBoxState();
}

class _CreateTurnoDialogBoxState extends State<CreateTurnoDialogBox> {
  /*final _controllerDocentes = TextEditingController();
  final _dropdownController = TextEditingController();*/
  List<String> options = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController turnocontrol = widget.controllerTurnoLetra;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Container(
        height: 450,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Creando Turno... '),
                IconButton(
                    onPressed: widget.onCancel, icon: const Icon(Icons.cancel)),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Turno:',
              ),
            ),
            /*TextField(
              controller: widget.controllerTurnoLetra,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "A, B, C, D...",
              ),
            ),*/
            DropdownButton(
              value: turnocontrol.text.isNotEmpty ? turnocontrol.text : null,
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  // Actualizamos el valor en el controlador
                  turnocontrol.text = newValue ?? '';
                });
              },
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Docente:',
              ),
            ),
            TextField(
              controller: widget.controllerTurnoDocente,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "El nombre de su profesor",
              ),
            ),
            /*Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hora Inicio:',
              ),
            ),
            DropdownButton(
              value: turnocontrol.text.isNotEmpty ? turnocontrol.text : null,
              items: horas.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  // Actualizamos el valor en el controlador
                  turnocontrol.text = newValue ?? '';
                });
              },
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hora Fin:',
              ),
            ),
            DropdownButton(
              value: turnocontrol.text.isNotEmpty ? turnocontrol.text : null,
              items: horas.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  // Actualizamos el valor en el controlador
                  turnocontrol.text = newValue ?? '';
                });
              },
            ),*/
            Expanded(child: TableInput(horasSelec: widget.horasSelec)),
            MaterialButton(
              onPressed: () {
                // Realizar la validación
                if (widget.controllerTurnoLetra.text == '') {
                  // Ambos campos están llenos, muestra el mensaje de éxito
                  //mostrarSnackBar(context, 'Seleccione un turno');
                  mostrarMensaje(context, 'CAMPO VACIO', 'Seleccione un turno');
                } else {
                  // Muestra un mensaje de error si la validación falla
                  mostrarSnackBar(context, widget.horasSelec.toString());
                  widget.onSave();
                }
              },
              //onPressed: widget.onCancel,
              color: const Color.fromRGBO(0, 137, 236, 1),
              child: const Text("Agregar"),
            ),
          ],
        ),
      ),
    );
  }
}

void mostrarSnackBar(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 2), // Duración del SnackBar
    ),
  );
}

void mostrarMensaje(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cerrar'),
          ),
        ],
      );
    },
  );
}
