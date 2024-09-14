import 'package:flutter/material.dart';
import 'package:quiz_application/screens/home_screen.dart';

// Button for backToTopics
class BackToTopicsButton extends StatelessWidget {
  const BackToTopicsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // add some padding between buttons
      padding: const EdgeInsets.only(right: 16.0),
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 243, 238, 238)),
        onPressed: () {
          // when the button is pressed, navigate to the HomeScreen with MaterialPageRoute
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
        // button text
        child: const Text('Back to the topics'),
      ),
    );
  }
}
