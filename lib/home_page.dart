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
  int _currentImageSet = 0; // 0 = original, 1 = page2, 2 = page3

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
        _currentImageSet = (_currentImageSet + 1) % 3; // Cycle through 0, 1, 2
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

  Widget buildLevelLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftImageColumn(List<String> images, BuildContext context) {
    String left1Image;
    String left2Image;
    String leftText;

    if (_currentImageSet == 0) {
      // Original set
      left1Image = images[0];
      left2Image = images[1];
      leftText = 'A-Level Apps';
    } else if (_currentImageSet == 1) {
      // Page 2 set
      left1Image = '/page2_left.jpg';
      left2Image = images[1];
      leftText = 'GCSE Apps';
    } else {
      // Page 3 set
      left1Image = '/page3_left1.jpg';
      left2Image = '/page3_left2.png';
      leftText = '11+ Apps';
    }

    return SizedBox(
      width: 220,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildImageItem(left1Image),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              leftText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ),
          _buildImageItem(left2Image),
          _buildImageItem(images[2]),
        ],
      ),
    );
  }

  Widget _buildRightImageColumn(List<String> images, BuildContext context) {
    String rightText;
    List<String> rightImagePaths;

    if (_currentImageSet == 0) {
      // Original set
      rightText = 'A-Level Exam Papers';
      rightImagePaths = images;
    } else if (_currentImageSet == 1) {
      // Page 2 set
      rightText = 'GCSE Exam Papers';
      rightImagePaths = images;
    } else {
      // Page 3 set
      rightText = '11+ Exam Papers';
      rightImagePaths = [
        '/page3_right1.png',
        '/page3_right2.png',
        '/page3_right3.png',
        '/page3_right4.png',
        '/page3_right5.png',
        '/page3_right6.png',
      ];
    }

    return SizedBox(
      width: 220,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              rightText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ),
          for (int i = 0; i < rightImagePaths.length; i++)
            i < 4 && _currentImageSet != 2
                ? _buildImageItemWithCircle(rightImagePaths[i], circleIndex: i)
                : _buildImageItem(rightImagePaths[i]),
        ],
      ),
    );
  }

  Widget _buildImageItemWithCircle(
    String imagePath, {
    required int circleIndex,
  }) {
    List<String> circleImages = [
      'assets/circle_1.png',
      'assets/circle_2.png',
      'assets/circle_3.png',
      'assets/circle_4.png',
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(child: Image.asset(imagePath, fit: BoxFit.cover)),
          const SizedBox(width: 10),
          Container(
            width: 40,
            height: 40,
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

  Widget _buildImageItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }

  Widget _buildCenterBookImage(BuildContext context) {
    String centerText;
    Widget centerImage;

    if (_currentImageSet == 0) {
      // Original set
      centerText = 'A-Level Exercises Books';
      centerImage = Image.asset(
        '/book_center.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.menu_book, size: 150, color: Colors.blue),
      );
    } else if (_currentImageSet == 1) {
      // Page 2 set
      centerText = 'GCSE Exercise Books';
      centerImage = Image.asset(
        '/page2_center.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.menu_book, size: 150, color: Colors.blue),
      );
    } else {
      // Page 3 set
      centerText = '11+ Exercise Books';
      centerImage = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            '/page3_center_top.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.menu_book, size: 75, color: Colors.blue),
          ),
          const SizedBox(height: 10),
          Image.asset(
            '/page3_center_bottom.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.menu_book, size: 75, color: Colors.blue),
          ),
        ],
      );
    }

    return Stack(
      children: [
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
          width: 400,
          constraints: const BoxConstraints(maxWidth: 400),
          child: AspectRatio(aspectRatio: 1, child: centerImage),
        ),
        Positioned(top: 290, left: 150, child: _buildImageItem('/amazon.png')),
      ],
    );
  }

  Widget _buildJellyInfoButton() {
    return MouseRegion(
      onEnter: (_) => _startAnimation(),
      onExit: (_) => _reverseAnimation(),
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
                  width: 50,
                  height: 50,
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
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person, color: Colors.blue, size: 28),
                  ),
                ),
              ),
              ScaleTransition(
                scale: _scaleAnimation,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutCubic,
                  width: 90,
                  height: _heightAnimation.value,
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
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedRotation(
                              turns: _showInfoList ? 0.5 : 0.0,
                              duration: const Duration(milliseconds: 300),
                              child: const Icon(
                                Icons.info,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                            const SizedBox(height: 6),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: _showInfoList ? 0.0 : 1.0,
                              child: const Text(
                                'Study\nAssistance',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  height: 1.1,
                                  letterSpacing: 0.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            if (_showInfoList) ...[
                              const SizedBox(height: 8),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: _showInfoList ? 60 : 0,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                              const SizedBox(height: 8),
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
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 3.0,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 4.0,
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
                                              style: const TextStyle(
                                                fontSize: 10,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 60, 107),
        title: Row(
          children: [
            Image.asset(
              'assets/navbar_logo.png',
              height: 100,
              width: 100,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.school),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildLevelLabel('Pre-School'),
              buildLevelLabel('Primary'),
              buildLevelLabel('11+'),
              buildLevelLabel('GCSEs'),
              buildLevelLabel('A-Levels'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 100,
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
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            color: const Color.fromARGB(255, 3, 107, 8),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  'Learning Simplified',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 500),
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
          ),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
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
                ),
                Positioned(
                  bottom: -105,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.asset(
                      '/ninja.png',
                      height: 300,
                      width: 300,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.school,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 100,
                  bottom: -10,
                  child: _buildJellyInfoButton(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 3, 60, 107),
        height: 70,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_actionIcons.length, (index) {
                final color = _actionIcons[index]['color'] as Color;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _hoveredIndex = index),
                    onExit: (_) => setState(() => _hoveredIndex = null),
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
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                _actionIcons[index]['icon'],
                                color: Colors.white,
                                size: 26,
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
      ),
    );
  }
}
