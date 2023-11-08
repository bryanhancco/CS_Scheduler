import 'package:flutter/material.dart';

class CreateDialogBox extends StatefulWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const CreateDialogBox(
      {Key? key,
      required this.controller,
      required this.onSave,
      required this.onCancel})
      : super(key: key);
  @override
  _CreateDialogBoxState createState() => _CreateDialogBoxState();
}

class _CreateDialogBoxState extends State<CreateDialogBox> {
  List<String> opciones = ['Obligatorio', 'Selectivo'];
  // This widget is the root of your application.
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
                const Text("Creando Curso..."),
                IconButton(
                    onPressed: widget.onCancel, icon: const Icon(Icons.cancel)),
              ],
            ),
            Text('Nombre el Curso'),
            TextField(
              controller: widget.controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Ingrese el curso",
              ),
            ),
            Text('Categoria'),
            DropdownButton<String>(
                value: opciones[0],
                items: opciones.map((String option) {
                  return DropdownMenuItem(value: option, child: Text(option));
                }).toList(),
                onChanged: (String? value) {
                  print(value);
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
