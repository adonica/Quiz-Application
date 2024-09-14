import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_application/screens/answer_screen.dart';

// 'AnswerService' class is responsible for communicating data with the API
class AnswerService {
  final int topicId;
  final int questionId;
  final String answer;

  // constructor for initializing the service with required parameters
  AnswerService(
      {required this.topicId, required this.questionId, required this.answer});

  // a private variable that defines the API endpoint for submitting answers
  //(_endpoint is only used inside this class)
  Uri get _endpoint => Uri.parse(
      'https://dad-quiz-api.deno.dev/topics/$topicId/questions/$questionId/answers');

  // a Future method to send answer data to the API and retrieve the response
  Future<Answer> postAnswer() async {
    final data = {"answer": answer};

    // makes an HTTP POST request to the API endpoint and waits for the response
    final response = await http.post(
      _endpoint,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      // converts the Dart data into JSON format before sending it
      body: jsonEncode(data),
    );

    // check if the response status is 200(success)
    if (response.statusCode == 200) {
      // returns an 'Answer' object by parsing the JSON data using the 'Answer.fromJson()' method
      return Answer.fromJson(jsonDecode(response.body));
    } else {
      // If the response is not successful, throw an exception
      throw Exception('Failed to load answer');
    }
  }
}
