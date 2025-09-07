import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_stack_v2/widgets/search_delegate.dart';

import '../models/page_data.dart';
import '../models/screen_size.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentPageIndex;
  final Function(int) onPageChanged;

  const CustomAppBar({
    super.key,
    required this.currentPageIndex,
    required this.onPageChanged,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget buildLevelLabel(String label, int index, BuildContext context) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final fontSize = screenSize == ScreenSize.small
        ? 12.0
        : screenSize == ScreenSize.medium
        ? 14.0
        : 16.0;
    final isActive = currentPageIndex == index;

    return GestureDetector(
      onTap: () => onPageChanged(index),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize == ScreenSize.small ? 6.0 : 12.0,
            vertical: 4.0,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: screenSize == ScreenSize.small ? 2.0 : 4.0,
          ),
          decoration: BoxDecoration(
            color: isActive
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isActive
                ? Border.all(color: Colors.white.withOpacity(0.5), width: 1)
                : null,
          ),
          child: Text(
            label,
            style: GoogleFonts.fredoka(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.8),
              fontSize: fontSize,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  // Calculate the approximate width needed for navigation items
  double _calculateNavItemsWidth(BuildContext context) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final horizontalPadding = screenSize == ScreenSize.small ? 12.0 : 24.0;
    final horizontalMargin = screenSize == ScreenSize.small ? 4.0 : 8.0;

    // Approximate character width based on font size
    final fontSize = screenSize == ScreenSize.small
        ? 12.0
        : screenSize == ScreenSize.medium
        ? 14.0
        : 16.0;
    final charWidth = fontSize * 0.6; // Rough estimation

    double totalWidth = 0;
    final navItems = [
      'Home',
      'Primary',
      'Pre-School',
      '11+',
      'GCSEs',
      'A-Levels',
    ];

    for (String item in navItems) {
      totalWidth +=
          (item.length * charWidth) + horizontalPadding + horizontalMargin;
    }

    return totalWidth;
  }

  // Calculate if search field should be shown
  bool _shouldShowSearchField(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 900) return false; // Already handled by hamburger menu

    // Calculate space used by other elements
    final logoAndTitleWidth = 300.0; // Approximate width for logo + title
    final rightImageWidth = 64.0; // Right image + padding
    final navItemsWidth = _calculateNavItemsWidth(context);
    final minSearchFieldWidth = 150.0; // Minimum width for search field
    final padding = 32.0; // General padding and margins

    final usedSpace =
        logoAndTitleWidth + rightImageWidth + navItemsWidth + padding;
    final availableSpace = screenWidth - usedSpace;

    return availableSpace >= minSearchFieldWidth;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final showSearchField = _shouldShowSearchField(context);

    if (screenSize == ScreenSize.small) {
      return AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 76, 128),
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
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(onNavigate: (int pageIndex) {}),
              );
            },
          ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu, size: 20, color: Colors.white),
            onSelected: (value) => onPageChanged(value),
            itemBuilder: (context) => List.generate(
              PageData.pageNames.length - 1,
              (index) => PopupMenuItem(
                value: index,
                child: Row(
                  children: [
                    Icon(
                      currentPageIndex == index
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: Colors.purple.shade700,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      PageData.pageNames[index],
                      style: GoogleFonts.fredoka(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return AppBar(
      backgroundColor: const Color.fromARGB(255, 13, 76, 128),
      title: Flexible(
        child: GestureDetector(
          onTap: () => onPageChanged(0),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/navbar_logo.png',
                  height: screenSize == ScreenSize.medium ? 60 : 80,
                  width: screenSize == ScreenSize.medium ? 60 : 80,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.school, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    'Learning Adventure',
                    style: GoogleFonts.fredoka(
                      fontSize: screenSize == ScreenSize.medium ? 22 : 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        // Navigation Items with flexible sizing
        if (screenWidth > 900)
          Flexible(
            flex: showSearchField
                ? 3
                : 4, // Give more space when search is hidden
            child: Container(
              constraints: BoxConstraints(
                maxWidth: showSearchField
                    ? screenWidth * 0.4
                    : screenWidth * 0.6,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildLevelLabel('Home', 0, context),
                  buildLevelLabel('Primary', 1, context),
                  buildLevelLabel('Pre-School', 2, context),
                  buildLevelLabel('11+', 3, context),
                  buildLevelLabel('GCSEs', 4, context),
                  buildLevelLabel('A-Levels', 5, context),
                ],
              ),
            ),
          ),

        // Search Field - only show if there's enough space
        if (screenWidth > 900 && showSearchField)
          Flexible(
            flex: 1,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: screenWidth > 1200 ? 220 : 180,
                minWidth: 150,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: GoogleFonts.fredoka(color: Colors.white70),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  suffixIcon: screenWidth > 1000
                      ? IconButton(
                          icon: const Icon(Icons.mic, color: Colors.white),
                          onPressed: () {},
                        )
                      : null,
                ),
                style: GoogleFonts.fredoka(color: Colors.white),
              ),
            ),
          ),

        // Search icon button - show when search field is hidden but screen is wide enough
        if (screenWidth > 900 && !showSearchField)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(onNavigate: (int pageIndex) {}),
              );
            },
          ),

        // Right side image with responsive sizing
        if (screenWidth > 600)
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8.0),
            child: Image.asset(
              'assets/appbar_right.png',
              height: 40,
              width: 40,
            ),
          ),

        // Hamburger menu for smaller screens
        if (screenWidth <= 900)
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu, color: Colors.white),
            onSelected: (value) => onPageChanged(value),
            itemBuilder: (context) => List.generate(
              PageData.pageNames.length - 1,
              (index) => PopupMenuItem(
                value: index,
                child: Row(
                  children: [
                    Icon(
                      currentPageIndex == index
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: Colors.purple.shade700,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      PageData.pageNames[index],
                      style: GoogleFonts.fredoka(),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
