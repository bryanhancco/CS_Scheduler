import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scheduler/classes/models.dart';

final db = FirebaseFirestore.instance;
final String collectionName = 'Scheduler';

// Funcion para agregar nuevo curso en Firestore
Future createCourse({required Curso curso}) async {
  final course = db.collection(collectionName);
  await course.doc(curso.CurCod).set(curso.toMap());
}

// Funcion para leer todos los cursos de Firestore
Future<List> readCourses(final userEmail) async {
  List cursos = [];
  QuerySnapshot query = await db.collection(collectionName).where("UserEmail", isEqualTo: userEmail).get();
  query.docs.forEach((doc) {
    cursos.add(doc.data());
  });
  return cursos;
}

// Funcion para actualizar un curso en específico de Firestore
Future<void> updateCourse(
    {required String courseId, required Curso curso}) async {
  final course = db.collection(collectionName);
  await course.doc(courseId).update(curso.toMap());
}

Future<void> deleteCourse(String curCod) async {
  await db.collection(collectionName).doc(curCod).delete();
}
