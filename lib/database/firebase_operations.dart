import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scheduler/classes/models.dart';

const String db = 'cursos';

Future createCourse({required Curso curso}) async {
  final course = FirebaseFirestore.instance.collection(db);
  await course.doc(curso.CurCod).set(curso.toMap());
}

Future<List> readCourses() async {
  List cursos = [];
  CollectionReference collectionReferenceCursos =
      FirebaseFirestore.instance.collection(db);
  QuerySnapshot queryCursos = await collectionReferenceCursos.get();
  queryCursos.docs.forEach((doc) {
    cursos.add(doc.data());
  });
  //cursos = queryCursos.docs.map((doc) => Curso.fromJson(doc.data() as Map<String, dynamic>)).toList();
  return cursos;
}

Future<void> updateCourse(
    {required String courseId, required Curso curso}) async {
  final course = FirebaseFirestore.instance.collection(db);
  await course.doc(courseId).update(curso.toMap());
}
