import 'package:flutter/material.dart';
import 'package:learning_stack_v2/models/screen_size.dart';
import '../models/page_data.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int? hoveredIndex;
  final Function(int) onHover;

  const CustomBottomNavBar({
    super.key,
    required this.hoveredIndex,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeUtils.getScreenSize(context);
    final barHeight = screenSize == ScreenSize.small
        ? 60.0
        : screenSize == ScreenSize.medium
        ? 70.0
        : 80.0;
    final iconSize = screenSize == ScreenSize.small
        ? 22.0
        : screenSize == ScreenSize.medium
        ? 26.0
        : 30.0;
    final buttonSize = screenSize == ScreenSize.small
        ? 44.0
        : screenSize == ScreenSize.medium
        ? 52.0
        : 60.0;

    return BottomAppBar(
      color: const Color.fromARGB(255, 9, 6, 22),
      height: barHeight,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(PageData.actionIcons.length, (index) {
              final color = PageData.actionIcons[index]['color'] as Color;
              final horizontalPadding = screenSize == ScreenSize.small
                  ? 4.0
                  : screenSize == ScreenSize.medium
                  ? 6.0
                  : 8.0;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: MouseRegion(
                  onEnter: (_) => onHover(index),
                  onExit: (_) => onHover(-1),
                  child: GestureDetector(
                    onTap: () {},
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      transform: Matrix4.identity()
                        ..translate(
                          0.0,
                          hoveredIndex == index ? -12.0 : 0.0,
                          0.0,
                        ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                hoveredIndex == index ? 0.3 : 0.15,
                              ),
                              blurRadius: hoveredIndex == index ? 15 : 8,
                              spreadRadius: hoveredIndex == index ? 1.5 : 1.0,
                              offset: Offset(0, hoveredIndex == index ? 8 : 4),
                            ),
                          ],
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(16),
                          elevation: hoveredIndex == index ? 8 : 4,
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
                                    PageData.actionIcons[index]['icon'],
                                    color: Colors.white,
                                    size: iconSize,
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
}
