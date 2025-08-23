import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/screen_size.dart';

class LeftImageColumn extends StatelessWidget {
  final int currentPageIndex;

  const LeftImageColumn({super.key, required this.currentPageIndex});

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final availableWidth = MediaQuery.of(context).size.width * 0.25;

    // Special case for AI assessment page
    if (currentPageIndex == 6) {
      return SizedBox(
        width: availableWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: availableWidth,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: Icon(
                Icons.psychology,
                size: 60,
                color: Colors.purple.shade400,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Our commitments to Excellence',
              style: GoogleFonts.fredoka(
                fontSize: screenSize == ScreenSize.small ? 14 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Empowering every child to discover the joy of learning & achieve their full potential.',
              style: GoogleFonts.fredoka(
                fontSize: screenSize == ScreenSize.small ? 12 : 16,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      );
    }

    // Page-based content
    switch (currentPageIndex) {
      case 0: // Home Page
        return SizedBox(
          width: availableWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder for removed images
              Container(
                width: availableWidth,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Icon(
                  Icons.school,
                  size: 80,
                  color: Colors.purple.shade300,
                ),
              ),
              const SizedBox(height: 16),

              // Text content
              Text(
                'Our commitments to Excellence',
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 16 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Empowering every child to discover the joy of learning & achieve their full potential.',
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 14 : 16,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '- To inspire and equip children with the skills and confidence to learn effectively & pursue their curiosity.',
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 14 : 16,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '- Guiding children to become confident, lifelong learners who love to explore & grow.',
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 14 : 16,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        );

      case 1: // Primary
        return SizedBox(
          width: availableWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome to Learning',
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                width: availableWidth,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Icon(
                  Icons.book,
                  size: 60,
                  color: Colors.purple.shade300,
                ),
              ),
            ],
          ),
        );

      case 2: // Pre-School
        return SizedBox(
          width: availableWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pre-School Learning',
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                width: availableWidth,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Icon(
                  Icons.child_care,
                  size: 60,
                  color: Colors.purple.shade300,
                ),
              ),
            ],
          ),
        );

      case 3: // 11+
        return SizedBox(
          width: availableWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '11+ Preparation',
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                width: availableWidth,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Icon(
                  Icons.quiz,
                  size: 60,
                  color: Colors.purple.shade300,
                ),
              ),
            ],
          ),
        );

      case 4: // GCSEs
        return SizedBox(
          width: availableWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'GCSE Studies',
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                width: availableWidth,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Icon(
                  Icons.library_books,
                  size: 60,
                  color: Colors.purple.shade300,
                ),
              ),
            ],
          ),
        );

      case 5: // A-Levels
        return SizedBox(
          width: availableWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'A-Level Excellence',
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                width: availableWidth,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Icon(
                  Icons.school,
                  size: 60,
                  color: Colors.purple.shade300,
                ),
              ),
            ],
          ),
        );

      default:
        return SizedBox(
          width: availableWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Educational Excellence',
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                width: availableWidth,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Icon(
                  Icons.menu_book,
                  size: 60,
                  color: Colors.purple.shade300,
                ),
              ),
            ],
          ),
        );
    }
  }
}

class RightImageColumn extends StatefulWidget {
  final int currentPageIndex;
  const RightImageColumn({super.key, required this.currentPageIndex});

  @override
  State<RightImageColumn> createState() => _RightImageColumnState();
}

class _RightImageColumnState extends State<RightImageColumn> {
  String? _hoveredOption;

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final availableWidth = MediaQuery.of(context).size.width * 0.25;

    // Special case for AI assessment page - keep the robot/AI interface
    if (widget.currentPageIndex == 6) {
      return SizedBox(
        width: availableWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Main 3D Circle - Robot Interface
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6E48AA), Color(0xFF9D50BB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.5),
                          blurRadius: 15,
                          spreadRadius: 3,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.android, color: Colors.white, size: 40),
                        const SizedBox(height: 8),
                        Text(
                          'Instant',
                          style: GoogleFonts.fredoka(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Assessment',
                          style: GoogleFonts.fredoka(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Powered by kAI',
                          style: GoogleFonts.fredoka(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // SAT option (top)
                _buildAnimatedOption('SAT', 0, context),
                // 11+ option (right)
                _buildAnimatedOption('11+', 1, context),
                // GCSEs option (bottom)
                _buildAnimatedOption('GCSEs', 2, context),
                // A-Levels option (left)
                _buildAnimatedOption('A-Levels', 3, context),
              ],
            ),
          ],
        ),
      );
    }

    String rightText;

    // Page-based content
    switch (widget.currentPageIndex) {
      case 0:
        rightText = 'Excellence in Education';
        break;
      case 1:
        rightText = 'Educational Resources';
        break;
      case 2:
        rightText = 'Pre-School Materials';
        break;
      case 3:
        rightText = '11+ Exam Papers';
        break;
      case 4:
        rightText = 'GCSE Exam Papers';
        break;
      case 5:
        return SizedBox(
          width: availableWidth,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A-Level Exam Papers & Guides',
                  style: GoogleFonts.fredoka(
                    fontSize: screenSize == ScreenSize.small ? 18 : 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Curated resources to help you excel in your A-Level journey.',
                  style: GoogleFonts.fredoka(
                    fontSize: screenSize == ScreenSize.small ? 14 : 16,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),

                _buildBlogBlockRight(
                  context,
                  title: 'Practice Booklets',
                  description:
                      'Complete booklets for all subjects with step-by-step solutions to help you revise effectively.',
                ),
                _buildBlogBlockRight(
                  context,
                  title: 'Exam Technique Manuals',
                  description:
                      'Guides that teach you how to answer questions with precision, clarity, and speed.',
                  reverse: true,
                ),
              ],
            ),
          ),
        );

      default:
        rightText = 'Excellence in Education';
    }

    return SizedBox(
      width: availableWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              rightText,
              style: GoogleFonts.fredoka(
                fontSize: screenSize == ScreenSize.small ? 14 : 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: availableWidth,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.purple.shade200),
            ),
            child: Icon(Icons.article, size: 80, color: Colors.purple.shade300),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogBlockRight(
    BuildContext context, {
    required String title,
    required String description,
    bool reverse = false,
  }) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final isSmall = screenSize == ScreenSize.small;

    final content = [
      Expanded(
        flex: 1,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.purple.shade200),
          ),
          child: Icon(Icons.menu_book, size: 50, color: Colors.purple.shade300),
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.fredoka(
                fontSize: isSmall ? 16 : 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: GoogleFonts.fredoka(
                fontSize: isSmall ? 14 : 16,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: reverse ? content.reversed.toList() : content,
      ),
    );
  }

  Widget _buildAnimatedOption(
    String label,
    int position,
    BuildContext context,
  ) {
    final colors = [
      Colors.red.shade400,
      Colors.green.shade400,
      Colors.orange.shade400,
      Colors.purple.shade400,
    ];
    final size = 50.0;
    final offset = 100.0;

    return Positioned(
      left: position == 3 ? -offset : null,
      right: position == 1 ? -offset : null,
      top: position == 0 ? -offset : null,
      bottom: position == 2 ? -offset : null,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hoveredOption = label),
        onExit: (_) => setState(() => _hoveredOption = null),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()
            ..translate(0.0, _hoveredOption == label ? -5.0 : 0.0)
            ..scale(_hoveredOption == label ? 1.1 : 1.0),
          child: GestureDetector(
            onTap: () {
              // Handle option tap
            },
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors[position],
                boxShadow: [
                  BoxShadow(
                    color: colors[position].withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  label,
                  style: GoogleFonts.fredoka(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
