import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const MatchEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  static const Color _grey = Color(0xFF64748B);
  static const Color _lightGrey = Color(0xFF94A3B8);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 42,
              color: _lightGrey,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: _grey,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: _lightGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}