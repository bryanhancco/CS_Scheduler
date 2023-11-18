import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/providers/provider.dart';

class CreateCourseDialogBox extends StatefulWidget {
  final controllerCourseShortName;
  final controllerCourseName;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final categoria;

  const CreateCourseDialogBox(
      {Key? key,
      required this.controllerCourseShortName,
      required this.controllerCourseName,
      required this.onSave,
      required this.onCancel,
      required this.categoria})
      : super(key: key);
  @override
  _CreateCourseDialogBoxState createState() => _CreateCourseDialogBoxState();
}

class _CreateCourseDialogBoxState extends State<CreateCourseDialogBox> {
  List<String> opciones = ['Obligatorio', 'Electivo'];
  // ignore: non_constant_identifier_names
  String selectedOption = 'Obligatorio';
  // This widget is the root of your application.
  @override
  void initState() {
    widget.categoria.text = 'Obligatorio';
  }

  @override
  Widget build(BuildContext context) {
    final boolProvider = Provider.of<BoolProvider>(context);
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
                const Text(
                  "Creando Curso...",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: widget.onCancel, icon: const Icon(Icons.cancel)),
              ],
            ),
            Text('Codigo del Curso'),
            TextField(
              controller: widget.controllerCourseShortName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Ingrese las iniciales del curso",
              ),
            ),
            Text('Nombre del Curso'),
            TextField(
              controller: widget.controllerCourseName,
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
                  widget.categoria.text = value;
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
