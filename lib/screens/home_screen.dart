import 'package:flutter/material.dart';
import 'package:quiz_application/screens/question_screen.dart';
import 'package:quiz_application/services/api_service.dart';
import 'package:quiz_application/widgets/statistics_button.dart';

// 'HomeScreen' is a stateless widget, meaning it doesn't have a mutable state
class HomeScreen extends StatelessWidget {
  // keyword 'const' means that object can be created at compile time (compile-time constant)
  // 'super.key' passes the value to the parent class (StatelessWidget) constructor
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // create an instance of 'ApiService' to interact with the API (services/api_service.dart)
    ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quiz Application'),
        actions: const [
          // button to navigate to the statistics screen (widgets/statistics_button.dart)
          StatisticsButton()
        ],
      ),
      // FutureBuilder is used to fetch and display data from the API
      body: FutureBuilder<List<Topic>>(
        future:
            // fetch the topics using the 'ApiService'
            apiService.getTopic(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child:
                  // if the Future is waiting for the data, show a loading spinner
                  CircularProgressIndicator(),
            );
            // if there is an error, show an error message
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
            // if there is no data returned from the API, show the message
          } else if (snapshot.data == null) {
            return const Center(
              child: Text("No topics available"),
            );
          } else {
            // data is available (guaranteed with the '!' operator)
            final topics = snapshot.data!;
            return Padding(
              // add some padding between appBar, text and the screen edges
              padding: const EdgeInsets.all(50.0),
              // display the list of topics
              child: ListView(
                // use 'map' to to transform the list of topics into ListTile widgets
                children: topics.map((topic) {
                  // each ListTile represents a single topic
                  return ListTile(
                    title: Text(
                      topic.name,
                      // align the topic names to the center of the list item
                      textAlign: TextAlign.center,
                    ),
                    // when the topic is clicked, navigate to the 'QuestionScreen'
                    onTap: () {
                      // navigator pushes you there :)
                      Navigator.push(
                        context,
                        // define the route to the 'QuestionScreen' and pass the topic ID
                        MaterialPageRoute(
                          builder: (context) =>
                              QuestionScreen(topicId: topic.id),
                        ),
                      );
                    },
                  );
                  // convert the 'Iterable' of ListTiles into a List
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

// define the 'Topic' class to represent each topic from the API
class Topic {
  int id;
  String name;

  // constructor for creating a 'Topic' object
  Topic({required this.id, required this.name});

  // convert JSON data into a 'Topic' object
  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      name: json['name'],
    );
  }
  // convert 'Topic' object into JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
