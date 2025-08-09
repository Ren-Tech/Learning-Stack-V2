import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchDelegate extends SearchDelegate {
  final void Function(int pageIndex) onNavigate; // callback to change page

  CustomSearchDelegate({required this.onNavigate});

  final List<String> suggestions = [
    '🏠 Home',
    '📚 Pre-School Apps',
    '🧠 11+ Apps',
    '📘 GCSE Maths',
    '🧪 A-Level Physics',
  ];

  final List<Color> suggestionColors = [
    Colors.orangeAccent.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.green.shade100,
    Colors.purple.shade100,
  ];

  int _getPageIndex(String query) {
    final lower = query.toLowerCase();
    if (lower.contains('home')) return 0;
    if (lower.contains('pre-school')) return 2;
    if (lower.contains('11+')) return 3;
    if (lower.contains('gcse')) return 4;
    if (lower.contains('a-level')) return 5;
    return 0; // default to home
  }

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
                      onPressed: () {
                        onNavigate(_getPageIndex(query));
                        close(context, null);
                      },
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
                onNavigate(_getPageIndex(text));
                close(context, null);
              },
            ),
          ),
        );
      },
    );
  }
}
