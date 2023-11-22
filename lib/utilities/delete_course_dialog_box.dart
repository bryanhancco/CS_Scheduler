import 'package:flutter/material.dart';

class DeleteCourseDialogBox extends StatefulWidget {
  final controllerDelete;
  final onDelete;
  final onCancel;

  const DeleteCourseDialogBox(
      {Key? key,
      required this.controllerDelete,
      required this.onDelete,
      required this.onCancel,
      }) : super(key: key);
  @override
  _DeleteCourseDialogBoxState createState() => _DeleteCourseDialogBoxState();
}

class _DeleteCourseDialogBoxState extends State<DeleteCourseDialogBox> {
  // This widget is the root of your application. 
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("¿Estás seguro de elminar el curso de ${widget.controllerDelete.text}?"),
      actions: [
        TextButton(
          onPressed: widget.onCancel,
          child: const Text(
            "Cancelar",
            style: TextStyle(color: Colors.red)
          ),
        ),
        TextButton(
          onPressed: widget.onDelete,
          child: const Text("Aceptar")
        ),
      ],
    );
  }
}
