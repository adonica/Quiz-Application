import 'package:flutter/material.dart';
import 'package:quiz_application/widgets/back_to_topics_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

// StatefulWidget for displaying user statistics, particularly correct answers
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  // creates the mutable state for this widget
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  // tracks the number of correctly answered questions
  // initialized to 0 if no data is found in SharedPreferences
  int _correctAnswers = 0;

  @override
  // this method is used when state is initialized for the first time
  //(called only once when the screen is built)
  void initState() {
    // calls the parent class's initState method to ensure proper state initialization
    super.initState();
    // fetches the correct answer count from shared preferences when the widget is first created
    _amountOfCorrectAnswers();
  }

  // retrieves the number of correct answers from local storage
  void _amountOfCorrectAnswers() async {
    // initialize shared preferences to store and retrieve data locally
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // retrieve the number of correct answers from SharedPreferences, defaulting to 0 if not found
      _correctAnswers = prefs.getInt('correctAnswers') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quiz Application'),
        // button to navigate to the Home screen(widgets/back_to_topics_button.dart)
        actions: const [BackToTopicsButton()],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              // add padding between the app bar and text
              padding: const EdgeInsets.all(50.0),
              // 'RichText' let you highlight specific parts of the text
              child: RichText(
                text: TextSpan(
                  // this text is normal (black)
                  text: "You have ",
                  style: const TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      // highlight the correct answer count in green with a larger font size
                      text: "$_correctAnswers",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 13, 211, 30),
                          fontSize: 18),
                    ),
                    const TextSpan(
                      // this text is normal (black)
                      text: " correctly answered questions. Well done!",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
