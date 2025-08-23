import 'package:flutter/material.dart';

class ALevelPage extends StatelessWidget {
  const ALevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left vertical column (| | |)
            SizedBox(
              width: 200, // Fixed width for left column
              child: ListView(shrinkWrap: true, children: [
               
                ],
              ),
            ),

            const SizedBox(width: 24), // Spacing between columns
            // Center collage (expands to fill space)
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
