import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uzpfl_app/screens/news/news_screen.dart';
import 'package:uzpfl_app/screens/home/top5_standings.dart';
import 'package:uzpfl_app/screens/home/top_news.dart';
import 'package:uzpfl_app/widgets/match_card.dart';
import 'package:uzpfl_app/widgets/section_header.dart';
import 'package:uzpfl_app/widgets/stories_section.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onMatchesTap;
  final VoidCallback onStandingsTap;

  const HomeScreen({
    super.key,
    required this.onMatchesTap,
    required this.onStandingsTap,
  });

  // Demo uchrashuvlar
  final List<Map<String, dynamic>> matches = const [
    {
      'home': 'Paxtakor',
      'away': 'Nasaf',
      'homeLogo': 'assets/images/app_logo.png',
      'awayLogo': 'assets/images/app_logo.png',
      'homeScore': '2',
      'awayScore': '1',
      'competition': 'Superliga',
      'round': '12',
      'date': '13-noyabr, 2026',
      'time': '18:00',
      'status': 'Jonli',
      'minute': '67′',
    },
    {
      'home': 'Bunyodkor',
      'away': 'Neftchi',
      'homeLogo': 'assets/images/app_logo.png',
      'awayLogo': 'assets/images/app_logo.png',
      'homeScore': '',
      'awayScore': '',
      'competition': 'Superliga',
      'round': '13',
      'date': '16-noyabr, 2026',
      'time': '18:00',
      'status': 'Bo‘lajak',
      'minute': '',
    },
    {
      'home': 'Navbahor',
      'away': 'AGMK',
      'homeLogo': 'assets/images/app_logo.png',
      'awayLogo': 'assets/images/app_logo.png',
      'homeScore': '1',
      'awayScore': '1',
      'competition': 'Superliga',
      'round': '12',
      'date': '12-noyabr, 2026',
      'time': '17:00',
      'status': 'Tugagan',
      'minute': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        // Floating navigation uchun pastki bo'sh joy
        padding: const EdgeInsets.only(bottom: 110),
        children: [
          // HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              spacing: 12,
              children: [
                SizedBox(
                  width: 58,
                  height: 58,
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'UZPFL',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF0F172A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'O\'zbekiston Superligasi',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF757575),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // STORIES
          StoriesSection(),

          const SizedBox(height: 16),

          // O'YINLAR SARLAVHASI
          SectionHeader(
            title: 'So\'ngi o\'yinlar',
            actionText: 'Barchasi',
            onActionTap: onMatchesTap,
          ),

          const SizedBox(height: 10),

          // 3 TA MATCH CARD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: matches.map((match) {
                return MatchCard(match: match);
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          // SUPERLIGA JADVALI
          SectionHeader(
            title: 'Superliga Jadvali',
            actionText: 'To\'liq jadval',
            onActionTap: onStandingsTap,
          ),

          const SizedBox(height: 10),

          // TURNIR JADVALI TOP 5
          Top5Standings(),

          const SizedBox(height: 16),

          // YANGILIKLAR
          SectionHeader(
            title: 'Yangiliklar',
            actionText: 'Barchasi',
            onActionTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewsScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          // ENG SO'NGGI 3 TA YANGILIK
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TopNews(),
          ),
        ],
      ),
    );
  }
}
