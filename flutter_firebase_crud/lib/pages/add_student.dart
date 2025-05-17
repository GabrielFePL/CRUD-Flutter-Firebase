import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/services/firestore_database.dart';
import 'package:random_string/random_string.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController studentNameController = TextEditingController();
  TextEditingController studentAgeController = TextEditingController();
  TextEditingController studentRollNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                ),
                SizedBox(width: 120.0),
                Text(
                  "Add ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Student",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              "Student Name: ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFFECECF8),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: studentNameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Student Name",
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Student Age: ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFFECECF8),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: studentAgeController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Student Age",
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Student Roll Number: ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFFECECF8),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: studentRollNumberController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Student Roll Number",
                ),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () async {
                if (studentNameController.text.isEmpty ||
                    studentAgeController.text.isEmpty ||
                    studentRollNumberController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        "Please fill all the fields.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  String studentId = randomAlphaNumeric(20);
                  Map<String, dynamic> studentData = {
                    "name": studentNameController.text,
                    "age": studentAgeController.text,
                    "roll_number": studentRollNumberController.text,
                    "attendance": false,
                  };
                  await FirestoreDatabase()
                      .addStudent(studentData, studentId)
                      .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              "Student data saved successfully.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        studentNameController.clear();
                        studentAgeController.clear();
                        studentRollNumberController.clear();
                      });
                }
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Center(
                  child: Container(
                    width: 128.0,
                    height: 64.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
