import 'package:flutter/material.dart';
import 'package:quiz_application/services/answer_service.dart';
import 'package:quiz_application/widgets/back_to_topics_button.dart';
import 'package:quiz_application/widgets/new_question_button.dart';
import 'package:quiz_application/widgets/statistics_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 'AnswerScreen' is a stateless widget, meaning it doesn't have a mutable state
class AnswerScreen extends StatelessWidget {
  final int topicId;
  final int questionId;
  final String selectedAnswer;

  // constructor to initialize topicId, questionId, and selectedAnswer
  const AnswerScreen({
    super.key,
    required this.topicId,
    required this.questionId,
    // this is THE answer chosen by the user
    required this.selectedAnswer,
  });

  @override
  Widget build(BuildContext context) {
    // create an instance of 'AnswerService' to interact with the API (services/answer_service.dart)
    AnswerService answerService = AnswerService(
        topicId: topicId, questionId: questionId, answer: selectedAnswer);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quiz Application'),
        // buttons to navigate to the Home screen the and statistics screens (widgets/back_to_topics_button.dart, widgets/statistics_button.dart)
        actions: const [BackToTopicsButton(), StatisticsButton()],
      ),
      // FutureBuilder is used to fetch and display data from the API
      body: FutureBuilder<Answer>(
        //  use the answerService to send the answer; the FutureBuilder will wait for the result
        future: answerService.postAnswer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // if the Future is waiting, show a loading spinner
            return const Center(child: CircularProgressIndicator());
            // if there is an error, show an error message
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
            // if there is no data returned from the API, show the message
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No data found"));
            // if the data is successfully retrieved
          } else {
            final answer = snapshot.data!;

            if (answer.isCorrect) {
              // if the answer is correct, update the correct answers count in SharedPreferences
              _totalCorrectAnswers();
              return Center(
                child: Column(
                  children: [
                    // add some space between the appBar and text
                    const SizedBox(height: 30.0),
                    const Text(
                      "Your answer was correct!",
                      // align the text to the center of the column
                      textAlign: TextAlign.center,
                      // make the text green to showing better
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    // add some space between text and newQuestion- button
                    const SizedBox(
                      height: 30.0,
                    ),
                    // button for a new question
                    NewQuestionButton(topicId: topicId),
                  ],
                ),
              );
            } else {
              // if the answer was wrong, move back to the previous page with the selected answer
              Navigator.pop(context, selectedAnswer);
              // this does nothing (empty widget), but something needs to return
              return const SizedBox.shrink();
            }
          }
        },
      ),
    );
  }

  // method to handle updating the correct answers count using SharedPreferences
  Future<void> _totalCorrectAnswers() async {
    // initialize shared preferences to store and retrieve data locally
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // get current value of correct answers from shared preferences with the key named 'correctAnswers'
    // if you found nothing, defaul value is 0 (zero)
    int currentCorrectAnswers = prefs.getInt('correctAnswers') ?? 0;
    // add 1 (one) to the value of 'correctAnswers' and store the updated value back to shared preferences
    prefs.setInt('correctAnswers', currentCorrectAnswers + 1);
  }
}

// define the 'Answer' class to represent each Answer from the API
class Answer {
  final bool isCorrect;

  // constructor for creating 'Answer' objects ;)
  Answer({required this.isCorrect});

  // convert JSON data into a 'Answer' object
  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(isCorrect: json['correct']);
  }

  // convert 'Answer' object into JSON data
  Map<String, dynamic> toJson() {
    return {'correct': isCorrect};
  }
}
