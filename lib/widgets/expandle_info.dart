import 'package:flutter/material.dart';
import 'dart:math' as math;

class ExpandableInfoButton extends StatefulWidget {
  final Function(int)? onNavigate;

  const ExpandableInfoButton({super.key, this.onNavigate});

  @override
  State<ExpandableInfoButton> createState() => _ExpandableInfoButtonState();
}

class _ExpandableInfoButtonState extends State<ExpandableInfoButton> {
  bool _isExpanded = false;

  final List<InfoItem> _infoItems = [
    InfoItem(
      'SAT',
      const LinearGradient(
        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      2, // Navigate to Pre-School page (index 2)
    ),
    InfoItem(
      '11+',
      const LinearGradient(
        colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      3, // Navigate to 11+ page (index 3)
    ),
    InfoItem(
      'GCSEs',
      const LinearGradient(
        colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      4, // Navigate to GCSEs page (index 4)
    ),
    InfoItem(
      'A-Levels',
      const LinearGradient(
        colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      5, // Navigate to A-Levels page (index 5)
    ),
  ];

  // Track clicked states
  final List<bool> _clickedStates = [false, false, false, false];

  void _onHoverEnter() {
    print('Hover entered - expanding');
    setState(() {
      _isExpanded = true;
    });
  }

  void _onHoverExit() {
    print('Hover exited - collapsing');
    setState(() {
      _isExpanded = false;
    });
  }

  void _onMiniCircleClick(int index) {
    print('Mini circle clicked: $index');
    setState(() {
      _clickedStates[index] = !_clickedStates[index];
    });

    // Handle the click action with navigation
    _handleCircleAction(_infoItems[index].text, _infoItems[index].pageIndex);
  }

  void _handleCircleAction(String itemType, int pageIndex) {
    print('Handling action for: $itemType, navigating to page: $pageIndex');
    // Navigate to the appropriate page
    if (widget.onNavigate != null) {
      widget.onNavigate!(pageIndex);
    }

    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to $itemType page'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: _infoItems
            .firstWhere((item) => item.text == itemType)
            .gradient
            .colors[0],
      ),
    );
  }

  // Helper method to determine screen size category
  ScreenSizeCategory _getScreenSizeCategory() {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return ScreenSizeCategory.small;
    } else if (screenWidth < 900) {
      return ScreenSizeCategory.medium;
    } else {
      return ScreenSizeCategory.large;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = _getScreenSizeCategory();
    final isSmallScreen = screenSize == ScreenSizeCategory.small;
    final isMediumScreen = screenSize == ScreenSizeCategory.medium;

    // Responsive sizing
    final mainBallSize = isSmallScreen ? 80.0 : (isMediumScreen ? 95.0 : 110.0);
    final miniBallSize = isSmallScreen ? 55.0 : (isMediumScreen ? 65.0 : 75.0);
    final orbitRadius = isSmallScreen ? 75.0 : (isMediumScreen ? 85.0 : 100.0);
    final fontSize = isSmallScreen ? 10.0 : (isMediumScreen ? 11.0 : 13.0);
    final mainBallFontSize = isSmallScreen
        ? 10.0
        : (isMediumScreen ? 12.0 : 14.0);

    return MouseRegion(
      onEnter: (_) => _onHoverEnter(),
      onExit: (_) => _onHoverExit(),
      child: SizedBox(
        width: orbitRadius * 2 + miniBallSize,
        height: orbitRadius * 2 + miniBallSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow effect (static)
            Container(
              width: mainBallSize + (8 * 2),
              height: mainBallSize + (8 * 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.red.withOpacity(0.15),
                    Colors.red.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // Main 3D ball with realistic sphere shading (static)
            Container(
              width: mainBallSize,
              height: mainBallSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: const Alignment(-0.3, -0.4),
                  colors: [
                    const Color(0xFFff6b9d), // Highlight
                    const Color(0xFFff416c), // Mid-tone
                    const Color(0xFFe63946), // Shadow
                    const Color(0xFFa4161a), // Deep shadow
                  ],
                  stops: const [0.1, 0.4, 0.7, 1.0],
                ),
                boxShadow: [
                  // Main shadow
                  BoxShadow(
                    color: Colors.red.withOpacity(0.4),
                    blurRadius: 8 * 1.5,
                    offset: Offset(8 * 0.3, 8 * 0.8),
                    spreadRadius: 2,
                  ),
                  // Inner glow
                  BoxShadow(
                    color: Colors.red.withOpacity(0.2),
                    blurRadius: 8 * 3,
                    offset: Offset(0, 8 * 1.2),
                    spreadRadius: -3,
                  ),
                  // Ambient light
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(-2, -4),
                    spreadRadius: -8,
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Specular highlight
                  gradient: RadialGradient(
                    center: const Alignment(-0.4, -0.5),
                    radius: 0.3,
                    colors: [
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    isSmallScreen
                        ? 'Instant\nAssessment'
                        : 'Instant\nAssessment',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: mainBallFontSize,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(
                            isSmallScreen ? 0.5 : 1,
                            isSmallScreen ? 1 : 2,
                          ),
                          blurRadius: isSmallScreen ? 2 : 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Clickable 3D mini balls with proper animation
            ...List.generate(_infoItems.length, (index) {
              final item = _infoItems[index];

              // Calculate orbital position (static when expanded)
              final baseAngle = (index * 90.0) * (math.pi / 180);
              final radius = _isExpanded ? orbitRadius : 0.0;
              final x = radius * math.cos(baseAngle);
              final y = radius * math.sin(baseAngle);

              return AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic,
                left: (orbitRadius + miniBallSize / 2) + x - (miniBallSize / 2),
                top: (orbitRadius + miniBallSize / 2) + y - (miniBallSize / 2),
                child: AnimatedOpacity(
                  opacity: _isExpanded ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedScale(
                    scale: _isExpanded ? 1.0 : 0.3,
                    duration: const Duration(milliseconds: 300),
                    child: GestureDetector(
                      onTap: () => _onMiniCircleClick(index),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          width: miniBallSize,
                          height: miniBallSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              center: const Alignment(-0.3, -0.4),
                              colors: _clickedStates[index]
                                  ? [
                                      Colors.white,
                                      item.gradient.colors[0],
                                      item.gradient.colors[1],
                                      item.gradient.colors[1].withOpacity(0.8),
                                    ]
                                  : [
                                      item.gradient.colors[0].withOpacity(0.9),
                                      item.gradient.colors[0],
                                      item.gradient.colors[1],
                                      item.gradient.colors[1].withOpacity(0.7),
                                    ],
                              stops: const [0.1, 0.4, 0.7, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: item.gradient.colors[1].withOpacity(0.4),
                                blurRadius: _clickedStates[index] ? 20 : 15,
                                offset: const Offset(3, 8),
                                spreadRadius: _clickedStates[index] ? 3 : 1,
                              ),
                              BoxShadow(
                                color: item.gradient.colors[0].withOpacity(0.3),
                                blurRadius: 25,
                                offset: const Offset(0, 12),
                                spreadRadius: -5,
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                blurRadius: 3,
                                offset: const Offset(-2, -4),
                                spreadRadius: -10,
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                center: const Alignment(-0.4, -0.5),
                                radius: 0.4,
                                colors: [
                                  Colors.white.withOpacity(
                                    _clickedStates[index] ? 0.6 : 0.3,
                                  ),
                                  Colors.white.withOpacity(0.1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                item.text,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _clickedStates[index]
                                      ? Colors.black87
                                      : Colors.white,
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  shadows: _clickedStates[index]
                                      ? []
                                      : [
                                          Shadow(
                                            color: Colors.black54,
                                            offset: Offset(
                                              isSmallScreen ? 0.5 : 1,
                                              isSmallScreen ? 1 : 2,
                                            ),
                                            blurRadius: isSmallScreen ? 2 : 3,
                                          ),
                                        ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),

            // Static floating particles for atmosphere (only when expanded)
            if (_isExpanded)
              ...List.generate(8, (index) {
                final particleAngle = (index * 45.0) * (math.pi / 180);
                final particleRadius = orbitRadius + (miniBallSize / 2);
                final px = particleRadius * math.cos(particleAngle);
                final py = particleRadius * math.sin(particleAngle);

                return Transform.translate(
                  offset: Offset(px, py),
                  child: Opacity(
                    opacity: 0.3,
                    child: Container(
                      width: isSmallScreen ? 4 : 6,
                      height: isSmallScreen ? 4 : 6,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Colors.white,
                            Colors.white.withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.8),
                            blurRadius: isSmallScreen ? 4 : 6,
                            spreadRadius: isSmallScreen ? 1 : 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}

class InfoItem {
  final String text;
  final LinearGradient gradient;
  final int pageIndex;

  InfoItem(this.text, this.gradient, this.pageIndex);
}

enum ScreenSizeCategory {
  small, // < 600px
  medium, // 600-900px
  large, // > 900px
}
