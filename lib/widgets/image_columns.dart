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
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 200,
                maxWidth: availableWidth,
              ),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/page6_left.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.purple.shade50,
                      child: Icon(
                        Icons.image,
                        size: 60,
                        color: Colors.purple.shade300,
                      ),
                    ),
                  ),
                ),
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
              // Collage-style image display
              _buildCollageLayout(context, availableWidth),
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
              _buildCollageLayout(context, availableWidth),
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
                'Pre-School Apps',
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildCollageLayout(context, availableWidth),
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
                '11+ Apps',
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildCollageLayout(context, availableWidth),
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
                'GCSE Apps',
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildCollageLayout(context, availableWidth),
            ],
          ),
        );
      case 5: // A-Levels
        final isSmall = screenSize == ScreenSize.small;
        final aLevelImages = [
          'assets/page5_left1.png',
          'assets/page5_left2.png',
          'assets/page5_left3.png',
          'assets/page5_left4.png',
          'assets/page5_center1.png',
          'assets/page5_center2.png',
        ];

        return SizedBox(
          width: availableWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'A-Level Apps',
                style: GoogleFonts.fredoka(
                  fontSize: isSmall ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildCollageLayout(
                context,
                availableWidth,
                images: aLevelImages,
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
                'Our Commitment to Excellence',
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildCollageLayout(context, availableWidth),
            ],
          ),
        );
    }
  }

  Widget _buildCollageLayout(
    BuildContext context,
    double availableWidth, {
    List<String>? images,
  }) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final isSmall = screenSize == ScreenSize.small;

    // Default images if not provided
    final collageImages =
        images ??
        ['assets/page6_left.jpg', 'assets/left_2.png', 'assets/left_3.png'];

    if (isSmall) {
      // Mobile layout - grid view
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
        children: collageImages.map((path) {
          return _buildImageItem(path, context);
        }).toList(),
      );
    } else {
      // Desktop layout - creative collage
      return SizedBox(
        width: availableWidth,
        child: Column(
          children: [
            // First row with one large image
            _buildImageItem(collageImages[0], context, height: 200),
            const SizedBox(height: 16),

            // Second row with two smaller images
            Row(
              children: [
                Expanded(
                  child: _buildImageItem(
                    collageImages.length > 1
                        ? collageImages[1]
                        : collageImages[0],
                    context,
                    height: 150,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildImageItem(
                    collageImages.length > 2
                        ? collageImages[2]
                        : collageImages[0],
                    context,
                    height: 150,
                  ),
                ),
              ],
            ),

            // Third row with staggered layout if more images
            if (collageImages.length > 3) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildImageItem(
                      collageImages[3],
                      context,
                      height: 180,
                    ),
                  ),
                  if (collageImages.length > 4) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: _buildImageItem(
                        collageImages[4],
                        context,
                        height: 180,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      );
    }
  }

  Widget _buildImageItem(
    String imagePath,
    BuildContext context, {
    double? height,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.purple.shade50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          height: height,
          errorBuilder: (context, error, stackTrace) => Container(
            height: height ?? 200,
            color: Colors.purple.shade50,
            child: Icon(Icons.image, size: 50, color: Colors.purple.shade300),
          ),
        ),
      ),
    );
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

    // Special case for AI assessment page
    if (widget.currentPageIndex == 6) {
      return SizedBox(
        width: availableWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Main 3D Circle
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

    String? rightText;
    List<String> rightImagePaths;

    // Page-based content
    switch (widget.currentPageIndex) {
      case 0:
        rightText = 'Excellence in Education';
        rightImagePaths = [
          'assets/right_1.png',
          'assets/right_2.png',
          'assets/right_3.png',
          'assets/right_4.png',
          'assets/amazon.png',
        ];
        break;
      case 1:
        rightText = 'Educational Resources';
        rightImagePaths = [
          'assets/right_1.png',
          'assets/right_2.png',
          'assets/right_3.png',
          'assets/right_4.png',
          'assets/amazon.png',
        ];
        break;
      case 2:
        rightText = 'Pre-School Materials';
        rightImagePaths = [
          'assets/right_1.png',
          'assets/right_2.png',
          'assets/right_3.png',
          'assets/right_4.png',
          'assets/amazon.png',
        ];
        break;
      case 3:
        rightText = '11+ Exam Papers';
        rightImagePaths = [
          'assets/page3_right1.png',
          'assets/page3_right2.png',
          'assets/page3_right3.png',
          'assets/page3_right4.png',
          'assets/page3_right5.png',
          'assets/page3_right6.png',
        ];
        break;
      case 4:
        rightText = 'GCSE Exam Papers';
        rightImagePaths = [
          'assets/page4_right1.png',
          'assets/page4_right2.png',
          'assets/page4_right3.png',
          'assets/page4_right4.png',
          'assets/amazon.png',
        ];
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
                  image: 'assets/page5_right1.png',
                  title: 'Practice Booklets',
                  description:
                      'Complete booklets for all subjects with step-by-step solutions to help you revise effectively.',
                ),
                _buildBlogBlockRight(
                  context,
                  image: 'assets/page5_right2.png',
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
        rightImagePaths = [
          'assets/right_1.png',
          'assets/right_2.png',
          'assets/right_3.png',
          'assets/right_4.png',
          'assets/amazon.png',
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
              rightText,
              style: GoogleFonts.fredoka(
                fontSize: screenSize == ScreenSize.small ? 14 : 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          _buildCollageLayout(context, availableWidth, images: rightImagePaths),
        ],
      ),
    );
  }

  Widget _buildCollageLayout(
    BuildContext context,
    double availableWidth, {
    required List<String> images,
  }) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final isSmall = screenSize == ScreenSize.small;

    if (isSmall) {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
        children: images.map((path) {
          return _buildImageItem(path, context);
        }).toList(),
      );
    } else {
      return Column(
        children: [
          // First row with two images
          Row(
            children: [
              Expanded(child: _buildImageItem(images[0], context, height: 180)),
              const SizedBox(width: 16),
              Expanded(
                child: _buildImageItem(
                  images.length > 1 ? images[1] : images[0],
                  context,
                  height: 180,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Second row with one large image
          _buildImageItem(
            images.length > 2 ? images[2] : images[0],
            context,
            height: 220,
          ),

          // Third row with remaining images if any
          if (images.length > 3) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildImageItem(
                    images.length > 3 ? images[3] : images[0],
                    context,
                    height: 150,
                  ),
                ),
                if (images.length > 4) ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildImageItem(images[4], context, height: 150),
                  ),
                ],
              ],
            ),
          ],
        ],
      );
    }
  }

  Widget _buildBlogBlockRight(
    BuildContext context, {
    required String image,
    required String title,
    required String description,
    bool reverse = false,
  }) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final isSmall = screenSize == ScreenSize.small;

    final content = [
      Expanded(
        flex: 1,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            height: 200,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 200,
              color: Colors.purple.shade50,
              child: Icon(Icons.image, size: 50, color: Colors.purple.shade300),
            ),
          ),
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

  Widget _buildImageItem(
    String imagePath,
    BuildContext context, {
    double? height,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.purple.shade50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          height: height,
          errorBuilder: (context, error, stackTrace) => Container(
            height: height ?? 200,
            color: Colors.purple.shade50,
            child: Icon(Icons.image, size: 50, color: Colors.purple.shade300),
          ),
        ),
      ),
    );
  }
}
