import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/classes/models.dart';
import 'package:scheduler/database/firebase_operations.dart';
import 'package:scheduler/pages/courses.dart';
import 'package:scheduler/providers/provider.dart';
import 'package:scheduler/utilities/drawer_courses.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';

//String user = FirebaseAuth.instance.currentUser!.email!;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<Curso> cursos = <Curso>[];

  late Future<List> response;
  @override
  void initState() {
    super.initState();
    response = readCourses(FirebaseAuth.instance.currentUser!.email!);
  }

  @override
  Widget build(BuildContext context) {
    final shiftProvider = Provider.of<ShiftProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: response,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && shiftProvider.refreshAll) {
              shiftProvider.setRefreshAll = true;
              cursos.clear();
              snapshot.data?.forEach((data) {
                cursos.add(Curso.fromJson(data));
              });
              //if (shiftProvider.checked.isEmpty) {
              shiftProvider.initShifts(cursos.length);
              //}
              courseProvider.cursos = cursos;
            }
            //print(courseProvider.cursos.length);
            return Scaffold(
              body: SfCalendar(
                view: CalendarView.workWeek,
                initialSelectedDate: DateTime(2023, 12, 12, 12),
                dataSource: CourseDataSource(
                    cursos, shiftProvider.turnos, shiftProvider.checked),
                firstDayOfWeek: 1,
                timeSlotViewSettings: const TimeSlotViewSettings(
                  startHour: 7,
                  endHour: 21,
                  nonWorkingDays: <int>[DateTime.saturday, DateTime.sunday],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return Courses();
            },
          ));
          setState(() {
            response = readCourses(FirebaseAuth.instance.currentUser!.email!);
          });
        },
      ),
    );
  }
}
