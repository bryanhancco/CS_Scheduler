import 'package:flutter/material.dart';
import 'package:scheduler/classes/curso.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<Curso> items = Curso.ejemplos;
  List<bool> isChecked = List.generate(Curso.ejemplos.length, (index) => true);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 100, // Ajusta la altura del DrawerHeader
            decoration: const BoxDecoration(
              color: Colors.blue, // Color de fondo personalizado
            ),
            child: const DrawerHeader(
              margin: EdgeInsets.all(0), // Sin margen
              padding: EdgeInsets.all(10), // Añade relleno personalizado
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                    width: double.infinity,
                    child: Image(image: AssetImage('assets/LogoHorario.jpg')),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "HorarioHarmony",
                    style: TextStyle(
                      fontSize: 20, // Tamaño de fuente personalizado
                    ),
                  ),
                ],
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.share),
            title: Text("Compartir/Exportar"),
          ),
          for (int index = 0; index < items.length; index++)
            ListTile(
              title: Text(items[index].nombre),
              leading: Checkbox(
                value: isChecked[index],
                onChanged: (value) {
                  setState(() {
                    isChecked[index] = value ?? false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
