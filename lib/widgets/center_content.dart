import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/screen_size.dart';

class CenterContent extends StatelessWidget {
  final int currentPageIndex;

  const CenterContent({super.key, required this.currentPageIndex});

  @override
  Widget build(BuildContext context) {
    final availableWidth = MediaQuery.of(context).size.width * 0.4;

    return SizedBox(
      width: availableWidth,
      child: Container(), // Empty container
    );
  }
}
