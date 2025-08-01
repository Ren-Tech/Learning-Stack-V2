import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LearningAppBarButtons extends StatelessWidget {
  final Function(String) onMenuSelected;
  final VoidCallback onSearchTap;

  const LearningAppBarButtons({
    super.key,
    required this.onMenuSelected,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search Button
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            splashColor: Colors.yellowAccent.withOpacity(0.3),
            onTap: onSearchTap,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.purpleAccent, Colors.deepPurple],
                ),
              ),
              child: const Icon(Icons.search, size: 24, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Menu Button
        PopupMenuButton<String>(
          color: Colors.white,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.deepOrange],
              ),
            ),
            child: const Icon(Icons.menu, size: 24, color: Colors.white),
          ),
          onSelected: onMenuSelected,
          itemBuilder: (context) {
            final levels = [
              'Pre-School',
              'Primary',
              '11+',
              'GCSEs',
              'A-Levels',
            ];

            return levels.map((level) {
              return PopupMenuItem<String>(
                value: level,
                child: Text(
                  level,
                  style: GoogleFonts.fredoka(
                    fontSize: 18,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}
