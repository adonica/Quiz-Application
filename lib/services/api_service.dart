import 'dart:convert';
import 'package:quiz_application/screens/home_screen.dart';
import 'package:http/http.dart' as http;

// 'ApiService' class is responsible for communicating data with the API
class ApiService {
  // a private variable that defines the API endpoint (_endpoint is only used inside this class)
  final _endpoint = Uri.parse('https://dad-quiz-api.deno.dev/topics');

  // method of Future that retrieves data from the API
  Future<List<Topic>> getTopic() async {
    // makes an HTTP GET request to the API endpoint and waits for the response
    final response = await http.get(_endpoint);

    // converts the JSON data returned by the API into a List (with elements of type dynamic)
    final List<dynamic> data = jsonDecode(response.body);

    // returns the converted data as a list of Topic objects, using the Topic.fromJson() method
    return data.map((json) => Topic.fromJson(json)).toList();
  }
}
