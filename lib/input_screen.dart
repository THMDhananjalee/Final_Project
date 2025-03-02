import 'package:flutter/material.dart';
import 'result_screen.dart';
import 'course_model.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  InputScreenState createState() => InputScreenState();
}

class InputScreenState extends State<InputScreen> {
  final List<Course> _courses = [];
  final _gradeValues = {
    'A+': 4.0, 'A': 4.0, 'A-': 3.7,
    'B+': 3.3, 'B': 3.0, 'B-': 2.7,
    'C+': 2.3, 'C': 2.0, 'C-': 1.7,
    'D+': 1.3, 'D': 1.0, 'E': 0.7, 'F': 0.0
  };

  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _studentController = TextEditingController();

  void _addCourse() {
    setState(() {
      _courses.add(Course('', 1, 'A'));
    });
  }

  void _clearCourses() {
    setState(() {
      _courses.clear();
    });
  }

  void _calculateGPA() {
    double totalPoints = 0;
    int totalCredits = 0;

    for (var course in _courses) {
      totalPoints += _gradeValues[course.grade]! * course.credit;
      totalCredits += course.credit;
    }

    final gpa = totalCredits > 0 ? (totalPoints / totalCredits).toDouble() : 0.0;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          gpa: gpa,
          totalCredits: totalCredits,
          universityName: _universityController.text,
          studentName: _studentController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 0, 94, 102), Color.fromARGB(250, 18, 48, 53),Color.fromARGB(233, 0, 45, 38)], // Dark blue to light blue gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // University Name Field
              TextFormField(
                controller: _universityController,
                style: const TextStyle(
                  color: Colors.white, // White text color
                  fontWeight: FontWeight.bold, // Bold text
                ),
                decoration: InputDecoration(
                  labelText: 'University Name',
                  labelStyle: const TextStyle(
                    color: Colors.white, // White label color
                    fontWeight: FontWeight.bold, // Bold label
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.5)), // White border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.5)), // White border
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // White border when focused
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Student Name Field
              TextFormField(
                controller: _studentController,
                style: const TextStyle(
                  color: Colors.white, // White text color
                  fontWeight: FontWeight.bold, // Bold text
                ),
                decoration: InputDecoration(
                  labelText: 'Student Name',
                  labelStyle: const TextStyle(
                    color: Colors.white, // White label color
                    fontWeight: FontWeight.bold, // Bold label
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.5)), // White border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.5)), // White border
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // White border when focused
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _courses.length,
                  itemBuilder: (context, index) {
                    return _buildCourseRow(index);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _addCourse,
                    style: _customButtonStyle(),
                    child: const Text(
                      'Add Course',
                      style: TextStyle(
                        color: Colors.white, // White text color
                        fontWeight: FontWeight.bold, // Bold text
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _clearCourses,
                    style: _customButtonStyle(),
                    child: const Text(
                      'Clear Courses',
                      style: TextStyle(
                        color: Colors.white, // White text color
                        fontWeight: FontWeight.bold, // Bold text
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _calculateGPA,
                    style: _customButtonStyle(),
                    child: const Text(
                      'Calculate GPA',
                      style: TextStyle(
                        color: Colors.white, // White text color
                        fontWeight: FontWeight.bold, // Bold text
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseRow(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Semi-transparent white background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.5)), // White border
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            // Course Name Field
            Expanded(
              flex: 4, // 40% of the row width
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Course Name',
                  hintStyle: TextStyle(
                    color: Colors.white70, // Light white hint text
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
                style: const TextStyle(
                  color: Colors.white, // White text color
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    _courses[index].name = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 10), // Space between columns
            // Credit Field
            Expanded(
              flex: 2, // 20% of the row width
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Credits',
                  hintStyle: TextStyle(
                    color: Colors.white70, // Light white hint text
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
                style: const TextStyle(
                  color: Colors.white, // White text color
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _courses[index].credit = int.tryParse(value) ?? 0;
                  });
                },
              ),
            ),
            const SizedBox(width: 10), // Space between columns
            // Grade Dropdown
            Expanded(
              flex: 2, // 20% of the row width
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // White background
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: _courses[index].grade,
                  items: _gradeValues.keys.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Colors.black, // Black text color
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _courses[index].grade = value!;
                    });
                  },
                  underline: Container(), // Remove default underline
                  isExpanded: true, // Ensure dropdown takes full width
                ),
              ),
            ),
            const SizedBox(width: 10), // Space between columns
            // Delete Button
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.white, // White icon color
              onPressed: () {
                setState(() {
                  _courses.removeAt(index);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle _customButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Dark blue background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: Color.fromARGB(255, 21, 150, 111), // Orange stroke color
          width: 2, // Stroke size
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}