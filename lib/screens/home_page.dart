import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/info_button.dart';
import '../widgets/image_columns.dart';
import '../widgets/center_content.dart';
import '../models/page_data.dart';
import '../models/screen_size.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int? _hoveredIndex;
  bool _showInfoList = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _heightAnimation;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _heightAnimation = Tween<double>(begin: 80.0, end: 320.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    setState(() => _showInfoList = true);
    _animationController.forward();
  }

  void _reverseAnimation() {
    _animationController.reverse().then((_) {
      setState(() => _showInfoList = false);
    });
  }

  void _changePage(int pageIndex) {
    setState(() {
      _currentPageIndex = pageIndex;
    });
  }

  // Enhanced responsive calculations with NaN protection
  double _getResponsiveValue({
    required BuildContext context,
    required double small,
    required double medium,
    required double large,
    double? extraLarge,
  }) {
    final width = MediaQuery.of(context).size.width;

    // Protect against invalid values
    if (!width.isFinite || width <= 0) return small;

    if (width <= 480) return small;
    if (width <= 768) {
      final ratio = ((width - 480) / (768 - 480)).clamp(0.0, 1.0);
      final result = small + (medium - small) * ratio;
      return result.isFinite ? result : small;
    }
    if (width <= 1024) {
      final ratio = ((width - 768) / (1024 - 768)).clamp(0.0, 1.0);
      final result = medium + (large - medium) * ratio;
      return result.isFinite ? result : medium;
    }
    if (extraLarge != null && width > 1200) {
      final ratio = ((width - 1024) / 400).clamp(0.0, 1.0);
      final result = large + (extraLarge - large) * ratio;
      return result.isFinite ? result : large;
    }
    return large;
  }

  double _getScreenWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width.isFinite && width > 0
        ? width
        : 320.0; // Fallback to minimum mobile width
  }

  double _getScreenHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return height.isFinite && height > 0
        ? height
        : 568.0; // Fallback to minimum mobile height
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = _getScreenWidth(context);
    final screenHeight = _getScreenHeight(context);

    // More granular responsive sizing
    final ninjaSize = _getResponsiveValue(
      context: context,
      small: 140.0,
      medium: 200.0,
      large: 280.0,
      extraLarge: 320.0,
    );

    final ninjaBottom = _getResponsiveValue(
      context: context,
      small: screenHeight < 600 ? -50.0 : -70.0,
      medium: -90.0,
      large: -110.0,
      extraLarge: -120.0,
    );

    final infoButtonRight = _getResponsiveValue(
      context: context,
      small: 16.0,
      medium: screenWidth * 0.08,
      large: screenWidth * 0.06,
      extraLarge: 90.0,
    );

    final infoButtonBottom = screenWidth <= 480 ? 16.0 : 0.0;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          currentPageIndex: _currentPageIndex,
          onPageChanged: _changePage,
        ),
      ),
      body: Column(
        children: [
          _buildAnimatedTextBar(context),
          Expanded(
            child: Stack(
              children: [
                _buildResponsiveContent(context),
                Positioned(
                  bottom: ninjaBottom,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(
                          'assets/ninja.png',
                          height: ninjaSize,
                          width: ninjaSize,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.school,
                            size: ninjaSize * 0.2,
                            color: Colors.white,
                          ),
                        ),
                        // Enhanced responsive speech bubble
                        _buildResponsiveSpeechBubble(context, ninjaSize),
                        // Enhanced responsive speech bubble tail
                        _buildResponsiveSpeechBubbleTail(context, ninjaSize),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: infoButtonRight,
                  bottom: infoButtonBottom,
                  child: JellyInfoButton(
                    showInfoList: _showInfoList,
                    animationController: _animationController,
                    scaleAnimation: _scaleAnimation,
                    heightAnimation: _heightAnimation,
                    onStartAnimation: _startAnimation,
                    onReverseAnimation: _reverseAnimation,
                    currentPageIndex: _currentPageIndex,
                    onPageSelected: (pageIndex) {
                      _changePage(pageIndex);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        hoveredIndex: _hoveredIndex,
        onHover: (index) => setState(() => _hoveredIndex = index),
      ),
    );
  }

  Widget _buildResponsiveSpeechBubble(BuildContext context, double ninjaSize) {
    final screenWidth = _getScreenWidth(context);

    // Adaptive positioning based on screen size and ninja size
    final bubbleRight = screenWidth <= 480
        ? -80.0
        : screenWidth <= 768
        ? -100.0
        : -120.0;

    final bubbleTop = ninjaSize < 200
        ? 30.0
        : ninjaSize < 280
        ? 40.0
        : 45.0;

    return Positioned(
      right: bubbleRight,
      top: bubbleTop,
      child: SpeechBubble(
        text: 'Our knowledge\nteam are always ready\nto help!',
        screenWidth: screenWidth,
      ),
    );
  }

  Widget _buildResponsiveSpeechBubbleTail(
    BuildContext context,
    double ninjaSize,
  ) {
    final screenWidth = _getScreenWidth(context);

    final tailRight = screenWidth <= 480
        ? -30.0
        : screenWidth <= 768
        ? -35.0
        : -40.0;

    final tailTop = ninjaSize < 200
        ? 50.0
        : ninjaSize < 280
        ? 60.0
        : 65.0;

    final tailSize = Size(
      screenWidth <= 480 ? 25.0 : 30.0,
      screenWidth <= 480 ? 15.0 : 20.0,
    );

    return Positioned(
      right: tailRight,
      top: tailTop,
      child: CustomPaint(size: tailSize, painter: _SpeechBubbleTailPainter()),
    );
  }

  Widget _buildAnimatedTextBar(BuildContext context) {
    final screenWidth = _getScreenWidth(context);

    final barHeight = _getResponsiveValue(
      context: context,
      small: 36.0,
      medium: 40.0,
      large: 48.0,
      extraLarge: 52.0,
    );

    final horizontalPadding = _getResponsiveValue(
      context: context,
      small: 12.0,
      medium: 16.0,
      large: 24.0,
      extraLarge: 32.0,
    );

    // Enhanced breakpoint for layout switching
    final useSmallLayout = screenWidth <= 600;

    return Container(
      height: barHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 13, 109, 18),
            const Color.fromARGB(255, 13, 109, 18),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: useSmallLayout
          ? Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: PageData.pageTexts[_currentPageIndex].map((text) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        text,
                        style: GoogleFonts.fredoka(
                          color: Colors.white,
                          fontSize: _getResponsiveValue(
                            context: context,
                            small: 11.0,
                            medium: 13.0,
                            large: 16.0,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          : Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    PageData.pageNames[_currentPageIndex],
                    style: GoogleFonts.fredoka(
                      color: Colors.white,
                      fontSize: _getResponsiveValue(
                        context: context,
                        small: 18.0,
                        medium: 20.0,
                        large: 24.0,
                        extraLarge: 28.0,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 3,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: PageData.pageTexts[_currentPageIndex].map((
                        text,
                      ) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth <= 768 ? 8.0 : 12.0,
                          ),
                          child: Text(
                            text,
                            style: GoogleFonts.fredoka(
                              color: Colors.white,
                              fontSize: _getResponsiveValue(
                                context: context,
                                small: 14.0,
                                medium: 16.0,
                                large: 18.0,
                                extraLarge: 20.0,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildResponsiveContent(BuildContext context) {
    final screenWidth = _getScreenWidth(context);

    final horizontalPadding = _getResponsiveValue(
      context: context,
      small: 16.0,
      medium: 24.0,
      large: 32.0,
      extraLarge: 40.0,
    );

    final verticalPadding = _getResponsiveValue(
      context: context,
      small: 16.0,
      medium: 20.0,
      large: 24.0,
      extraLarge: 28.0,
    );

    final maxWidth = screenWidth <= 768
        ? double.infinity
        : _getResponsiveValue(
            context: context,
            small: 1200.0,
            medium: 1400.0,
            large: 1600.0,
          ).clamp(1200.0, 1600.0); // Ensure valid range

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth.isFinite ? maxWidth : double.infinity,
          ),
          child: _buildAdaptiveLayout(context, screenWidth),
        ),
      ),
    );
  }

  Widget _buildAdaptiveLayout(BuildContext context, double screenWidth) {
    final spacingBetweenElements = _getResponsiveValue(
      context: context,
      small: 16.0,
      medium: 20.0,
      large: 24.0,
      extraLarge: 28.0,
    );

    final bottomSpacing = _getResponsiveValue(
      context: context,
      small: 60.0,
      medium: 80.0,
      large: 100.0,
      extraLarge: 120.0,
    );

    // Mobile layout (portrait phones and small screens)
    if (screenWidth <= 480) {
      return _buildMobileLayout(spacingBetweenElements, bottomSpacing);
    }
    // Tablet portrait layout
    else if (screenWidth <= 768) {
      return _buildTabletLayout(spacingBetweenElements, bottomSpacing);
    }
    // Desktop layout
    else {
      return _buildDesktopLayout(spacingBetweenElements, bottomSpacing);
    }
  }

  Widget _buildMobileLayout(double spacing, double bottomSpacing) {
    return Column(
      children: [
        // Center content at top on mobile
        CenterContent(currentPageIndex: _currentPageIndex),
        SizedBox(height: spacing),

        // Single column for images on mobile
        _buildMobileImageGrid(),
        SizedBox(height: bottomSpacing),
      ],
    );
  }

  Widget _buildTabletLayout(double spacing, double bottomSpacing) {
    return Column(
      children: [
        // Center content at top
        CenterContent(currentPageIndex: _currentPageIndex),
        SizedBox(height: spacing),

        // Two-column layout for tablets
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: LeftImageColumn(currentPageIndex: _currentPageIndex),
            ),
            SizedBox(width: spacing),
            Expanded(
              child: RightImageColumn(currentPageIndex: _currentPageIndex),
            ),
          ],
        ),
        SizedBox(height: bottomSpacing),
      ],
    );
  }

  Widget _buildDesktopLayout(double spacing, double bottomSpacing) {
    final screenWidth = _getScreenWidth(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: screenWidth <= 1024 ? 2 : 3,
          child: LeftImageColumn(currentPageIndex: _currentPageIndex),
        ),
        SizedBox(width: spacing),
        Expanded(
          flex: screenWidth <= 1024 ? 3 : 4,
          child: CenterContent(currentPageIndex: _currentPageIndex),
        ),
        SizedBox(width: spacing),
        Expanded(
          flex: screenWidth <= 1024 ? 2 : 3,
          child: RightImageColumn(currentPageIndex: _currentPageIndex),
        ),
      ],
    );
  }

  Widget _buildMobileImageGrid() {
    return Column(
      children: [
        // Create a responsive grid for mobile
        _buildResponsiveImageGrid(),
      ],
    );
  }

  Widget _buildResponsiveImageGrid() {
    final screenWidth = _getScreenWidth(context);

    // For A-levels, create a structured grid layout
    if (_currentPageIndex == 0) {
      // Assuming A-levels is index 0
      return _buildALevelsGrid(screenWidth);
    }

    // Default layout for other pages
    return Column(
      children: [
        LeftImageColumn(currentPageIndex: _currentPageIndex),
        SizedBox(height: 16),
        RightImageColumn(currentPageIndex: _currentPageIndex),
      ],
    );
  }

  Widget _buildALevelsGrid(double screenWidth) {
    final crossAxisCount = screenWidth <= 480
        ? 1
        : screenWidth <= 768
        ? 2
        : 3;
    final childAspectRatio = screenWidth <= 480 ? 1.2 : 1.0;

    // Sample A-levels subjects - replace with your actual data
    final aLevelsSubjects = [
      {
        'title': 'Mathematics',
        'image': 'assets/math.png',
        'description': 'Advanced Mathematics',
      },
      {
        'title': 'Physics',
        'image': 'assets/physics.png',
        'description': 'Physics Fundamentals',
      },
      {
        'title': 'Chemistry',
        'image': 'assets/chemistry.png',
        'description': 'Chemical Sciences',
      },
      {
        'title': 'Biology',
        'image': 'assets/biology.png',
        'description': 'Life Sciences',
      },
      {
        'title': 'Economics',
        'image': 'assets/economics.png',
        'description': 'Economic Principles',
      },
      {
        'title': 'Business',
        'image': 'assets/business.png',
        'description': 'Business Studies',
      },
      {
        'title': 'Psychology',
        'image': 'assets/psychology.png',
        'description': 'Human Psychology',
      },
      {
        'title': 'Geography',
        'image': 'assets/geography.png',
        'description': 'Physical & Human Geography',
      },
      {
        'title': 'History',
        'image': 'assets/history.png',
        'description': 'World History',
      },
    ];

    return Column(
      children: [
        // Header for A-levels section
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            'A-Level Subjects',
            style: GoogleFonts.fredoka(
              fontSize: _getResponsiveValue(
                context: context,
                small: 20.0,
                medium: 24.0,
                large: 28.0,
              ),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF002366),
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // Grid layout for subjects
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: _getResponsiveValue(
              context: context,
              small: 12.0,
              medium: 16.0,
              large: 20.0,
            ),
            mainAxisSpacing: _getResponsiveValue(
              context: context,
              small: 12.0,
              medium: 16.0,
              large: 20.0,
            ),
          ),
          itemCount: aLevelsSubjects.length,
          itemBuilder: (context, index) {
            final subject = aLevelsSubjects[index];
            return _buildSubjectCard(subject, screenWidth);
          },
        ),
      ],
    );
  }

  Widget _buildSubjectCard(Map<String, String> subject, double screenWidth) {
    final cardPadding = _getResponsiveValue(
      context: context,
      small: 12.0,
      medium: 16.0,
      large: 20.0,
    );

    final imageSize = _getResponsiveValue(
      context: context,
      small: 60.0,
      medium: 70.0,
      large: 80.0,
    );

    final titleFontSize = _getResponsiveValue(
      context: context,
      small: 14.0,
      medium: 16.0,
      large: 18.0,
    );

    final descriptionFontSize = _getResponsiveValue(
      context: context,
      small: 11.0,
      medium: 12.0,
      large: 14.0,
    );

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(cardPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.grey.shade50],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Subject image
            Container(
              height: imageSize,
              width: imageSize,
              decoration: BoxDecoration(
                color: const Color(0xFF002366).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                subject['image']!,
                height: imageSize * 0.7,
                width: imageSize * 0.7,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.book,
                  size: imageSize * 0.6,
                  color: const Color(0xFF002366),
                ),
              ),
            ),

            SizedBox(height: cardPadding * 0.5),

            // Subject title
            Text(
              subject['title']!,
              style: GoogleFonts.fredoka(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF002366),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            if (screenWidth > 480) ...[
              SizedBox(height: cardPadding * 0.25),

              // Subject description (only on larger screens)
              Text(
                subject['description']!,
                style: GoogleFonts.fredoka(
                  fontSize: descriptionFontSize,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SpeechBubbleTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawShadow(path, Colors.black.withOpacity(0.1), 2, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SpeechBubble extends StatelessWidget {
  final String text;
  final double screenWidth;

  const SpeechBubble({
    super.key,
    required this.text,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive font size for speech bubble
    final fontSize = screenWidth <= 480
        ? 12.0
        : screenWidth <= 768
        ? 13.0
        : 14.0;

    // Responsive padding
    final padding = screenWidth <= 480 ? 10.0 : 12.0;

    return CustomPaint(
      painter: BubblePainter(),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.fredoka(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF002366), // Dark blue
          ),
        ),
      ),
    );
  }
}

class BubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final border = Paint()
      ..color = const Color(0xFF002366)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height - 10),
      const Radius.circular(12),
    );

    // Draw bubble
    canvas.drawRRect(rrect, paint);
    canvas.drawRRect(rrect, border);

    // Draw tail
    final path = Path();
    path.moveTo(size.width / 2 - 10, size.height - 10);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width / 2 + 10, size.height - 10);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, border);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
