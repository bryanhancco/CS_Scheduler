import 'package:flutter/material.dart';
import 'package:scheduler/classes/curso.dart';

class CreateDialogBoxTurno extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final Turno turno;
  const CreateDialogBoxTurno({
    Key? key,
    required this.onSave,
    required this.onCancel,
    required this.turno,
  }) : super(key: key);
  @override
  _CreateDialogBoxTurnoState createState() => _CreateDialogBoxTurnoState();
}

class _CreateDialogBoxTurnoState extends State<CreateDialogBoxTurno> {
  final _controllerDocentes = TextEditingController();
  List<String> opciones = ['Obligatorio', 'Selectivo'];
  // ignore: non_constant_identifier_names
  String selectedOption = 'Obligatorio';
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    _controllerDocentes.text = widget.turno.docente;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Container(
        height: 256,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Turno ' + widget.turno.turnoName),
                IconButton(
                    onPressed: widget.onCancel, icon: const Icon(Icons.cancel)),
              ],
            ),
            Text('Docente'),
            TextField(
              controller: _controllerDocentes,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Ingrese el curso",
              ),
            ),
            Text('Categoria'),
            DropdownButton(
                value: selectedOption,
                items: opciones.map((String option) {
                  return DropdownMenuItem<String>(
                      value: option, child: Text(option));
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedOption = value!;
                  });
                }),
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
