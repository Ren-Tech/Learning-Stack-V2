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
            horizontal: screenSize == ScreenSize.small ? 8.0 : 12.0,
            vertical: 6.0,
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
            style: TextStyle(
              fontFamily: 'Fredoka',
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              shadows: [
                Shadow(
                  offset: const Offset(0, 1),
                  blurRadius: 2.0,
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Alternative method using GoogleFonts with fallback
  Widget buildLevelLabelWithFallback(
    String label,
    int index,
    BuildContext context,
  ) {
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
            horizontal: screenSize == ScreenSize.small ? 8.0 : 12.0,
            vertical: 6.0,
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
            style:
                GoogleFonts.fredoka(
                  color: const Color(0xFFFFFFFF),
                  fontSize: fontSize,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                ).copyWith(
                  color: const Color(0xFFFFFFFF),
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 1),
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }

  // Helper method to check if we should use scrolling behavior
  bool _shouldUseScrolling(BuildContext context) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final orientation = MediaQuery.of(context).orientation;

    // Use scrolling for small screens OR portrait orientation
    return screenSize == ScreenSize.small ||
        orientation == Orientation.portrait;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;

    final showSearchField = screenWidth > 1200;
    final shouldUseScrolling = _shouldUseScrolling(context);

    if (screenSize == ScreenSize.small) {
      return AppBar(
        backgroundColor: const Color(0xFF0D4C80),
        elevation: 0,
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
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Fredoka',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 20, color: Color(0xFFFFFFFF)),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(onNavigate: (int pageIndex) {}),
              );
            },
          ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu, size: 20, color: Color(0xFFFFFFFF)),
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
                      style: const TextStyle(fontFamily: 'Fredoka'),
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
      backgroundColor: const Color(0xFF0D4C80),
      elevation: 0,
      title: GestureDetector(
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
                    const Icon(Icons.school, color: Color(0xFFFFFFFF)),
              ),
              const SizedBox(width: 16),
              Text(
                'Learning Adventure',
                style: TextStyle(
                  fontSize: screenSize == ScreenSize.medium ? 22 : 28,
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Fredoka',
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 1),
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        // Navigation Items with horizontal scrolling when needed
        if (screenWidth > 900)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: shouldUseScrolling
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildLevelLabelWithFallback('Home', 0, context),
                        buildLevelLabelWithFallback('Primary', 1, context),
                        buildLevelLabelWithFallback('Pre-School', 2, context),
                        buildLevelLabelWithFallback('11+', 3, context),
                        buildLevelLabelWithFallback('GCSEs', 4, context),
                        buildLevelLabelWithFallback('A-Levels', 5, context),
                      ],
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildLevelLabelWithFallback('Home', 0, context),
                      buildLevelLabelWithFallback('Primary', 1, context),
                      buildLevelLabelWithFallback('Pre-School', 2, context),
                      buildLevelLabelWithFallback('11+', 3, context),
                      buildLevelLabelWithFallback('GCSEs', 4, context),
                      buildLevelLabelWithFallback('A-Levels', 5, context),
                    ],
                  ),
          ),

        // Search Field with scrolling when needed
        if (screenWidth > 1200 && showSearchField)
          shouldUseScrolling
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: const TextStyle(
                          color: Color(0xB3FFFFFF),
                          fontFamily: 'Fredoka',
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0x33FFFFFF),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFFFFFFFF),
                        ),
                        suffixIcon: screenWidth > 1400
                            ? IconButton(
                                icon: const Icon(
                                  Icons.mic,
                                  color: Color(0xFFFFFFFF),
                                ),
                                onPressed: () {},
                              )
                            : null,
                      ),
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'Fredoka',
                      ),
                    ),
                  ),
                )
              : Container(
                  width: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: const TextStyle(
                        color: Color(0xB3FFFFFF),
                        fontFamily: 'Fredoka',
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0x33FFFFFF),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFFFFFFFF),
                      ),
                      suffixIcon: screenWidth > 1400
                          ? IconButton(
                              icon: const Icon(
                                Icons.mic,
                                color: Color(0xFFFFFFFF),
                              ),
                              onPressed: () {},
                            )
                          : null,
                    ),
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontFamily: 'Fredoka',
                    ),
                  ),
                ),

        // Search icon button
        if (screenWidth > 900 && !showSearchField)
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFFFFFFFF)),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(onNavigate: (int pageIndex) {}),
              );
            },
          ),

        // Right side image
        if (screenWidth > 600)
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8.0),
            child: Image.asset(
              'assets/appbar_right.png',
              height: 40,
              width: 40,
            ),
          ),

        // Hamburger menu for smaller screens or when scrolling is needed
        if (screenWidth <= 900 || shouldUseScrolling)
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu, color: Color(0xFFFFFFFF)),
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
                      style: const TextStyle(fontFamily: 'Fredoka'),
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
