import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              child: ListView(
                shrinkWrap: true,
                children: [
                  _buildVerticalImage('assets/math.png', 'Mathematics'),
                  const SizedBox(height: 16),
                  _buildVerticalImage('assets/physics.png', 'Physics'),
                  const SizedBox(height: 16),
                  _buildVerticalImage('assets/chemistry.png', 'Chemistry'),
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
                children: [
                  _buildCollageItem('assets/biology.png', 'Biology'),
                  _buildCollageItem('assets/economics.png', 'Economics'),
                  _buildCollageItem('assets/history.png', 'History'),
                  _buildCollageItem('assets/geography.png', 'Geography'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalImage(String imagePath, String title) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 120,
              color: Colors.grey[200],
              child: const Icon(Icons.image, size: 40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: GoogleFonts.fredoka(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF002366),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollageItem(String imagePath, String title) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.image, size: 50),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Text(
              title,
              style: GoogleFonts.fredoka(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
