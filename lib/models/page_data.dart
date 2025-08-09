import 'package:flutter/material.dart';

class PageData {
  static const List<String> pageNames = [
    'Home',
    'Primary',
    'Pre-School',
    '11+',
    'GCSEs',
    'A-Levels',
    'AI Assessment',
  ];

  static const List<List<String>> pageTexts = [
    ['Our commitments to Excellence', 'Empowering Learning & Growth'],
    ['Welcome to Learning Adventure', 'Explore Educational Resources'],
    ['Pre-School Apps', 'Pre-School Activity Books'],
    ['11+ Apps', '11+ Workbook Series', '11+ Exam Packs'],
    ['GCSE Maths', 'GCSE Chemistry', 'GCSE Biology', 'GCSE Physics'],
    [
      'A-Level Maths',
      'A-Level Chemistry',
      'A-Level Biology',
      'A-Level Physics',
    ],
    ['AI Assessment', 'Powered by kAI Technology'],
  ];

  static const List<Map<String, dynamic>> actionIcons = [
    {'icon': Icons.home, 'label': 'Home', 'color': Colors.orange},
    {'icon': Icons.info, 'label': 'Info', 'color': Colors.blue},
    {'icon': Icons.search, 'label': 'Browse', 'color': Colors.purple},
    {'icon': Icons.public, 'label': 'World', 'color': Colors.pink},
    {'icon': Icons.book, 'label': 'Book', 'color': Colors.yellow},
    {'icon': Icons.edit, 'label': 'Pen', 'color': Colors.blue},
    {'icon': Icons.handshake, 'label': 'Handshake', 'color': Colors.pink},
    {'icon': Icons.email, 'label': 'Email', 'color': Colors.purple},
  ];

  static const List<String> infoItems = [
    'About Us',
    'Contact Information',
    'Privacy Policy',
    'Terms of Service',
    'Help Center',
  ];
}
