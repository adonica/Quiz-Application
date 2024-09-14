import 'package:flutter/material.dart';
import 'package:quiz_application/screens/statistics_screen.dart';

// button for statistics
class StatisticsButton extends StatelessWidget {
  const StatisticsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // add some padding between the button and the edge of the page
      padding: const EdgeInsets.only(right: 16.0),
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 243, 238, 238)),
        onPressed: () {
          // when the button is pressed, navigate to the StatisticsScreen with MaterialPageRoute
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StatisticsScreen()),
          );
        },
        // button text
        child: const Text('Statistics'),
      ),
    );
  }
}
