import 'package:flutter/material.dart';
import 'package:learning_stack_v2/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  int? _hoveredIndex;

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

  // Sample image URLs
  final List<String> leftImages = ['/left_1.jpg', '/left_2.png', '/left_3.png'];
  final List<String> rightImages = [
    '/right_1.png',
    '/right_2.png',
    '/right_3.png',
    '/right_4.png',
    '/amazon.png',
  ];

  Widget buildLevelLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(child: Text(label, style: kWhiteFont)),
    );
  }

  Widget _buildLeftImageColumn(List<String> images, BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildImageItem(images[0]),
          // A-Level Apps text before left_2
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'A-Level Apps',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ),
          _buildImageItem(images[1]),
          _buildImageItem(images[2]),
        ],
      ),
    );
  }

  Widget _buildRightImageColumn(List<String> images, BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // A-Level Exam Papers text above right_1
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'A-Level Exam Papers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ),
          // Only add circles to right_1 to right_4
          for (int i = 0; i < images.length; i++)
            i < 4
                ? _buildImageItemWithCircle(images[i], circleIndex: i)
                : _buildImageItem(images[i]),
        ],
      ),
    );
  }

  // For right_1 to right_4 (with circles)
  Widget _buildImageItemWithCircle(
    String imagePath, {
    required int circleIndex,
  }) {
    // List of circle image paths - adjust these to your actual image paths
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
          // Original image
          Expanded(child: Image.asset(imagePath, fit: BoxFit.cover)),
          SizedBox(width: 10), // Space between images
          // Circular image
          Container(
            width: 40, // Adjust size as needed
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

  // Original image item without circle (for images beyond right_4)
  Widget _buildImageItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }

  Widget _buildCenterBookImage(BuildContext context) {
    return Stack(
      children: [
        // Add text above the center image with reduced padding
        Positioned(
          top: 100,
          left: 100,
          child: Text(
            'A-Level Exercises Books',
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
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              '/book_center.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.menu_book, size: 150, color: Colors.blue),
            ),
          ),
        ),
        Positioned(top: 290, left: 150, child: _buildImageItem('/amazon.png')),
      ],
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
          buildLevelLabel('Pre-School'),
          buildLevelLabel('Primary'),
          buildLevelLabel('11+'),
          buildLevelLabel('GCSEs'),
          buildLevelLabel('A-Levels'),
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
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Main content row
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left images with text
                            _buildLeftImageColumn(leftImages, context),

                            SizedBox(width: constraints.maxWidth * 0.05),

                            // Center book image only
                            _buildCenterBookImage(context),

                            SizedBox(width: constraints.maxWidth * 0.05),

                            // Right images with text
                            _buildRightImageColumn(rightImages, context),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Ninja image
              Positioned(
                bottom: -105,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    '/ninja.png',
                    height: 300,
                    width: 300,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.school, size: 60, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
