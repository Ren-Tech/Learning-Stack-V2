import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  int? _hoveredIndex;
  bool _showInfoList = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _heightAnimation;

  // For animated text
  late Timer _textTimer;
  int _currentTextIndex = 0;
  final List<List<String>> _animatedTexts = [
    ['Pre-School Apps', 'Pre-School Activity Books'],
    ['Ks2 Math', 'kS2 English', 'kS2 Science'],
    ['11+Apps', '11+Workbook Series', '11+ Exam Packs'],
    ['GCSE Maths', 'GCSE Chemistry', 'GCSE Biology', 'GCSE Physics'],
    ['Maths', 'Chemistry', 'Biology', 'Physics'],
  ];

  final List<Map<String, dynamic>> _actionIcons = [
    {'icon': Icons.home, 'label': 'Home', 'color': Colors.orange},
    {'icon': Icons.info, 'label': 'Info', 'color': Colors.blue},
    {'icon': Icons.search, 'label': 'Browse', 'color': Colors.purple},
    {'icon': Icons.public, 'label': 'World', 'color': Colors.pink},
    {'icon': Icons.book, 'label': 'Book', 'color': Colors.yellow},
    {'icon': Icons.edit, 'label': 'Pen', 'color': Colors.blue},
    {'icon': Icons.handshake, 'label': 'Handshake', 'color': Colors.pink},
    {'icon': Icons.email, 'label': 'Email', 'color': Colors.purple},
  ];

  final List<String> leftImages = [
    'assets/left_1.jpg',
    'assets/left_2.png',
    'assets/left_3.png',
  ];
  final List<String> rightImages = [
    'assets/right_1.png',
    'assets/right_2.png',
    'assets/right_3.png',
    'assets/right_4.png',
    'assets/amazon.png',
  ];

  final List<String> infoItems = [
    'About Us',
    'Contact Information',
    'Privacy Policy',
    'Terms of Service',
    'Help Center',
  ];

  // For image switching animation
  late Timer _imageSwitchTimer;
  int _currentImageSet = 0;

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

    // Initialize text timer
    _textTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentTextIndex = (_currentTextIndex + 1) % _animatedTexts.length;
      });
    });

    // Initialize image switch timer
    _imageSwitchTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentImageSet = (_currentImageSet + 1) % 6;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textTimer.cancel();
    _imageSwitchTimer.cancel();
    _searchController.dispose();
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

  // Enhanced screen size detection
  ScreenSize _getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return ScreenSize.small;
    if (width < 900) return ScreenSize.medium;
    return ScreenSize.large;
  }

  Widget buildLevelLabel(String label, BuildContext context) {
    final screenSize = _getScreenSize(context);
    final fontSize = switch (screenSize) {
      ScreenSize.small => 12.0,
      ScreenSize.medium => 14.0,
      ScreenSize.large => 16.0,
    };

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize == ScreenSize.small ? 4.0 : 8.0,
      ),
      child: Text(
        label,
        style: GoogleFonts.fredoka(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildResponsiveAppBar(BuildContext context) {
    final screenSize = _getScreenSize(context);

    if (screenSize == ScreenSize.small) {
      return AppBar(
        backgroundColor: Colors.purple.shade700,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/navbar_logo.png',
              height: 32,
              width: 32,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.school, size: 24, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'Learning App',
                style: GoogleFonts.fredoka(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 20, color: Colors.white),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, size: 20, color: Colors.white),
            onSelected: (value) {},
            itemBuilder: (context) =>
                ['Pre-School', 'Primary', '11+', 'GCSEs', 'A-Levels']
                    .map(
                      (level) => PopupMenuItem(
                        value: level,
                        child: Text(level, style: GoogleFonts.fredoka()),
                      ),
                    )
                    .toList(),
          ),
        ],
      );
    }

    return AppBar(
      backgroundColor: Colors.purple.shade700,
      title: Row(
        children: [
          Image.asset(
            'assets/navbar_logo.png',
            height: screenSize == ScreenSize.medium ? 60 : 80,
            width: screenSize == ScreenSize.medium ? 60 : 80,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.school, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Text(
            'Learning Adventure',
            style: GoogleFonts.fredoka(
              fontSize: screenSize == ScreenSize.medium ? 22 : 28,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildLevelLabel('Pre-School', context),
            buildLevelLabel('Primary', context),
            buildLevelLabel('11+', context),
            buildLevelLabel('GCSEs', context),
            buildLevelLabel('A-Levels', context),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: screenSize == ScreenSize.medium ? 180 : 220,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search learning resources...',
                hintStyle: GoogleFonts.fredoka(color: Colors.white70),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.mic, color: Colors.white),
                  onPressed: () {},
                ),
              ),
              style: GoogleFonts.fredoka(color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Image.asset('assets/appbar_right.png'),
        ),
      ],
    );
  }

  Widget _buildLeftImageColumn(List<String> images, BuildContext context) {
    final screenSize = _getScreenSize(context);
    final availableWidth = MediaQuery.of(context).size.width * 0.25;

    if (_currentImageSet == 5) {
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

    String? leftText;
    List<String> leftImagePaths;

    switch (_currentImageSet) {
      case 0:
        leftText = 'A-Level Apps';
        leftImagePaths = images;
        break;
      case 1:
        leftText = 'GCSE Apps';
        leftImagePaths = ['assets/page2_left.jpg', images[1], images[2]];
        break;
      case 2:
        leftText = '11+ Apps';
        leftImagePaths = [
          'assets/page3_left1.jpg',
          'assets/page3_left2.png',
          images[2],
        ];
        break;
      case 3:
        leftText = 'KS2 Apps';
        leftImagePaths = [
          'assets/page4_left1.png',
          'assets/page4_left2.jpg',
          'assets/page4_left3.jpg',
        ];
        break;
      case 4:
        leftText = null;
        leftImagePaths = [
          'assets/page5_left1.png',
          'assets/page5_left2.png',
          'assets/page5_left3.png',
          'assets/page5_left4.png',
        ];
        break;
      default:
        leftText = 'A-Level Apps';
        leftImagePaths = images;
    }

    return SizedBox(
      width: availableWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leftText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                leftText,
                style: GoogleFonts.fredoka(
                  fontSize: screenSize == ScreenSize.small ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Column(
            children: leftImagePaths.map((imagePath) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 200,
                    maxWidth: availableWidth,
                  ),
                  child: _buildImageItem(imagePath, context),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRightImageColumn(List<String> images, BuildContext context) {
    final screenSize = _getScreenSize(context);
    final availableWidth = MediaQuery.of(context).size.width * 0.25;

    if (_currentImageSet == 5) {
      return SizedBox(
        width: availableWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple.shade800,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.5),
                        blurRadius: 15,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Instant Assessment\nPowered by kAI',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.fredoka(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: _buildAssessmentOption('SAT', 0, context),
                ),
                Positioned(
                  right: 0,
                  child: _buildAssessmentOption('11+', 1, context),
                ),
                Positioned(
                  bottom: 0,
                  child: _buildAssessmentOption('GCSEs', 2, context),
                ),
                Positioned(
                  left: 0,
                  child: _buildAssessmentOption('A-Levels', 3, context),
                ),
              ],
            ),
          ],
        ),
      );
    }

    String? rightText;
    List<String> rightImagePaths;

    switch (_currentImageSet) {
      case 0:
        rightText = 'A-Level Exam Papers';
        rightImagePaths = images;
        break;
      case 1:
        rightText = 'GCSE Exam Papers';
        rightImagePaths = images;
        break;
      case 2:
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
      case 3:
        rightText = 'KS2 Test Papers';
        rightImagePaths = [
          'assets/page4_right1.png',
          'assets/page4_right2.png',
          'assets/page4_right3.png',
          'assets/page4_right4.png',
          'assets/amazon.png',
        ];
        break;
      case 4:
        rightText = null;
        rightImagePaths = [
          'assets/page5_right1.png',
          'assets/page5_right2.png',
        ];
        break;
      default:
        rightText = 'A-Level Exam Papers';
        rightImagePaths = images;
    }

    return SizedBox(
      width: availableWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (rightText != null)
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
          Column(
            children: rightImagePaths.map((imagePath) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 200,
                    maxWidth: availableWidth,
                  ),
                  child: _buildImageItem(imagePath, context),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentOption(
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

    return Transform.translate(
      offset: _getAssessmentOptionOffset(position, context),
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
    );
  }

  Offset _getAssessmentOptionOffset(int position, BuildContext context) {
    final offset = 80.0;

    switch (position) {
      case 0:
        return Offset(0, -offset);
      case 1:
        return Offset(offset, 0);
      case 2:
        return Offset(0, offset);
      case 3:
        return Offset(-offset, 0);
      default:
        return Offset.zero;
    }
  }

  Widget _buildImageItem(String imagePath, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.purple.shade50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 200,
            color: Colors.purple.shade50,
            child: Icon(Icons.image, size: 50, color: Colors.purple.shade300),
          ),
        ),
      ),
    );
  }

  Widget _buildCenterBookImage(BuildContext context) {
    final screenSize = _getScreenSize(context);
    final availableWidth = MediaQuery.of(context).size.width * 0.4;

    if (_currentImageSet == 5) {
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

    switch (_currentImageSet) {
      case 0:
        centerText = 'A-Level Exercises Books';
        centerImagePaths = ['assets/book_center.png'];
        break;
      case 1:
        centerText = 'GCSE Exercise Books';
        centerImagePaths = ['assets/page2_center.png'];
        break;
      case 2:
        centerText = 'Exercise Books';
        centerImagePaths = ['assets/page3_center_top.png'];
        break;
      case 3:
        centerText = 'KS2 Exercise Books';
        centerImagePaths = ['assets/page3_center_bottom.png'];
        break;
      case 4:
        centerText = 'Activity Books Collection';
        centerImagePaths = [
          'assets/page5_center1.png',
          'assets/page5_center2.png',
          'assets/page5_center3.png',
          'assets/page5_center4.png',
          'assets/page5_center5.png',
        ];
        break;
      default:
        centerText = 'A-Level Exercises Books';
        centerImagePaths = ['assets/book_center.png'];
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

  Widget _buildJellyInfoButton(BuildContext context) {
    final screenSize = _getScreenSize(context);
    final buttonSize = switch (screenSize) {
      ScreenSize.small => 40.0,
      ScreenSize.medium => 50.0,
      ScreenSize.large => 60.0,
    };
    final infoButtonWidth = switch (screenSize) {
      ScreenSize.small => 70.0,
      ScreenSize.medium => 90.0,
      ScreenSize.large => 110.0,
    };

    return MouseRegion(
      onEnter: (_) => _startAnimation(),
      onExit: (_) => _reverseAnimation(),
      child: GestureDetector(
        onTap: () => _showInfoList ? _reverseAnimation() : _startAnimation(),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.elasticOut,
                  transform: Matrix4.identity()
                    ..translate(0.0, _showInfoList ? -15.0 : 0.0)
                    ..scale(_showInfoList ? 1.3 : 1.0),
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
                          blurRadius: _showInfoList ? 15 : 8,
                          spreadRadius: _showInfoList ? 3 : 1.5,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/little_robot.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.help_outline,
                        color: Colors.purple.shade700,
                        size: buttonSize * 0.6,
                      ),
                    ),
                  ),
                ),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOutCubic,
                    width: infoButtonWidth,
                    height:
                        _heightAnimation.value *
                        (screenSize == ScreenSize.small ? 0.7 : 1.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(
                            _showInfoList ? 0.7 : 0.5,
                          ),
                          blurRadius: _showInfoList ? 20 : 12,
                          spreadRadius: _showInfoList ? 4 : 2.5,
                          offset: Offset(0, _showInfoList ? 10 : 6),
                        ),
                      ],
                    ),
                    child: Material(
                      elevation: _showInfoList ? 15 : 10,
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.purple.shade700,
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
                                turns: _showInfoList ? 0.5 : 0.0,
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
                                opacity: _showInfoList ? 0.0 : 1.0,
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
                              if (_showInfoList) ...[
                                SizedBox(
                                  height: screenSize == ScreenSize.small
                                      ? 6
                                      : 8,
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: _showInfoList
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
                              if (_showInfoList)
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: List.generate(
                                        infoItems.length,
                                        (index) => AnimatedContainer(
                                          duration: Duration(
                                            milliseconds: 200 + (index * 50),
                                          ),
                                          curve: Curves.easeOutBack,
                                          transform: Matrix4.identity()
                                            ..translate(
                                              _showInfoList ? 0.0 : 20.0,
                                              0.0,
                                            ),
                                          child: AnimatedOpacity(
                                            duration: Duration(
                                              milliseconds: 300 + (index * 100),
                                            ),
                                            opacity: _showInfoList ? 1.0 : 0.0,
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
                                                color: Colors.white.withOpacity(
                                                  0.15,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                infoItems[index],
                                                style: GoogleFonts.fredoka(
                                                  fontSize:
                                                      screenSize ==
                                                          ScreenSize.small
                                                      ? 10
                                                      : 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  letterSpacing: 0.3,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
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

  Widget _buildResponsiveContent(BuildContext context) {
    final screenSize = _getScreenSize(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize == ScreenSize.small ? 16 : 24,
        vertical: 20,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1400),
          child: screenSize == ScreenSize.small
              ? Column(
                  children: [
                    _buildCenterBookImage(context),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLeftImageColumn(leftImages, context),
                        const SizedBox(width: 16),
                        _buildRightImageColumn(rightImages, context),
                      ],
                    ),
                    const SizedBox(height: 80),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLeftImageColumn(leftImages, context),
                    const SizedBox(width: 24),
                    _buildCenterBookImage(context),
                    const SizedBox(width: 24),
                    _buildRightImageColumn(rightImages, context),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildResponsiveBottomNavBar(BuildContext context) {
    final screenSize = _getScreenSize(context);
    final barHeight = switch (screenSize) {
      ScreenSize.small => 60.0,
      ScreenSize.medium => 70.0,
      ScreenSize.large => 80.0,
    };
    final iconSize = switch (screenSize) {
      ScreenSize.small => 22.0,
      ScreenSize.medium => 26.0,
      ScreenSize.large => 30.0,
    };
    final buttonSize = switch (screenSize) {
      ScreenSize.small => 44.0,
      ScreenSize.medium => 52.0,
      ScreenSize.large => 60.0,
    };

    return BottomAppBar(
      color: Colors.purple.shade700,
      height: barHeight,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_actionIcons.length, (index) {
              final color = _actionIcons[index]['color'] as Color;
              final horizontalPadding = switch (screenSize) {
                ScreenSize.small => 4.0,
                ScreenSize.medium => 6.0,
                ScreenSize.large => 8.0,
              };

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: MouseRegion(
                  onEnter: (_) => setState(() => _hoveredIndex = index),
                  onExit: (_) => setState(() => _hoveredIndex = null),
                  child: GestureDetector(
                    onTap: () {},
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      transform: Matrix4.identity()
                        ..translate(
                          0.0,
                          _hoveredIndex == index ? -12.0 : 0.0,
                          0.0,
                        ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                _hoveredIndex == index ? 0.3 : 0.15,
                              ),
                              blurRadius: _hoveredIndex == index ? 15 : 8,
                              spreadRadius: _hoveredIndex == index ? 1.5 : 1.0,
                              offset: Offset(0, _hoveredIndex == index ? 8 : 4),
                            ),
                          ],
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(16),
                          elevation: _hoveredIndex == index ? 8 : 4,
                          color: color,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {},
                            child: Container(
                              width: buttonSize,
                              height: buttonSize,
                              padding: EdgeInsets.all(
                                screenSize == ScreenSize.small ? 8 : 10,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _actionIcons[index]['icon'],
                                    color: Colors.white,
                                    size: iconSize,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _actionIcons[index]['label'],
                                    style: GoogleFonts.fredoka(
                                      fontSize: screenSize == ScreenSize.small
                                          ? 10
                                          : 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
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
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextBar(BuildContext context) {
    final screenSize = _getScreenSize(context);
    final barHeight = switch (screenSize) {
      ScreenSize.small => 36.0,
      ScreenSize.medium => 40.0,
      ScreenSize.large => 48.0,
    };
    final horizontalPadding = switch (screenSize) {
      ScreenSize.small => 12.0,
      ScreenSize.medium => 16.0,
      ScreenSize.large => 24.0,
    };

    return Container(
      height: barHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade600, Colors.purple.shade400],
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
                  children: _animatedTexts[_currentTextIndex].map((text) {
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
                  'Learning Adventure',
                  style: GoogleFonts.fredoka(
                    color: Colors.white,
                    fontSize: screenSize == ScreenSize.medium ? 20 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Row(
                  children: _animatedTexts[_currentTextIndex].map((text) {
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

  @override
  Widget build(BuildContext context) {
    final screenSize = _getScreenSize(context);
    final ninjaSize = switch (screenSize) {
      ScreenSize.small => 180.0,
      ScreenSize.medium => 240.0,
      ScreenSize.large => 300.0,
    };
    final ninjaBottom = switch (screenSize) {
      ScreenSize.small => -70.0,
      ScreenSize.medium => -90.0,
      ScreenSize.large => -110.0,
    };
    final infoButtonRight = switch (screenSize) {
      ScreenSize.small => 16.0,
      ScreenSize.medium => 60.0,
      ScreenSize.large => 90.0,
    };
    final infoButtonBottom = switch (screenSize) {
      ScreenSize.small => 16.0,
      ScreenSize.medium => 0.0,
      ScreenSize.large => 0.0,
    };

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: _buildResponsiveAppBar(context),
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
                    child: Image.asset(
                      'assets/ninja.png',
                      height: ninjaSize,
                      width: ninjaSize,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.school,
                        size: ninjaSize * 0.2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: infoButtonRight,
                  bottom: infoButtonBottom,
                  child: _buildJellyInfoButton(context),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildResponsiveBottomNavBar(context),
    );
  }
}

enum ScreenSize { small, medium, large }

class CustomSearchDelegate extends SearchDelegate {
  final List<String> suggestions = [
    '📚 Pre-School Apps',
    '➕ KS2 Math',
    '🧠 11+ Apps',
    '📘 GCSE Maths',
    '🧪 A-Level Physics',
  ];

  final List<Color> suggestionColors = [
    Colors.pink.shade100,
    Colors.lightBlue.shade100,
    Colors.orange.shade100,
    Colors.green.shade100,
    Colors.purple.shade100,
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.purple.shade700,
        elevation: 4,
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.fredoka(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: GoogleFonts.fredoka(color: Colors.white70),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.purple.shade600,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear, color: Colors.white),
      onPressed: () => query = '',
    ),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 500),
        tween: Tween(begin: 0, end: 1),
        builder: (context, value, child) => Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: Card(
              elevation: 12,
              color: Colors.amber.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '🎉 You searched for:',
                      style: GoogleFonts.fredoka(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '"$query"',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.fredoka(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Explore Results',
                        style: GoogleFonts.fredoka(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filtered = suggestions
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filtered.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final suggestion = filtered[index];
        final color = suggestionColors[index % suggestionColors.length];
        final emoji = suggestion.substring(0, suggestion.indexOf(' '));
        final text = suggestion.substring(suggestion.indexOf(' ') + 1);

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + index * 100),
          tween: Tween(begin: 0, end: 1),
          builder: (context, value, child) => Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(30 * (1 - value), 0),
              child: child,
            ),
          ),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: color,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 24)),
                ),
              ),
              title: Text(
                text,
                style: GoogleFonts.fredoka(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_rounded,
                color: Colors.purple.shade700,
                size: 28,
              ),
              onTap: () {
                query = text;
                showResults(context);
              },
            ),
          ),
        );
      },
    );
  }
}
