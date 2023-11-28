import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/pages/auth_page.dart';
import 'package:scheduler/providers/provider.dart';
import 'package:scheduler/utilities/calendar.dart';
import 'package:scheduler/utilities/create_shift_dialog_box.dart';
import 'package:scheduler/utilities/drawer_courses.dart';
//import 'package:syncfusion_flutter_calendar/calendar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //final nextfriday = nextFriday(DateTime.now());
  //final nextfriday = nextFriday(DateTime(2023, 11, 6));
  // Simula una función que lleva tiempo
  final user = FirebaseAuth.instance.currentUser;
  late bool _blocked;
  late List<Curso> _cursos;
  
  @override
  void initState() {
    super.initState();
    _blocked = false;
    _cursos = [];
  }

  /* Algoritmo que se encarga de la evaluacion de horarios */

  Future<void> hacerCombinaciones(
      List<int> arregloOriginal, List<int> arregloGenerado, int indice) async {
    //print(arregloGenerado.toString());
    //print(arregloOriginal.toString());
    //Función recursiva que examina cada posible horario
    /*if(max <= 0){
        //Se controla el maximo de horarios
        console.log("Maximo alcanzado");
        return;
    }*/

    if (indice >= arregloOriginal.length) {
      //Si es que el indice que se varia es igual a la longitud es porque ya se modifico
      //todo el arreglo
      //let cruces= evaluarHorario(arregloGenerado);
      bool cruces = evaluarHorario(arregloGenerado);
      //print("Evaluado");
      //Evalua el horario
      //if (cruces[0] == 0 && cruces[1]) {
      if (cruces) {
        //Si es que no tiene cruces y cumple con los turnos restringidos
        //Lo agrega al arreglo de posibles horarios
        PosiblesProvider.addPosible([...arregloGenerado]);
        //max--;
      }
      return;
    }

    for (int i = 0; i <= arregloOriginal[indice]; i++) {
      //Por cada indice prueba las combinaciones posibles
      //print(i);
      arregloGenerado[indice] = i;
      await hacerCombinaciones(
          arregloOriginal, [...arregloGenerado], indice + 1);
    }
  }

  bool evaluarHorario(List<int> turnos) {
    //print(cursos.toString());
    //print(turnos.length.toString() + " - " + cursos.length.toString());
    //print(turnos.toString());
    //turnos = turnos propuestos a evaluar ej [0,1,2,3,0,0] -> Turno A , Turno B, ...
    //Evalua que tan bueno es el horario y si cumple con las restricciones
    List<int> horasllenas =
        []; //Horas que tienen asignadas un curso int[] Horas ocupadas
    int canthoras = 0; // int
    int ncursos = _cursos.length; //Numero de cursos - int
    //print(ncursos);
    //bool boolprof= true; //Si es que los requerimientos de docente (turno) se cumplen
    //boolprof es true por defecto hasta q se demuestre lo contrario
    for (int i = 0; i < ncursos; i++) {
      if (_cursos[i].CurTur.isEmpty) {
        continue;
      }
      int turno = turnos[i]; //El turno del curso i
      List<int> horas = _cursos[i]
          .CurTur[turno]
          .horas; //Las horas del curso i en el turno - int[]
      //let preferencias=cursos[i].preferencias;
      horasllenas
          .addAll([...horas]); //Agrega las horas del curso a las horas llenas
      canthoras += horas.length; //Suma la cantidad de horas necesarias
      if (_cursos[i].CurTur[turno].preferido != 1) {
        return false;
      }
    }
    //let horasunicas= new Set(horasllenas); //Crea un set para que se eliminen las horas repetidas
    //let datos=[canthoras - horasunicas.size, boolprof];
    //print("Evaluando " + horasllenas.toString() + " - " + canthoras.toString());
    bool datos = (canthoras - horasllenas.toSet().length) == 0;
    //print(datos);
    //Halla la diferencia entre las horas necesarias y las horas sin repetirse
    //Si hay menos es porque hay algun cruce
    //al final retorna un arreglo con dos datos
    //datos[0]: Horas de cruce
    //datos[1]: Bool que indica si es que se cumplen los requisitos del turno
    //return datos[0] && datos[1]
    return (datos);
  }

  @override
  Widget build(BuildContext context) {
    final CourseProvider courseProvider = context.read<CourseProvider>();
    final ShiftProvider shiftProvider = context.read<ShiftProvider>();

    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              "HorarioHarmony",
              style: TextStyle(
                color: Color.fromRGBO(0, 137, 236, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            NumberInput(),
            SizedBox(
              width: 80,
              height: 2,
            ),
            IconButton(
              //boton que genera horarios el foquito
              onPressed: //_handleButtonPress,
                  () async {
                //blockProvider.changeValue();
                setState(() {
                  _blocked = true;
                });
                _cursos = [...courseProvider.cursos];
                print("Bloqueado: " + _blocked.toString());
                int n = shiftProvider.turnos.length;
                List<int> arregloGenerado = List<int>.filled(n, 0);
                List<int> turnos =
                    []; //Crea un arreglo donde se almacenara el numero de turnos disponibles por curso
                for (Curso curso in _cursos) {
                  //añade como elemento i al arreglo de turno el numero de turnos -1
                  //si esque hubiese tres turnos se agrega 2
                  turnos.add(curso.CurTur.length - 1);
                }
                PosiblesProvider.deleteAll();

                //print(turnos.toString());
                await hacerCombinaciones(turnos, [...arregloGenerado], 0);
                print("Termino");
                if (PosiblesProvider.getNumPosibles() > 0) {
                  mostrarMensaje(context, 'Horarios Generados',
                      'Se generaron ${PosiblesProvider.getNumPosibles()} posibles horarios, se muestra el primero');
                  shiftProvider.chargeShifts(PosiblesProvider.getPosible(0));
                } else {
                  mostrarMensaje(context, 'Horarios Generados',
                      'No fue posible generar horarios');
                }

                setState(() {
                  _blocked = false;
                });
                //blockProvider.changeValue();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              icon: const Icon(
                Icons.tips_and_updates,
                color: Colors.black,
              ),
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: const CalendarScreen(),
      ),
      if (_blocked) const LoadingOverlay(),
    ]);
  }
}

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class NumberInput extends StatefulWidget {
  @override
  _NumberInputState createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  int _value = 0;
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ShiftProvider shiftProvider = context.read<ShiftProvider>();
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              _value = (_value > 0) ? _value - 1 : 0;
              _textController.text = '$_value';
              if (_value < PosiblesProvider.getNumPosibles()) {
                print("cargando");
                shiftProvider.chargeShifts(PosiblesProvider.getPosible(_value));
              }
            });
          },
        ),
        SizedBox(
          width: 50,
          child: TextField(
            controller: _textController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            textAlign: TextAlign.center,
            onChanged: (value) {
              setState(() {
                _value = int.tryParse(value) ?? 0;
                if (_value < PosiblesProvider.getNumPosibles()) {
                  print("cargando");
                  shiftProvider
                      .chargeShifts(PosiblesProvider.getPosible(_value));
                }
              });
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _value++;
              _textController.text = '$_value';
              if (_value < PosiblesProvider.getNumPosibles()) {
                print("cargando");
                shiftProvider.chargeShifts(PosiblesProvider.getPosible(_value));
              }
            });
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
