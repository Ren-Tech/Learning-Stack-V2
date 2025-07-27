import 'dart:async';
import 'package:flutter/material.dart';

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

  final List<String> leftImages = ['/left_1.jpg', '/left_2.png', '/left_3.png'];
  final List<String> rightImages = [
    '/right_1.png',
    '/right_2.png',
    '/right_3.png',
    '/right_4.png',
    '/amazon.png',
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
  int _currentImageSet = 0; // 0-5 for different sets

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
        _currentImageSet = (_currentImageSet + 1) % 6; // Cycle through 0-5
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

  // Helper method to determine if we're on mobile
  bool _isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  // Helper method to determine if we're on tablet
  bool _isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 768 && width < 1024;
  }

  Widget buildLevelLabel(String label, BuildContext context) {
    final isMobile = _isMobile(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 4.0 : 8.0),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: isMobile ? 12 : 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildResponsiveAppBar(BuildContext context) {
    final isMobile = _isMobile(context);
    final isTablet = _isTablet(context);

    if (isMobile) {
      return AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 60, 107),
        title: Row(
          children: [
            Image.asset(
              'assets/navbar_logo.png',
              height: 40,
              width: 40,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.school, size: 30),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Learning App',
                style: TextStyle(fontSize: 16, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.white),
            onSelected: (value) {
              // Handle menu selection
            },
            itemBuilder: (context) =>
                ['Pre-School', 'Primary', '11+', 'GCSEs', 'A-Levels']
                    .map(
                      (level) =>
                          PopupMenuItem(value: level, child: Text(level)),
                    )
                    .toList(),
          ),
        ],
      );
    }

    return AppBar(
      backgroundColor: const Color.fromARGB(255, 3, 60, 107),
      title: Row(
        children: [
          Image.asset(
            'assets/navbar_logo.png',
            height: isTablet ? 80 : 100,
            width: isTablet ? 80 : 100,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.school),
          ),
        ],
      ),
      actions: [
        if (!isMobile) ...[
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
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: isTablet ? 80 : 100,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: Colors.white70),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset('/appbar_right.png'),
          ),
        ],
      ],
    );
  }

  Widget _buildLeftImageColumn(List<String> images, BuildContext context) {
    final isMobile = _isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = isMobile
        ? screenWidth * 0.25
        : (screenWidth < 1024 ? 150 : 220);

    if (_currentImageSet == 5) {
      // Page 6 set - mobile adaptation
      return SizedBox(
        width: imageWidth.toDouble(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                '/page6_left.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.image,
                  size: isMobile ? 80 : 150,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: isMobile ? 10 : 20),
            Text(
              'Our commitments to Excellence',
              style: TextStyle(
                fontSize: isMobile ? 14 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: isMobile ? 5 : 10),
            Text(
              'Empowering every child to discover the joy of learning & achieve their full potential.',
              style: TextStyle(fontSize: isMobile ? 10 : 14),
            ),
            SizedBox(height: isMobile ? 5 : 10),
            Text(
              '- To inspire and equip children with the skills and confidence to learn effectively & pursue their curiosity.',
              style: TextStyle(fontSize: isMobile ? 10 : 14),
            ),
            SizedBox(height: isMobile ? 5 : 10),
            Text(
              '- Guiding children to become confident, lifelong learners who love to explore & grow.',
              style: TextStyle(fontSize: isMobile ? 10 : 14),
            ),
          ],
        ),
      );
    }

    String left1Image;
    String left2Image;
    String left3Image;
    String left4Image;
    String? leftText;

    switch (_currentImageSet) {
      case 0:
        left1Image = images[0];
        left2Image = images[1];
        left3Image = images[2];
        left4Image = '';
        leftText = 'A-Level Apps';
        break;
      case 1:
        left1Image = '/page2_left.jpg';
        left2Image = images[1];
        left3Image = images[2];
        left4Image = '';
        leftText = 'GCSE Apps';
        break;
      case 2:
        left1Image = '/page3_left1.jpg';
        left2Image = '/page3_left2.png';
        left3Image = images[2];
        left4Image = '';
        leftText = '11+ Apps';
        break;
      case 3:
        left1Image = '/page4_left1.png';
        left2Image = '/page4_left2.jpg';
        left3Image = '/page4_left3.jpg';
        left4Image = '';
        leftText = 'KS2 Apps';
        break;
      case 4:
        left1Image = '/page5_left1.png';
        left2Image = '/page5_left2.png';
        left3Image = '/page5_left3.png';
        left4Image = '/page5_left4.png';
        leftText = null;
        break;
      default:
        left1Image = images[0];
        left2Image = images[1];
        left3Image = images[2];
        left4Image = '';
        leftText = 'A-Level Apps';
    }

    return SizedBox(
      width: imageWidth.toDouble(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildImageItem(left1Image, context),
          if (leftText != null)
            Padding(
              padding: EdgeInsets.only(bottom: isMobile ? 5 : 10),
              child: Text(
                leftText,
                style: TextStyle(
                  fontSize: isMobile ? 12 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          _buildImageItem(left2Image, context),
          _buildImageItem(left3Image, context),
          if (left4Image.isNotEmpty) _buildImageItem(left4Image, context),
        ],
      ),
    );
  }

  Widget _buildRightImageColumn(List<String> images, BuildContext context) {
    final isMobile = _isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = isMobile
        ? screenWidth * 0.25
        : (screenWidth < 1024 ? 150 : 220);

    if (_currentImageSet == 5) {
      // Page 6 set - mobile adaptation
      return SizedBox(
        width: imageWidth.toDouble(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Main Assessment Button - smaller on mobile
                Container(
                  width: isMobile ? 80 : 120,
                  height: isMobile ? 80 : 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[800],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Instant Assessment\nPowered by kAI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 10 : 14,
                      ),
                    ),
                  ),
                ),
                // Assessment options - smaller on mobile
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
          '/page3_right1.png',
          '/page3_right2.png',
          '/page3_right3.png',
          '/page3_right4.png',
          '/page3_right5.png',
          '/page3_right6.png',
        ];
        break;
      case 3:
        rightText = 'KS2 Test Papers';
        rightImagePaths = [
          '/page4_right1.png',
          '/page4_right2.png',
          '/page4_right3.png',
          '/page4_right4.png',
          '/amazon.png',
        ];
        break;
      case 4:
        rightText = null;
        rightImagePaths = ['/page5_right1.png', '/page5_right2.png'];
        break;
      default:
        rightText = 'A-Level Exam Papers';
        rightImagePaths = images;
    }

    return SizedBox(
      width: imageWidth.toDouble(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (rightText != null)
            Padding(
              padding: EdgeInsets.only(bottom: isMobile ? 5 : 10),
              child: Text(
                rightText,
                style: TextStyle(
                  fontSize: isMobile ? 12 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          for (int i = 0; i < rightImagePaths.length; i++)
            Column(
              children: [
                if (_currentImageSet == 4)
                  Padding(
                    padding: EdgeInsets.only(bottom: isMobile ? 2 : 4),
                    child: Text(
                      'Activity Book ${i + 1}',
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                  ),
                _currentImageSet < 2 && i < 4
                    ? _buildImageItemWithCircle(
                        rightImagePaths[i],
                        circleIndex: i,
                        context: context,
                      )
                    : _buildImageItem(rightImagePaths[i], context),
              ],
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
    final isMobile = _isMobile(context);
    final colors = [Colors.red, Colors.green, Colors.orange, Colors.purple];
    final size = isMobile ? 40.0 : 60.0;

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
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 8 : 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Offset _getAssessmentOptionOffset(int position, BuildContext context) {
    final isMobile = _isMobile(context);
    final offset = isMobile ? 50.0 : 80.0;

    switch (position) {
      case 0: // Top
        return Offset(0, -offset);
      case 1: // Right
        return Offset(offset, 0);
      case 2: // Bottom
        return Offset(0, offset);
      case 3: // Left
        return Offset(-offset, 0);
      default:
        return Offset.zero;
    }
  }

  Widget _buildImageItemWithCircle(
    String imagePath, {
    required int circleIndex,
    required BuildContext context,
  }) {
    final isMobile = _isMobile(context);
    List<String> circleImages = [
      'assets/circle_1.png',
      'assets/circle_2.png',
      'assets/circle_3.png',
      'assets/circle_4.png',
    ];

    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 5 : 10),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: isMobile ? 5 : 10),
          Container(
            width: isMobile ? 30 : 40,
            height: isMobile ? 30 : 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(circleImages[circleIndex]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageItem(String imagePath, BuildContext context) {
    final isMobile = _isMobile(context);

    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 5 : 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: isMobile ? 60 : 100,
            color: Colors.grey[300],
            child: Icon(Icons.image, size: isMobile ? 30 : 50),
          ),
        ),
      ),
    );
  }

  Widget _buildCenterBookImage(BuildContext context) {
    final isMobile = _isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final centerWidth = isMobile
        ? screenWidth * 0.4
        : (screenWidth < 1024 ? 300 : 400);

    if (_currentImageSet == 5) {
      // Page 6 set
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              '/page6_center1.png',
              width: centerWidth.toDouble(),
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.image,
                size: isMobile ? 100 : 150,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 10 : 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              '/page6_center2.png',
              width: centerWidth.toDouble(),
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.image,
                size: isMobile ? 100 : 150,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      );
    }

    String centerText;
    Widget centerImage;

    switch (_currentImageSet) {
      case 0:
        centerText = 'A-Level Exercises Books';
        centerImage = Image.asset(
          '/book_center.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.menu_book,
            size: isMobile ? 100 : 150,
            color: Colors.blue,
          ),
        );
        break;
      case 1:
        centerText = 'GCSE Exercise Books';
        centerImage = Image.asset(
          '/page2_center.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.menu_book,
            size: isMobile ? 100 : 150,
            color: Colors.blue,
          ),
        );
        break;
      case 2:
        centerText = 'Exercise Books';
        centerImage = Image.asset(
          '/page3_center_top.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.menu_book,
            size: isMobile ? 100 : 150,
            color: Colors.blue,
          ),
        );
        break;
      case 3:
        centerText = 'KS2 Exercise Books';
        centerImage = Image.asset(
          '/page3_center_bottom.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.menu_book,
            size: isMobile ? 100 : 150,
            color: Colors.blue,
          ),
        );
        break;
      case 4:
        centerText = 'Activity Books Collection';
        centerImage = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 1; i <= 5; i++)
              Padding(
                padding: EdgeInsets.only(bottom: isMobile ? 4 : 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    '/page5_center$i.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.menu_book,
                      size: isMobile ? 30 : 50,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
          ],
        );
        break;
      default:
        centerText = 'A-Level Exercises Books';
        centerImage = Image.asset(
          '/book_center.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.menu_book,
            size: isMobile ? 100 : 150,
            color: Colors.blue,
          ),
        );
    }

    return Stack(
      children: [
        if (!isMobile)
          Positioned(
            top: 100,
            left: 100,
            child: Text(
              centerText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ),
        Container(
          width: centerWidth.toDouble(),
          constraints: BoxConstraints(maxWidth: centerWidth.toDouble()),
          child: Column(
            children: [
              if (isMobile)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    centerText,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              AspectRatio(aspectRatio: 1, child: centerImage),
            ],
          ),
        ),
        if (!isMobile)
          Positioned(
            top: 290,
            left: 150,
            child: _buildImageItem('/amazon.png', context),
          ),
      ],
    );
  }

  Widget _buildJellyInfoButton(BuildContext context) {
    final isMobile = _isMobile(context);

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
                    ..translate(0.0, _showInfoList ? -10.0 : 0.0)
                    ..scale(_showInfoList ? 1.2 : 1.0),
                  child: Container(
                    width: isMobile ? 40 : 50,
                    height: isMobile ? 40 : 50,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: _showInfoList ? 12 : 6,
                          spreadRadius: _showInfoList ? 2 : 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      '/little_robot.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.person,
                        color: Colors.blue,
                        size: isMobile ? 20 : 28,
                      ),
                    ),
                  ),
                ),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOutCubic,
                    width: isMobile ? 70 : 90,
                    height: _heightAnimation.value * (isMobile ? 0.8 : 1.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(
                            _showInfoList ? 0.6 : 0.4,
                          ),
                          blurRadius: _showInfoList ? 15 : 10,
                          spreadRadius: _showInfoList ? 3 : 2,
                          offset: Offset(0, _showInfoList ? 8 : 4),
                        ),
                      ],
                    ),
                    child: Material(
                      elevation: _showInfoList ? 12 : 8,
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(isMobile ? 8 : 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedRotation(
                                turns: _showInfoList ? 0.5 : 0.0,
                                duration: const Duration(milliseconds: 300),
                                child: Icon(
                                  Icons.info,
                                  color: Colors.white,
                                  size: isMobile ? 20 : 26,
                                ),
                              ),
                              SizedBox(height: isMobile ? 4 : 6),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: _showInfoList ? 0.0 : 1.0,
                                child: Text(
                                  'Study\nAssistance',
                                  style: TextStyle(
                                    fontSize: isMobile ? 7 : 9,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    height: 1.1,
                                    letterSpacing: 0.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              if (_showInfoList) ...[
                                SizedBox(height: isMobile ? 6 : 8),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: _showInfoList
                                      ? (isMobile ? 40 : 60)
                                      : 0,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                ),
                                SizedBox(height: isMobile ? 6 : 8),
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
                                                vertical: isMobile ? 2.0 : 3.0,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: isMobile
                                                    ? 4.0
                                                    : 8.0,
                                                vertical: isMobile ? 2.0 : 4.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(
                                                  0.1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                infoItems[index],
                                                style: TextStyle(
                                                  fontSize: isMobile ? 8 : 10,
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
    final isMobile = _isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;

    if (isMobile) {
      // Mobile layout - vertical stack
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            _buildCenterBookImage(context),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLeftImageColumn(leftImages, context),
                const SizedBox(width: 20),
                _buildRightImageColumn(rightImages, context),
              ],
            ),
            const SizedBox(height: 100), // Space for ninja character
          ],
        ),
      );
    } else {
      // Desktop/Tablet layout - horizontal
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  kBottomNavigationBarHeight,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLeftImageColumn(leftImages, context),
                const SizedBox(width: 40),
                _buildCenterBookImage(context),
                const SizedBox(width: 40),
                _buildRightImageColumn(rightImages, context),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildResponsiveBottomNavBar(BuildContext context) {
    final isMobile = _isMobile(context);

    return BottomAppBar(
      color: const Color.fromARGB(255, 3, 60, 107),
      height: isMobile ? 60 : 70,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_actionIcons.length, (index) {
              final color = _actionIcons[index]['color'] as Color;
              final iconSize = isMobile ? 20.0 : 26.0;
              final buttonSize = isMobile ? 40.0 : 50.0;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 3.0 : 6.0),
                child: MouseRegion(
                  onEnter: (_) => setState(() => _hoveredIndex = index),
                  onExit: (_) => setState(() => _hoveredIndex = null),
                  child: GestureDetector(
                    onTap: () {
                      print('Icon ${index + 1} pressed');
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      transform: Matrix4.identity()
                        ..translate(
                          0.0,
                          _hoveredIndex == index ? -10.0 : 0.0,
                          0.0,
                        ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                _hoveredIndex == index ? 0.25 : 0.1,
                              ),
                              blurRadius: _hoveredIndex == index ? 15 : 6,
                              spreadRadius: _hoveredIndex == index ? 1.5 : 1,
                              offset: Offset(0, _hoveredIndex == index ? 8 : 3),
                            ),
                          ],
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(14),
                          elevation: _hoveredIndex == index ? 8 : 3,
                          color: color,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              print('Icon ${index + 1} pressed');
                            },
                            child: Container(
                              width: buttonSize,
                              height: buttonSize,
                              padding: EdgeInsets.all(isMobile ? 8 : 10),
                              child: Icon(
                                _actionIcons[index]['icon'],
                                color: Colors.white,
                                size: iconSize,
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
    final isMobile = _isMobile(context);

    return Container(
      height: isMobile ? 30 : 40,
      color: const Color.fromARGB(255, 3, 107, 8),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 20),
      child: isMobile
          ? Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _animatedTexts[_currentTextIndex].map((text) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          : Row(
              children: [
                const Text(
                  'Learning Simplified',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Row(
                  children: _animatedTexts[_currentTextIndex].map((text) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
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
    final isMobile = _isMobile(context);

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
                // Ninja character - positioned responsively
                Positioned(
                  bottom: isMobile ? -80 : -105,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.asset(
                      '/ninja.png',
                      height: isMobile ? 200 : 300,
                      width: isMobile ? 200 : 300,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.school,
                        size: isMobile ? 40 : 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Info button - positioned responsively
                Positioned(
                  right: isMobile ? 20 : 100,
                  bottom: isMobile ? 20 : -10,
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

// Custom search delegate for mobile search
class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text('Search results for: $query'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = [
      'Pre-School Apps',
      'KS2 Math',
      '11+ Apps',
      'GCSE Maths',
      'A-Level Physics',
    ];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
