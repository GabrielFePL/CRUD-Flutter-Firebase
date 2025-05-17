import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase {
  Future addStudent(Map<String, dynamic> studentData, String studentId) async {
    try {
      return await FirebaseFirestore.instance
          .collection('students')
          .doc(studentId)
          .set(studentData);
    } catch (e) {
      print("Error adding student: $e");
    }
  }

  Stream<QuerySnapshot> getStudents() {
    return FirebaseFirestore.instance.collection('students').snapshots();
  }

  updateAttendance(bool attendance, String studentId) async {
    try {
      return await FirebaseFirestore.instance
          .collection('students')
          .doc(studentId)
          .update({'attendance': attendance});
    } catch (e) {
      print("Error updating attendance: $e");
    }
  }

  deleteStudent(String studentId) async {
    try {
      return await FirebaseFirestore.instance
          .collection('students')
          .doc(studentId)
          .delete();
    } catch (e) {
      print("Error deleting student: $e");
    }
  }
}
