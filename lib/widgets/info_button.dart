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
  final int currentPageIndex;

  const JellyInfoButton({
    super.key,
    required this.showInfoList,
    required this.animationController,
    required this.scaleAnimation,
    required this.heightAnimation,
    required this.onStartAnimation,
    required this.onReverseAnimation,
    required this.onPageSelected,
    required this.currentPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final buttonSize = screenSize == ScreenSize.small
        ? 80.0 // Increased from 60.0
        : screenSize == ScreenSize.medium
        ? 100.0 // Increased from 70.0
        : 120.0; // Increased from 80.0
    final infoButtonWidth = screenSize == ScreenSize.small
        ? 90.0 // Increased from 70.0
        : screenSize == ScreenSize.medium
        ? 110.0 // Increased from 90.0
        : 130.0; // Increased from 110.0

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
                  child: GestureDetector(
                    onTap: () {},
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: _buildHighQualityImage(buttonSize),
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

  Widget _buildHighQualityImage(double size) {
    // Use a high-resolution source image (at least 2x the display size)
    // For web: Consider using a WebP format for better compression
    return Image.asset(
      'assets/bot.png', // Replace with a high-resolution version
      width: 120,
      height: 120,
      filterQuality: FilterQuality.high, // Use high filter quality
      isAntiAlias: true, // Enable anti-aliasing
      fit: BoxFit.contain, // Maintain aspect ratio
      errorBuilder: (context, error, stackTrace) =>
          Icon(Icons.help_outline, color: Colors.purple.shade700),
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
