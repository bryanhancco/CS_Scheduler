import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/pages/courses.dart';
import 'package:scheduler/providers/provider.dart';
import 'package:scheduler/utilities/calendar.dart';
import 'package:scheduler/utilities/create_shift_dialog_box.dart';
import 'package:scheduler/utilities/table_scheduler.dart';
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
  @override
  Widget build(BuildContext context) {
    final CourseProvider courseProvider = context.read<CourseProvider>();
    final ShiftProvider shiftProvider = context.read<ShiftProvider>();
    final BlockProvider blockProvider = context.read<BlockProvider>();
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
            ElevatedButton(
              onPressed: () {
                print("Presiono");
                blockProvider.changeValue();
                int n = shiftProvider.turnos.length;
                List<int> arregloGenerado = List<int>.filled(n, 0);
                List<int> turnos =
                    []; //Crea un arreglo donde se almacenara el numero de turnos disponibles por curso
                List<Curso> cursos = courseProvider.cursos;
                cursos.forEach((curso) {
                  //añade como elemento i al arreglo de turno el numero de turnos -1
                  //si esque hubiese tres turnos se agrega 2
                  turnos.add(curso.CurTur.length - 1);
                });
                PosiblesProvider.deleteAll();
                hacerCombinaciones(turnos, arregloGenerado, 0);
                mostrarMensaje(
                    context,
                    'Horarios Generados',
                    'Se generaron ' +
                        PosiblesProvider.getNumPosibles().toString() +
                        ' posibles horarios ' +
                        PosiblesProvider.getPosible(20).toString());
                shiftProvider.chargeShifts(PosiblesProvider.getPosible(20));
                blockProvider.changeValue();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Icon(
                Icons.tips_and_updates,
                color: Colors.black,
              ),
            ),
            //IconButton(onPressed: () {},  icon: Icon(Icons.add_circle, color: Colors.black,))
          ],
        ),
        /*drawer: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  child: Text("HorarioHarmony"),
                ),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text("Compartir/Exportar"),
                ),
              ],
            ),
          ),*/
        drawer: MyDrawer(),
        body: CalendarScreen(),
        /*body: Container(
            child: SfCalendar(
              view: CalendarView.week,
              headerHeight: 0,
              minDate: nextfriday.subtract(Duration(days: 4)),
              /*(now == DateTime.saturday || now == DateTime.sunday)
                  ? DateTime(2023, 11, 13)
                  : DateTime(2023, 11, 6),*/
              maxDate: nextfriday.add(Duration(hours: 22)),
              /*(now == DateTime.saturday || now == DateTime.sunday)
                  ? DateTime(2023, 11, 17)
                  : DateTime(2023, 11, 10),*/
              timeSlotViewSettings: const TimeSlotViewSettings(
                startHour: 6,
                endHour: 22,
                nonWorkingDays: <int>[DateTime.saturday, DateTime.sunday],
                numberOfDaysInView: 5,
              ),
              firstDayOfWeek: 1,
            ),
          )*/
      ),
      if (blockProvider.blocked) LoadingOverlay(),
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

DateTime nextFriday(DateTime fechaActual) {
  // Obtener el día de la semana actual (0 para domingo, 1 para lunes, ..., 6 para sábado)
  int diaSemanaActual = fechaActual.weekday;

  // Calcular la cantidad de días hasta el próximo viernes (considerando que el viernes es el día 5)
  int diasHastaViernes = (5 - diaSemanaActual + 7) % 7;

  // Sumar la cantidad de días calculada a la fecha actual para obtener el próximo viernes
  DateTime proximoViernes = fechaActual.add(Duration(days: diasHastaViernes));
  DateTime fechaRedondeada =
      DateTime(proximoViernes.year, proximoViernes.month, proximoViernes.day);

  return fechaRedondeada;
}

void hacerCombinaciones(
    List<int> arregloOriginal, List<int> arregloGenerado, indice) {
  //Función recursiva que examina cada posible horario
  /*if(max <= 0){
        //Se controla el maximo de horarios
        console.log("Maximo alcanzado");
        return;
    }*/

  if (indice == arregloOriginal.length) {
    //Si es que el indice que se varia es igual a la longitud es porque ya se modifico
    //todo el arreglo
    //let cruces= evaluarHorario(arregloGenerado);
    bool cruces = evaluarHorario(arregloGenerado);
    //Evalua el horario
    //if (cruces[0] == 0 && cruces[1]) {
    if (cruces) {
      //Si es que no tiene cruces y cumple con los turnos restringidos
      //Lo agrega al arreglo de posibles horarios
      PosiblesProvider.addPosible([...arregloGenerado]);
      //max--;
      return;
    }
  }

  for (int i = 0; i <= arregloOriginal[indice]; i++) {
    //Por cada indice prueba las combinaciones posibles
    arregloGenerado[indice] = i;
    hacerCombinaciones(arregloOriginal, arregloGenerado, indice + 1);
  }
}

bool evaluarHorario(List<int> turnos) {
  final CourseProvider courseProvider = CourseProvider();
  List<Curso> cursos = courseProvider.cursos;
  //turnos = turnos propuestos a evaluar ej [0,1,2,3,0,0] -> Turno A , Turno B, ...
  //Evalua que tan bueno es el horario y si cumple con las restricciones
  List<int> horasllenas =
      []; //Horas que tienen asignadas un curso int[] Horas ocupadas
  int canthoras = 0; // int
  int ncursos = cursos.length; //Numero de cursos - int
  //bool boolprof= true; //Si es que los requerimientos de docente (turno) se cumplen
  //boolprof es true por defecto hasta q se demuestre lo contrario
  for (int i = 0; i < ncursos; i++) {
    int turno = turnos[i]; //El turno del curso i
    List<int> horas = cursos[i]
        .CurTur[turno]
        .horas; //Las horas del curso i en el turno - int[]
    //let preferencias=cursos[i].preferencias;
    horasllenas
        .addAll([...horas]); //Agrega las horas del curso a las horas llenas
    canthoras += horas.length; //Suma la cantidad de horas necesarias
    if (cursos[i].CurTur[turno].preferido != 1) {
      return false;
    }
  }
  //let horasunicas= new Set(horasllenas); //Crea un set para que se eliminen las horas repetidas
  //let datos=[canthoras - horasunicas.size, boolprof];
  bool datos = (canthoras - horasllenas.toSet().length) == 0;
  //Halla la diferencia entre las horas necesarias y las horas sin repetirse
  //Si hay menos es porque hay algun cruce
  //al final retorna un arreglo con dos datos
  //datos[0]: Horas de cruce
  //datos[1]: Bool que indica si es que se cumplen los requisitos del turno
  //return datos[0] && datos[1]
  return (datos);
}
