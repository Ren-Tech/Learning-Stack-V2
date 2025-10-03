import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_stack_v2/widgets/expandle_info.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/info_button.dart';
import '../widgets/center_content.dart';
import '../models/page_data.dart';
import 'dart:async';

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

  bool _isLongPressing = false;
  Timer? _longPressTimer;

  // Map page indices to their corresponding background images
  final Map<int, String> _backgroundImages = {
    0: 'assets/home_dia.png',
    1: 'assets/primary_dia.png',
    2: 'assets/pre_shool.png',
    3: 'assets/11+.png',
    4: 'assets/GCSE.png',
    5: 'assets/alevels.png',
  };

  // Map for mobile-specific background images
  final Map<int, String> _mobileBackgroundImages = {
    0: 'assets/home_dia_mob.png',
    1: 'assets/primary_mob.png',
    2: 'assets/pre_school_mobile.png',
    3: 'assets/11+__mobile.png',
    4: 'assets/gcse_mob.png',
    5: 'assets/alevels_mobile.png',
  };

  // Map for landscape-specific background images (for tablets/smaller devices)
  final Map<int, String> _landscapeBackgroundImages = {
    0: 'assets/land_home.png',
    4: 'assets/land_gcse.png',
  };

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
    _longPressTimer?.cancel();
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

  void _startLongPress() {
    _longPressTimer?.cancel();
    _longPressTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isLongPressing = true;
        });
      }
    });
  }

  void _endLongPress() {
    _longPressTimer?.cancel();
    if (mounted) {
      setState(() {
        _isLongPressing = false;
      });
    }
  }

  // UPDATED: Get the background image asset path for the current page
  String _getCurrentBackgroundImage() {
    final orientation = MediaQuery.of(context).orientation;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 768;
    final isLargeScreen = screenWidth > 1024; // Laptop/computer screens

    // Check if device is in landscape mode
    if (orientation == Orientation.landscape) {
      // For large screens (laptops/computers), use _backgroundImages
      if (isLargeScreen) {
        return _backgroundImages[_currentPageIndex] ?? 'assets/home_dia.png';
      }

      // For smaller landscape devices (tablets), use landscape images if available
      return _landscapeBackgroundImages[_currentPageIndex] ??
          _backgroundImages[_currentPageIndex] ??
          'assets/home_dia.png';
    }

    // Portrait mode - use mobile images for mobile devices
    if (isMobile) {
      return _mobileBackgroundImages[_currentPageIndex] ??
          'assets/home_dia_mob.png';
    } else {
      return _backgroundImages[_currentPageIndex] ?? 'assets/home_dia.png';
    }
  }

  // NEW: Get appropriate image fit based on screen size and orientation
  BoxFit _getBackgroundImageFit() {
    final screenWidth = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;

    // For very large screens, use contain to prevent cutting
    if (screenWidth > 1440) {
      return BoxFit.contain;
    }

    // For large landscape screens, use contain
    if (orientation == Orientation.landscape && screenWidth > 1024) {
      return BoxFit.contain;
    }

    // For all other cases, use cover
    return BoxFit.cover;
  }

  // NEW: Get background alignment based on screen size
  Alignment _getBackgroundAlignment() {
    final screenWidth = MediaQuery.of(context).size.width;

    // For very large screens, center the image
    if (screenWidth > 1440) {
      return Alignment.center;
    }

    // For large screens, center the image
    if (screenWidth > 1024) {
      return Alignment.center;
    }

    // Default alignment
    return Alignment.center;
  }

  // NEW: Get background color for areas not covered by contained images
  Color _getBackgroundColor() {
    final screenWidth = MediaQuery.of(context).size.width;

    // For large screens where we use BoxFit.contain, add a background color
    if (screenWidth > 1024) {
      return const Color(0x00ffffff); // Use your app's primary green color
    }

    return Colors.transparent;
  }

  // Debug method to check which image is being used
  void _debugImageSelection() {
    final orientation = MediaQuery.of(context).orientation;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 768;
    final isLargeScreen = screenWidth > 1024;
    final landscapeImage = _landscapeBackgroundImages[_currentPageIndex];
    final mobileImage = _mobileBackgroundImages[_currentPageIndex];
    final regularImage = _backgroundImages[_currentPageIndex];

    print('=== DEBUG IMAGE SELECTION ===');
    print('Orientation: $orientation');
    print('Screen Width: $screenWidth');
    print('Is Mobile: $isMobile');
    print('Is Large Screen: $isLargeScreen');
    print('Current Page: $_currentPageIndex');
    print('Landscape Image: $landscapeImage');
    print('Mobile Image: $mobileImage');
    print('Regular Image: $regularImage');
    print('Selected Image: ${_getCurrentBackgroundImage()}');
    print('Background Fit: ${_getBackgroundImageFit()}');
    print('Background Alignment: ${_getBackgroundAlignment()}');
    print('=============================');
  }

  double _getResponsiveValue({
    required BuildContext context,
    required double small,
    required double medium,
    required double large,
    double? extraLarge,
  }) {
    final width = MediaQuery.of(context).size.width;
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
    return width.isFinite && width > 0 ? width : 320.0;
  }

  double _getScreenHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return height.isFinite && height > 0 ? height : 568.0;
  }

  bool _shouldEnableScrolling() {
    final screenWidth = _getScreenWidth(context);
    final orientation = MediaQuery.of(context).orientation;
    return screenWidth <= 768 || orientation == Orientation.portrait;
  }

  bool _shouldCenterExpandableInfo() {
    final screenWidth = _getScreenWidth(context);
    final orientation = MediaQuery.of(context).orientation;
    return screenWidth <= 768 || orientation == Orientation.portrait;
  }

  bool _isLandscapeMode() {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // UPDATED: Adjust ninja positioning for better placement on large screens
  double _getNinjaBottomPosition() {
    final orientation = MediaQuery.of(context).orientation;
    final screenHeight = _getScreenHeight(context);
    final screenWidth = _getScreenWidth(context);

    // For very large screens, adjust ninja position
    if (screenWidth > 1440) {
      if (orientation == Orientation.landscape) {
        return -80.0;
      } else {
        return 60.0;
      }
    }

    if (orientation == Orientation.landscape) {
      return _getResponsiveValue(
        context: context,
        small: screenHeight < 600 ? -30.0 : -40.0,
        medium: -70.0,
        large: -110.0,
        extraLarge: -120.0,
      );
    } else {
      return _getResponsiveValue(
        context: context,
        small: screenHeight < 600 ? 20.0 : 40.0,
        medium: 60.0,
        large: 80.0,
        extraLarge: 100.0,
      );
    }
  }

  // UPDATED: Adjust ninja size for better scaling on large screens
  double _getNinjaSize() {
    final orientation = MediaQuery.of(context).orientation;
    final screenWidth = _getScreenWidth(context);

    // For very large screens, limit the maximum ninja size
    if (screenWidth > 1440) {
      if (orientation == Orientation.landscape) {
        return 280.0;
      } else {
        return 200.0;
      }
    }

    if (orientation == Orientation.landscape) {
      return _getResponsiveValue(
        context: context,
        small: 100.0,
        medium: 180.0,
        large: 280.0,
        extraLarge: 320.0,
      );
    } else {
      return _getResponsiveValue(
        context: context,
        small: 80.0,
        medium: 120.0,
        large: 160.0,
        extraLarge: 180.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _debugImageSelection();
    });

    final screenWidth = _getScreenWidth(context);
    final screenHeight = _getScreenHeight(context);
    final isMobile = screenWidth <= 768;
    final isLandscape = _isLandscapeMode();
    final shouldEnableScrolling = _shouldEnableScrolling();
    final shouldCenterExpandableInfo = _shouldCenterExpandableInfo();

    final ninjaSize = _getNinjaSize();
    final ninjaBottom = _getNinjaBottomPosition();

    final ninjaPadding = _getResponsiveValue(
      context: context,
      small: 30.0,
      medium: 40.0,
      large: 50.0,
      extraLarge: 60.0,
    );

    final infoButtonRight = _getResponsiveValue(
      context: context,
      small: 30.0,
      medium: screenWidth * 0.05,
      large: screenWidth * 0.04,
      extraLarge: 60.0,
    );

    final infoButtonBottom = screenWidth <= 480 ? 16.0 : 0.0;

    final currentBackgroundImage = _getCurrentBackgroundImage();
    final backgroundFit = _getBackgroundImageFit();
    final backgroundAlignment = _getBackgroundAlignment();
    final backgroundColor = _getBackgroundColor();

    // UPDATED: Main content with improved background handling
    Widget mainContent = Stack(
      children: [
        // Background with proper fit and color
        Container(
          width: double.infinity,
          height: screenHeight,
          color: backgroundColor, // Background color for contained images
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(currentBackgroundImage),
                fit:
                    backgroundFit, // Use contain for large screens to prevent cutting
                alignment: backgroundAlignment,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),

        // Content overlay with gradient for better text visibility
        Container(
          height: screenHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(isMobile ? 0.2 : 0.3),
              ],
              stops: const [0.5, 1.0],
            ),
          ),
          child: Stack(
            children: [
              _buildResponsiveContent(context),

              // Ninja image positioned at center bottom with padding
              Positioned(
                bottom: ninjaBottom,
                left: ninjaPadding,
                right: ninjaPadding,
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: screenWidth - (ninjaPadding * 2),
                      maxHeight: ninjaSize,
                    ),
                    child: Image.asset(
                      'assets/ninja.png',
                      height: ninjaSize,
                      width: ninjaSize,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.school,
                        size: ninjaSize * 0.2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // Existing jelly info button
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

              // ExpandableInfoButton with conditional centering and navigation
              if (_currentPageIndex == 0)
                shouldCenterExpandableInfo
                    ? Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Center(
                          child: ExpandableInfoButton(
                            onNavigate: _changePage,
                            isMobile: isMobile,
                            isLongPressing: _isLongPressing,
                            onLongPressStart: isMobile ? _startLongPress : null,
                            onLongPressEnd: isMobile ? _endLongPress : null,
                          ),
                        ),
                      )
                    : Positioned(
                        top: 50.0,
                        right: screenWidth * 0.15,
                        child: ExpandableInfoButton(
                          onNavigate: _changePage,
                          isMobile: isMobile,
                          isLongPressing: _isLongPressing,
                          onLongPressStart: isMobile ? _startLongPress : null,
                          onLongPressEnd: isMobile ? _endLongPress : null,
                        ),
                      ),
            ],
          ),
        ),
      ],
    );

    if (shouldEnableScrolling) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              floating: false,
              snap: false,
              expandedHeight: kToolbarHeight,
              flexibleSpace: CustomAppBar(
                currentPageIndex: _currentPageIndex,
                onPageChanged: _changePage,
              ),
            ),
            SliverToBoxAdapter(child: _buildAnimatedTextBar(context)),
            SliverToBoxAdapter(
              child: SizedBox(height: screenHeight, child: mainContent),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(
          hoveredIndex: _hoveredIndex,
          onHover: (index) => setState(() => _hoveredIndex = index),
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: kToolbarHeight,
              child: CustomAppBar(
                currentPageIndex: _currentPageIndex,
                onPageChanged: _changePage,
              ),
            ),
            _buildAnimatedTextBar(context),
            Expanded(child: mainContent),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(
          hoveredIndex: _hoveredIndex,
          onHover: (index) => setState(() => _hoveredIndex = index),
        ),
      );
    }
  }

  Widget _buildAnimatedTextBar(BuildContext context) {
    final screenWidth = _getScreenWidth(context);
    final isPortrait = !_isLandscapeMode();

    final barHeight = _getResponsiveValue(
      context: context,
      small: 36.0,
      medium: 40.0,
      large: 48.0,
      extraLarge: 52.0,
    );

    final horizontalPadding = _getResponsiveValue(
      context: context,
      small: 8.0,
      medium: 12.0,
      large: 16.0,
      extraLarge: 24.0,
    );

    final useSmallLayout = screenWidth <= 600 || isPortrait;

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
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        text,
                        style: GoogleFonts.fredoka(
                          color: Colors.white,
                          fontSize: _getResponsiveValue(
                            context: context,
                            small: 10.0,
                            medium: 12.0,
                            large: 14.0,
                          ),
                        ),
                        overflow: TextOverflow.ellipsis,
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
                        small: 16.0,
                        medium: 18.0,
                        large: 20.0,
                        extraLarge: 24.0,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
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
                            horizontal: screenWidth <= 768 ? 4.0 : 6.0,
                          ),
                          child: Text(
                            text,
                            style: GoogleFonts.fredoka(
                              color: Colors.white,
                              fontSize: _getResponsiveValue(
                                context: context,
                                small: 12.0,
                                medium: 14.0,
                                large: 16.0,
                                extraLarge: 18.0,
                              ),
                            ),
                            overflow: TextOverflow.ellipsis,
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
    final isPortrait = !_isLandscapeMode();

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

    final maxWidth = screenWidth <= 768 || isPortrait
        ? double.infinity
        : _getResponsiveValue(
            context: context,
            small: 1200.0,
            medium: 1400.0,
            large: 1600.0,
          ).clamp(1200.0, 1600.0);

    return Container(
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

    final isPortrait = !_isLandscapeMode();

    if (screenWidth <= 480) {
      return _buildMobileLayout(spacingBetweenElements, bottomSpacing);
    } else if (screenWidth <= 768 || isPortrait) {
      return _buildTabletLayout(spacingBetweenElements, bottomSpacing);
    } else {
      return _buildDesktopLayout(spacingBetweenElements, bottomSpacing);
    }
  }

  Widget _buildMobileLayout(double spacing, double bottomSpacing) {
    return Column(
      children: [
        CenterContent(currentPageIndex: _currentPageIndex),
        SizedBox(height: bottomSpacing),
      ],
    );
  }

  Widget _buildTabletLayout(double spacing, double bottomSpacing) {
    return Column(
      children: [
        CenterContent(currentPageIndex: _currentPageIndex),
        SizedBox(height: bottomSpacing),
      ],
    );
  }

  Widget _buildDesktopLayout(double spacing, double bottomSpacing) {
    return Column(
      children: [
        CenterContent(currentPageIndex: _currentPageIndex),
        SizedBox(height: bottomSpacing),
      ],
    );
  }
}
