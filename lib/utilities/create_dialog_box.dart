import 'package:flutter/material.dart';

class CreateDialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  CreateDialogBox({
    super.key, 
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Container(
        height: 256,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Creando Curso..."),
                IconButton(onPressed: onCancel, icon: Icon(Icons.cancel)),
              ],
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Ingrese el curso",
              ),
            ),
            MaterialButton(
              onPressed: onSave,
              color: Color.fromRGBO(0, 137, 236, 1),
              child: Text("Agregar"),
            ),
          ],
        ),
      ),
    );
  }
}

