import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchTeamInfo extends StatelessWidget {
  final String name;
  final String logo;
  final bool right;

  const MatchTeamInfo({
    super.key,
    required this.name,
    required this.logo,
    this.right = false,
  });

  static const Color _dark = Color(0xFF0F172A);
  static const Color _grey = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: right ? 0 : 16,
        right: right ? 16 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            logo,
            width: 48,
            height: 48,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.shield_outlined,
                size: 48,
                color: _grey,
              );
            },
          ),
          const SizedBox(height: 7),
          SizedBox(
            width: double.infinity,
            child: Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.urbanist(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: _dark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}