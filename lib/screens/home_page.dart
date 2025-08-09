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

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final ninjaSize = screenSize == ScreenSize.small
        ? 180.0
        : screenSize == ScreenSize.medium
        ? 240.0
        : 300.0;
    final ninjaBottom = screenSize == ScreenSize.small
        ? -70.0
        : screenSize == ScreenSize.medium
        ? -90.0
        : -110.0;
    final infoButtonRight = screenSize == ScreenSize.small
        ? 16.0
        : screenSize == ScreenSize.medium
        ? 60.0
        : 90.0;
    final infoButtonBottom = screenSize == ScreenSize.small ? 16.0 : 0.0;

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
                        // Ninja Speech Bubble
                        Positioned(
                          right: -120,
                          top: 40,
                          child: SpeechBubble(
                            text:
                                'Our knowledge\nteam are always ready\nto help!',
                          ),
                        ),
                        // Speech Bubble Tail
                        Positioned(
                          right: -40,
                          top: 60,
                          child: CustomPaint(
                            size: const Size(30, 20),
                            painter: _SpeechBubbleTailPainter(),
                          ),
                        ),
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

                    currentPageIndex:
                        _currentPageIndex, // Pass your current page index here
                    onPageSelected: (pageIndex) {
                      _changePage(pageIndex); // Your page change function
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

  Widget _buildAnimatedTextBar(BuildContext context) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final barHeight = screenSize == ScreenSize.small
        ? 36.0
        : screenSize == ScreenSize.medium
        ? 40.0
        : 48.0;
    final horizontalPadding = screenSize == ScreenSize.small
        ? 12.0
        : screenSize == ScreenSize.medium
        ? 16.0
        : 24.0;

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
      child: screenSize == ScreenSize.small
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
                          fontSize: screenSize == ScreenSize.small ? 12 : 16,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          : Row(
              children: [
                Text(
                  PageData.pageNames[_currentPageIndex],
                  style: GoogleFonts.fredoka(
                    color: Colors.white,
                    fontSize: screenSize == ScreenSize.medium ? 20 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Row(
                  children: PageData.pageTexts[_currentPageIndex].map((text) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        text,
                        style: GoogleFonts.fredoka(
                          color: Colors.white,
                          fontSize: screenSize == ScreenSize.medium ? 16 : 18,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }

  Widget _buildResponsiveContent(BuildContext context) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize == ScreenSize.small ? 16 : 24,
        vertical: 20,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: screenSize == ScreenSize.small
              ? Column(
                  children: [
                    CenterContent(currentPageIndex: _currentPageIndex),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LeftImageColumn(currentPageIndex: _currentPageIndex),
                        const SizedBox(width: 16),
                        RightImageColumn(currentPageIndex: _currentPageIndex),
                      ],
                    ),
                    const SizedBox(height: 80),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeftImageColumn(currentPageIndex: _currentPageIndex),
                    const SizedBox(width: 24),
                    CenterContent(currentPageIndex: _currentPageIndex),
                    const SizedBox(width: 24),
                    RightImageColumn(currentPageIndex: _currentPageIndex),
                  ],
                ),
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

  const SpeechBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.fredoka(
            fontSize: 14,
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
