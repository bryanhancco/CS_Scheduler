import 'package:flutter/material.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/database/firebase_operations.dart';
import 'package:scheduler/database/scheduler_database.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/providers/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scheduler/pages/auth_page.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const AuthPage();
      },
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    List<Curso> items = courseProvider.cursos;
    return Drawer(
      
      child: Column(
        children: [
          Container(
            height: 140, // Ajusta la altura del DrawerHeader
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
          // = List.generate(Curso.ejemplos.length, (index) => true);
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ItemCurso(curso: items[index], i: index);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 1,
              ),
              itemCount: items.length,
            ),
          ),
          EndDrawerButton(
            onPressed: signUserOut,
          ),
        ],
      ),
    );
  }
}

class ItemCurso extends StatefulWidget {
  final Curso curso;
  //final bool initialValue;
  final int i;
  //List<bool> listaValores;
//, required this.listaValores
  ItemCurso({required this.curso, required this.i});

  @override
  _ItemCursoState createState() => _ItemCursoState();
}

class _ItemCursoState extends State<ItemCurso> {
  late int? selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    final shiftProvider = Provider.of<ShiftProvider>(context);
    /*void _changeCheckValue() {
      ShiftProvider.changeCheckValue(widget.i);
    }*/
    final int i = widget.i;
    final Curso curso = widget.curso;
    final List<String> letras = curso.getLetras();
    return ListTile(
      title: Text(curso.CurNom),
      leading: Checkbox(
        value: shiftProvider.getCheckValue(i),
        onChanged: (value) {
          setState(() {
            shiftProvider.changeCheckValue(i);
          });
        },
      ),
      trailing: DropdownButton(
        value: shiftProvider.getShift(i),
        //value: selectedValue,
        onChanged: (newValue) {
          setState(() {
            //selectedValue = newValue;
            //print(curso.CurNom + " - " + selectedValue.toString());
            shiftProvider.changeShift(i, newValue);
          });
        },
        items: List.generate(
          letras.length,
          (index) => DropdownMenuItem<int>(
            value: index,
            child: Text(letras[index]),
          ),
        ),
        elevation: 16,
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
      ),
    );
  }
}
