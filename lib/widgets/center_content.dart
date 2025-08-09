import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/screen_size.dart';

class CenterContent extends StatelessWidget {
  final int currentPageIndex;

  const CenterContent({super.key, required this.currentPageIndex});

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final availableWidth = MediaQuery.of(context).size.width * 0.4;

    // Special case for AI assessment page
    if (currentPageIndex == 6) {
      return SizedBox(
        width: availableWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 300,
                maxWidth: availableWidth,
              ),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/page6_center1.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 300,
                      color: Colors.purple.shade50,
                      child: Icon(
                        Icons.image,
                        size: 80,
                        color: Colors.purple.shade300,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 300,
                maxWidth: availableWidth,
              ),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/page6_center2.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 300,
                      color: Colors.purple.shade50,
                      child: Icon(
                        Icons.image,
                        size: 80,
                        color: Colors.purple.shade300,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    String centerText;
    List<String> centerImagePaths;

    // Page-based content
    switch (currentPageIndex) {
      case 0:
        centerText = 'Excellence in Learning Materials';
        centerImagePaths = [
          'assets/page6_center1.png',
          'assets/page6_center2.png',
        ];
        break;
      case 1:
        centerText = 'Learning Adventure Books';
        centerImagePaths = ['assets/book_center.png'];
        break;
      case 2:
        centerText = 'Pre-School Exercise Books';
        centerImagePaths = ['assets/page2_center.png'];
        break;
      case 3:
        centerText = '11+ Exercise Books';
        centerImagePaths = ['assets/page3_center_top.png'];
        break;
      case 4:
        centerText = 'GCSE Exercise Books';
        centerImagePaths = ['assets/page3_center_bottom.png'];
        break;
      case 5:
        centerText = 'A-Level Exercise Books';
        centerImagePaths = [
          'assets/page5_center1.png',
          'assets/page5_center2.png',
          'assets/page5_center3.png',
          'assets/page5_center4.png',
          'assets/page5_center5.png',
        ];
        break;
      default:
        centerText = 'Excellence in Learning Materials';
        centerImagePaths = [
          'assets/page6_center1.png',
          'assets/page6_center2.png',
        ];
    }

    return SizedBox(
      width: availableWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              centerText,
              style: GoogleFonts.fredoka(
                fontSize: screenSize == ScreenSize.small ? 16 : 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            children: centerImagePaths.map((imagePath) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 300,
                    maxWidth: availableWidth,
                  ),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 300,
                          color: Colors.purple.shade50,
                          child: Icon(
                            Icons.menu_book,
                            size: 60,
                            color: Colors.purple.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
