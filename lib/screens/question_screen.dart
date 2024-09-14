import 'package:flutter/material.dart';
import 'package:quiz_application/screens/answer_screen.dart';
import 'package:quiz_application/services/question_service.dart';
import 'package:quiz_application/widgets/back_to_topics_button.dart';
import 'package:quiz_application/widgets/statistics_button.dart';

// 'QuestionScreen' is a stateful widget that displays a question and its answer options
class QuestionScreen extends StatefulWidget {
  final int topicId;
  // constructor that accepts the topicId to fetch questions
  const QuestionScreen({super.key, required this.topicId});

  @override
  // widget's state is stored in a State object
  // 'createState()'- method creates and returns a new State instance
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  //  this variable may be empty or not (?)
  String? wrongAnswer;

  // list of answer options for the current question
  List<String> answerOptions = [];

  // show wrong answer message if needed
  bool showMessage = false;

  // 'late' means that the variable will be initialized later before it is used
  // the current question retrieved from the API
  late Question currentQuestion;

  @override
  Widget build(BuildContext context) {
    // create an instance of 'QuestionService' to fetch data from the API (services/question_service.dart)
    QuestionService questionService = QuestionService(topicId: widget.topicId);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quiz Application'),
        actions: const [
          // navigate buttons to go back to topics and view statistics (widgets/back_to_topics_button.dart, widgets/statistics_button.dart)
          BackToTopicsButton(),
          StatisticsButton(),
        ],
      ),
      // FutureBuilder is used to fetch and display the question data
      body: FutureBuilder<Question>(
        // fetch the random question from the API
        future: questionService.getQuestion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                // if the future is waiting, show loading spinner
                child: CircularProgressIndicator());
            // if there is an error, show an error message
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
            // if the data is successfully retrieved
          } else if (snapshot.hasData) {
            // initialize answer options if they haven't been set yet
            if (answerOptions.isEmpty) {
              currentQuestion = snapshot.data!;
              answerOptions = currentQuestion.options;
            }

            return Padding(
              // add some padding between appBar, text and the screen edges
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  // show the wrong answer- message if necessary
                  if (showMessage)
                    const Text(
                      "Your answer was incorrect. Please try again!",
                      // make the text red to showing better
                      style: TextStyle(color: Colors.red),
                    ),
                  // add some space between message and question
                  const SizedBox(height: 30.0),
                  // display the question text
                  Text(currentQuestion.question),
                  // add  more space between question and answers
                  const SizedBox(
                    height: 40.0,
                  ),

                  // display the answer options excluding the wrong answer (if any)
                  ...answerOptions
                      .where((option) => option != wrongAnswer)
                      .map((option) {
                    // ListTile represent a single item in a list
                    return ListTile(
                      title: Text(
                        option,
                        // put answers to the center of the screen
                        textAlign: TextAlign.center,
                      ),
                      // when the answer is clicked, move to the AnswerScreen to check if the answer is correct
                      onTap: () async {
                        // navigate to the AnswerScreen
                        final getAnswer = await Navigator.push(
                          context,
                          // define the route to the 'AnswerScreen' and pass the topicId, questionId, and selectedAnswer
                          MaterialPageRoute(
                            builder: (context) => AnswerScreen(
                              topicId: widget.topicId,
                              questionId: currentQuestion.id,
                              selectedAnswer: option,
                            ),
                          ),
                        );
                        // if a wrong answer was returned, update the state to reflect the incorrect selection
                        if (getAnswer != null) {
                          setState(() {
                            wrongAnswer = getAnswer;
                            // show the wrong answer- message
                            showMessage = true;
                            // delete the wrong answer from the list
                            answerOptions.remove(getAnswer);
                          });
                        }
                      },
                    );
                  }),
                ],
              ),
            );
          } else {
            // display a message if no data is available
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}

// 'Question' class models the question object with id, question text, and answer options
class Question {
  int id;
  String question;
  List<String> options;

  // constructor to initialize a Question object
  Question({
    required this.id,
    required this.question,
    required this.options,
  });

  // convert JSON data into a 'Question' object
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
    );
  }

  // convert 'Question' object into JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
    };
  }
}
