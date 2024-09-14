import 'package:flutter/material.dart';
import 'package:quiz_application/screens/question_screen.dart';

// button for a new question
class NewQuestionButton extends StatelessWidget {
  final int topicId;
  const NewQuestionButton({super.key, required this.topicId});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 177, 240, 193)),
      onPressed: () {
        // when the button is pressed, navigate to the QuestionScreen with MaterialPageRoute
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuestionScreen(
                    topicId: topicId,
                  )),
        );
      },
      // button text
      child: const Text('Take the next question'),
    );
  }
}
