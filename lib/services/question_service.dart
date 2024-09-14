import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_application/screens/question_screen.dart';

// 'QuestionService' class is responsible for communicating data with the API
class QuestionService {
  // variable that holds the topic ID to retrieve questions for a specific topic
  final int topicId;

  // constructor for initialization
  QuestionService({required this.topicId});

  // a private variable that defines the API endpoint for fetching questions
  //(_endpoint is only used inside this class)
  Uri get _endpoint =>
      Uri.parse('https://dad-quiz-api.deno.dev/topics/$topicId/questions');

  // a Future method that retrieves data from the API
  Future<Question> getQuestion() async {
    // makes an HTTP GET request to the API endpoint and waits for the response
    final response = await http.get(_endpoint);

    // converts the response body from JSON format into a Dart
    final data = jsonDecode(response.body);

    // returns a 'Question' object by parsing the JSON data using the 'Question.fromJson()' method
    return Question.fromJson(data);
  }
}
