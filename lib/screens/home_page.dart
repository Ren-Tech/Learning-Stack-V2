import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_stack_v2/widgets/expandle_info.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/info_button.dart';
import '../widgets/center_content.dart';
import '../models/page_data.dart';

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

  // Map page indices to their corresponding background images
  final Map<int, String> _backgroundImages = {
    0: 'assets/home.png', // Primary/Home page
    1: 'assets/primary.png', // Primary page
    2: 'assets/pre_shool.png', // Pre School page
    3: 'assets/11+.png', // 11+ page
    4: 'assets/GCSE.png', // GCSE's page
    5: 'assets/alevels.png', // A-Levels page
  };

  // Map for mobile-specific background images
  final Map<int, String> _mobileBackgroundImages = {
    0: 'assets/hm.png', // Home page mobile
    1: 'assets/primary_mobile.png', // Primary page mobile
    2: 'assets/pre_school_mobile.png', // Pre School mobile
    3: 'assets/11+__mobile.png', // 11+ page mobile
    4: 'assets/GCSE_mobile.png', // GCSE's page mobile
    5: 'assets/alevels_mobile.png', // A-Levels page mobile
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

  // Get the background image asset path for the current page
  String _getCurrentBackgroundImage() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 768; // Mobile breakpoint

    if (isMobile) {
      return _mobileBackgroundImages[_currentPageIndex] ??
          'assets/home_mobile.png';
    } else {
      return _backgroundImages[_currentPageIndex] ?? 'assets/homepage.png';
    }
  }

  // Get the appropriate background image scale based on screen size
  double _getBackgroundImageScale() {
    final screenWidth = MediaQuery.of(context).size.width;

    // Keep original size on mobile (scale 1.0)
    if (screenWidth <= 768) {
      return 1.0;
    }

    // For larger screens, scale down based on screen width
    if (screenWidth <= 1024) {
      return 0.9;
    }
    if (screenWidth <= 1200) {
      return 0.85;
    }
    if (screenWidth <= 1400) {
      return 0.8;
    }

    // For very large screens
    return 0.75;
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

  // Helper method to determine if we should enable scrolling
  bool _shouldEnableScrolling() {
    final screenWidth = _getScreenWidth(context);
    final orientation = MediaQuery.of(context).orientation;

    // Enable scrolling on small screens (mobile) OR in portrait mode
    return screenWidth <= 768 || orientation == Orientation.portrait;
  }

  // Helper method to determine if we should center the ExpandableInfoButton
  bool _shouldCenterExpandableInfo() {
    final screenWidth = _getScreenWidth(context);
    final orientation = MediaQuery.of(context).orientation;

    // Center on mobile screens OR in portrait mode
    return screenWidth <= 768 || orientation == Orientation.portrait;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = _getScreenWidth(context);
    final screenHeight = _getScreenHeight(context);
    final isMobile = screenWidth <= 768;
    final shouldEnableScrolling = _shouldEnableScrolling();
    final shouldCenterExpandableInfo = _shouldCenterExpandableInfo();

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

    // Adjusted positioning for ninja image - moved more to the left
    final ninjaLeft = _getResponsiveValue(
      context: context,
      small: screenWidth * 0.1, // 10% from left on mobile
      medium: screenWidth * 0.15, // 15% from left on medium screens
      large: screenWidth * 0.2, // 20% from left on large screens
      extraLarge: screenWidth * 0.25, // 25% from left on extra large
    );

    // Adjusted positioning for info button - moved more to the left
    final infoButtonRight = _getResponsiveValue(
      context: context,
      small: 30.0, // Reduced from 16.0
      medium: screenWidth * 0.05, // Reduced from 0.08
      large: screenWidth * 0.04, // Reduced from 0.06
      extraLarge: 60.0, // Reduced from 90.0
    );

    final infoButtonBottom = screenWidth <= 480 ? 16.0 : 0.0;

    // Main content widget
    Widget mainContent = Stack(
      children: [
        // Background image with conditional scaling
        isMobile
            ? Container(
                width: double.infinity,
                height: screenHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_getCurrentBackgroundImage()),
                    fit: BoxFit.cover, // Use cover on mobile
                    alignment: Alignment.center,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              )
            : Transform.scale(
                scale:
                    _getBackgroundImageScale(), // Scale down on larger screens
                child: Container(
                  width: double.infinity,
                  height: screenHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(_getCurrentBackgroundImage()),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
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
              // Ninja image positioned at center bottom
              Positioned(
                bottom: ninjaBottom,
                left: 0,
                right: 0,
                child: Center(
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
              // UPDATED: ExpandableInfoButton with conditional centering and navigation
              if (_currentPageIndex == 0)
                shouldCenterExpandableInfo
                    ? // Centered positioning for mobile/portrait
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Center(
                          child: ExpandableInfoButton(onNavigate: _changePage),
                        ),
                      )
                    : // Positioned for desktop/landscape with proper positioning
                      Positioned(
                        top: 50.0,
                        right: screenWidth * 0.15,
                        child: ExpandableInfoButton(onNavigate: _changePage),
                      ),
            ],
          ),
        ),
      ],
    );

    // Conditionally wrap with scrollable content
    if (shouldEnableScrolling) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            // Scrollable AppBar (not pinned)
            SliverAppBar(
              pinned: false, // Changed to false to make it scrollable
              floating: false,
              snap: false,
              expandedHeight: kToolbarHeight,
              flexibleSpace: CustomAppBar(
                currentPageIndex: _currentPageIndex,
                onPageChanged: _changePage,
              ),
            ),

            // Text bar
            SliverToBoxAdapter(child: _buildAnimatedTextBar(context)),

            // Main content
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
      // For large screens in landscape - no scrolling
      return Scaffold(
        body: Column(
          children: [
            // Fixed AppBar
            SizedBox(
              height: kToolbarHeight,
              child: CustomAppBar(
                currentPageIndex: _currentPageIndex,
                onPageChanged: _changePage,
              ),
            ),

            // Text bar
            _buildAnimatedTextBar(context),

            // Main content (expands to fill remaining space)
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
        SizedBox(height: bottomSpacing),
      ],
    );
  }

  Widget _buildTabletLayout(double spacing, double bottomSpacing) {
    return Column(
      children: [
        // Center content at top
        CenterContent(currentPageIndex: _currentPageIndex),
        SizedBox(height: bottomSpacing),
      ],
    );
  }

  Widget _buildDesktopLayout(double spacing, double bottomSpacing) {
    return Column(
      children: [
        // Center content for desktop
        CenterContent(currentPageIndex: _currentPageIndex),
        SizedBox(height: bottomSpacing),
      ],
    );
  }
}
