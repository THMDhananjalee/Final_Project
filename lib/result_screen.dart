import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'input_screen.dart';

class ResultScreen extends StatefulWidget {
  final double gpa;
  final int totalCredits;
  final String universityName;
  final String studentName;

  const ResultScreen({
    required this.gpa,
    required this.totalCredits,
    required this.universityName,
    required this.studentName,
    Key? key,
  }) : super(key: key);

  @override
  ResultScreenState createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    if (widget.gpa >= 3.5) {
      _confettiController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2C3968), // #2c3968
              Color(0xFF00416A), // #00416A
              Color(0xFF005F69), // #005f69
              Color(0xFF0C2340), // #0C2340
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirectionality: BlastDirectionality.explosive,
                      ),
                      Text(
                        widget.universityName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.studentName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4), // Black transparent background
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 20, // Border width
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Your GPA: ${widget.gpa.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Out of: 4.0',
                              style: const TextStyle(
                                color: Color(0xFFFFF2A6), // Light yellow color
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Total Credits: ${widget.totalCredits}',
                              style: const TextStyle(
                                color: Color(0xFFFFF2A6), // Light yellow color
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (widget.gpa < 2.0)
                              Text(
                                'Mistakes are proof that you\'re trying. Learn, grow, and come back stronger!',
                                style: const TextStyle(
                                  color: Color(0xFFA5D6A7), // Light green color for positive vibe
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2), // Transparent white background
                border: Border.all(color: Colors.white.withOpacity(0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Go Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: _customButtonStyle(),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InputScreen(),
                      ),
                    ),
                    child: const Text(
                      'Calculate Again',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: _customButtonStyle(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle _customButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.black, // Button background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: Color(0xFF15966F), // Stroke color
          width: 2, // Stroke size
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}