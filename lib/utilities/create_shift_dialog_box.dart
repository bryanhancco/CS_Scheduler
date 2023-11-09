
import 'package:flutter/material.dart';

class CreateTurnoDialogBox extends StatefulWidget {
  final controllerTurnoLetra;
  final controllerTurnoDocente;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String curCod;

  const CreateTurnoDialogBox({
    Key? key,
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
  final _controllerDocentes = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            TextField(
              controller: widget.controllerTurnoLetra,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "A, B, C, D...",
              ),
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
            MaterialButton(
              onPressed: widget.onSave,
              color: const Color.fromRGBO(0, 137, 236, 1),
              child: const Text("Agregar"),
            ),
          ],
        ),
      ),
    );
  }
}