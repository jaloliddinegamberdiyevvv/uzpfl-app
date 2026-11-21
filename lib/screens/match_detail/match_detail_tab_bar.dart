import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchDetailTabBar extends StatelessWidget {
  const MatchDetailTabBar({super.key});

  static const Color _grey = Color(0xFF64748B);
  static const Color _blue = Color(0xFF2478E8);
  static const Color _background = Color(0xFFEFF3F8);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(4),
        dividerColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
        ),
        labelColor: _blue,
        unselectedLabelColor: _grey,
        labelStyle: GoogleFonts.urbanist(
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
        unselectedLabelStyle: GoogleFonts.urbanist(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'Umumiy'),
          Tab(text: 'Statistika'),
          Tab(text: 'Tarkib'),
          Tab(text: 'Ma’lumot'),
        ],
      ),
    );
  }
}