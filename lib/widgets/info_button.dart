import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_stack_v2/models/screen_size.dart';

class JellyInfoButton extends StatelessWidget {
  final bool showInfoList;
  final AnimationController animationController;
  final Animation<double> scaleAnimation;
  final Animation<double> heightAnimation;
  final VoidCallback onStartAnimation;
  final VoidCallback onReverseAnimation;
  final Function(int) onPageSelected;
  final int currentPageIndex; // Add this parameter

  const JellyInfoButton({
    super.key,
    required this.showInfoList,
    required this.animationController,
    required this.scaleAnimation,
    required this.heightAnimation,
    required this.onStartAnimation,
    required this.onReverseAnimation,
    required this.onPageSelected,
    required this.currentPageIndex, // Add this to constructor
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final buttonSize = screenSize == ScreenSize.small
        ? 40.0
        : screenSize == ScreenSize.medium
        ? 50.0
        : 60.0;
    final infoButtonWidth = screenSize == ScreenSize.small
        ? 70.0
        : screenSize == ScreenSize.medium
        ? 90.0
        : 110.0;

    final options = [
      {'text': 'Primary', 'pageIndex': 1},
      {'text': 'Pre-School', 'pageIndex': 2},
      {'text': '11+', 'pageIndex': 3},
      {'text': 'GCSEs', 'pageIndex': 4},
      {'text': 'A-Levels', 'pageIndex': 5},
    ];

    return MouseRegion(
      onEnter: (_) => onStartAnimation(),
      onExit: (_) => onReverseAnimation(),
      child: GestureDetector(
        onTap: () => showInfoList ? onReverseAnimation() : onStartAnimation(),
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.elasticOut,
                  transform: Matrix4.identity()
                    ..translate(0.0, showInfoList ? -15.0 : 0.0)
                    ..scale(showInfoList ? 1.3 : 1.0),
                  child: Container(
                    width: buttonSize,
                    height: buttonSize,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.4),
                          blurRadius: showInfoList ? 15 : 8,
                          spreadRadius: showInfoList ? 3 : 1.5,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Image.asset(
                              'assets/little_robot.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    Icons.help_outline,
                                    color: Colors.purple.shade700,
                                    size: buttonSize * 0.6,
                                  ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -90,
                          top: -10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "I'm kAI",
                                  style: GoogleFonts.fredoka(
                                    fontSize: screenSize == ScreenSize.small
                                        ? 12
                                        : 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple.shade800,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.auto_awesome,
                                  color: Colors.amber,
                                  size: screenSize == ScreenSize.small
                                      ? 14
                                      : 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: -40,
                          top: 10,
                          child: CustomPaint(
                            size: const Size(30, 20),
                            painter: _SpeechBubbleTailPainter(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ScaleTransition(
                  scale: scaleAnimation,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOutCubic,
                    width: infoButtonWidth,
                    height:
                        heightAnimation.value *
                        (screenSize == ScreenSize.small ? 0.7 : 1.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(
                            showInfoList ? 0.7 : 0.5,
                          ),
                          blurRadius: showInfoList ? 20 : 12,
                          spreadRadius: showInfoList ? 4 : 2.5,
                          offset: Offset(0, showInfoList ? 10 : 6),
                        ),
                      ],
                    ),
                    child: Material(
                      elevation: showInfoList ? 15 : 10,
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(
                            screenSize == ScreenSize.small ? 8 : 12,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedRotation(
                                turns: showInfoList ? 0.5 : 0.0,
                                duration: const Duration(milliseconds: 300),
                                child: Icon(
                                  Icons.help_outline,
                                  color: Colors.white,
                                  size: screenSize == ScreenSize.small
                                      ? 20
                                      : 24,
                                ),
                              ),
                              SizedBox(
                                height: screenSize == ScreenSize.small ? 4 : 8,
                              ),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: showInfoList ? 0.0 : 1.0,
                                child: Text(
                                  'Study\nHelper',
                                  style: GoogleFonts.fredoka(
                                    fontSize: screenSize == ScreenSize.small
                                        ? 10
                                        : 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    height: 1.1,
                                    letterSpacing: 0.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              if (showInfoList) ...[
                                SizedBox(
                                  height: screenSize == ScreenSize.small
                                      ? 6
                                      : 8,
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: showInfoList
                                      ? (screenSize == ScreenSize.small
                                            ? 40
                                            : 60)
                                      : 0,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize == ScreenSize.small
                                      ? 6
                                      : 8,
                                ),
                              ],
                              if (showInfoList)
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: options.map((option) {
                                        final index = options.indexOf(option);
                                        return AnimatedContainer(
                                          duration: Duration(
                                            milliseconds: 200 + (index * 50),
                                          ),
                                          curve: Curves.easeOutBack,
                                          transform: Matrix4.identity()
                                            ..translate(
                                              showInfoList ? 0.0 : 20.0,
                                              0.0,
                                            ),
                                          child: AnimatedOpacity(
                                            duration: Duration(
                                              milliseconds: 300 + (index * 100),
                                            ),
                                            opacity: showInfoList ? 1.0 : 0.0,
                                            child: InkWell(
                                              onTap: () {
                                                onPageSelected(
                                                  option['pageIndex'] as int,
                                                );
                                                onReverseAnimation();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                  vertical:
                                                      screenSize ==
                                                          ScreenSize.small
                                                      ? 2.0
                                                      : 4.0,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenSize ==
                                                          ScreenSize.small
                                                      ? 4.0
                                                      : 8.0,
                                                  vertical:
                                                      screenSize ==
                                                          ScreenSize.small
                                                      ? 2.0
                                                      : 4.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      currentPageIndex ==
                                                          option['pageIndex']
                                                      ? Colors.white
                                                            .withOpacity(0.3)
                                                      : Colors.white
                                                            .withOpacity(0.15),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      _getIconForOption(
                                                        option['text']
                                                            as String,
                                                      ),
                                                      color: Colors.white,
                                                      size:
                                                          screenSize ==
                                                              ScreenSize.small
                                                          ? 14
                                                          : 16,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        option['text']
                                                            as String,
                                                        style:
                                                            GoogleFonts.fredoka(
                                                              fontSize:
                                                                  screenSize ==
                                                                      ScreenSize
                                                                          .small
                                                                  ? 10
                                                                  : 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white,
                                                              letterSpacing:
                                                                  0.3,
                                                            ),
                                                      ),
                                                    ),
                                                    if (currentPageIndex ==
                                                        option['pageIndex'])
                                                      Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                        size:
                                                            screenSize ==
                                                                ScreenSize.small
                                                            ? 14
                                                            : 16,
                                                      ),
                                                  ],
                                                ),
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
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  IconData _getIconForOption(String option) {
    switch (option) {
      case 'Primary':
        return Icons.school;
      case 'Pre-School':
        return Icons.child_care;
      case '11+':
        return Icons.format_list_numbered;
      case 'GCSEs':
        return Icons.assignment;
      case 'A-Levels':
        return Icons.school_outlined;
      default:
        return Icons.help_outline;
    }
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
