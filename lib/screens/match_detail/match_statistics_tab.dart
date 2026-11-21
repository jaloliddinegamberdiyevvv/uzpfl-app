import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchStatisticsTab extends StatelessWidget {
  const MatchStatisticsTab({super.key});

  static const Color _dark = Color(0xFF0F172A);
  static const Color _grey = Color(0xFF64748B);
  static const Color _border = Color(0xFFE2E8F0);
  static const Color _blue = Color(0xFF2478E8);

  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        'title': 'To‘p nazorati',
        'home': 58,
        'away': 42,
        'suffix': '%',
      },
      {
        'title': 'Zarbalar',
        'home': 14,
        'away': 9,
        'suffix': '',
      },
      {
        'title': 'Aniq zarbalar',
        'home': 7,
        'away': 4,
        'suffix': '',
      },
      {
        'title': 'Noaniq zarbalar',
        'home': 5,
        'away': 3,
        'suffix': '',
      },
      {
        'title': 'Burchak to‘plari',
        'home': 6,
        'away': 4,
        'suffix': '',
      },
      {
        'title': 'Ofsaydlar',
        'home': 2,
        'away': 1,
        'suffix': '',
      },
      {
        'title': 'Qoidabuzarliklar',
        'home': 11,
        'away': 14,
        'suffix': '',
      },
      {
        'title': 'Sariq kartochkalar',
        'home': 1,
        'away': 1,
        'suffix': '',
      },
      {
        'title': 'Paslar',
        'home': 425,
        'away': 318,
        'suffix': '',
      },
      {
        'title': 'Paslar aniqligi',
        'home': 86,
        'away': 79,
        'suffix': '%',
      },
    ];

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Uchrashuv statistikasi', 'Demo ma’lumotlar'),
          _card(
            child: Column(
              children: [
                Row(
                  children: [
                    _teamLabel('Mezbonlar'),
                    const Spacer(),
                    _teamLabel('Mehmonlar'),
                  ],
                ),
                const SizedBox(height: 20),
                ...stats.map((stat) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 19),
                    child: _statItem(
                      title: stat['title'] as String,
                      home: stat['home'] as int,
                      away: stat['away'] as int,
                      suffix: stat['suffix'] as String,
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Statistika haqida',
                  style: _headingStyle(14),
                ),
                const SizedBox(height: 7),
                Text(
                  'Bu sahifadagi ko‘rsatkichlar hozircha namunaviy '
                  'ma’lumotlardan iborat. Haqiqiy o‘yin statistikasi '
                  'API orqali olinadi.',
                  style: _bodyStyle(12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: _headingStyle(16),
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.urbanist(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: _grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: child,
    );
  }

  Widget _statItem({
    required String title,
    required int home,
    required int away,
    required String suffix,
  }) {
    final total = home + away;
    final homePercent = total == 0 ? 0.5 : home / total;

    return Column(
      children: [
        Row(
          children: [
            Text('$home$suffix', style: _headingStyle(13)),
            const Spacer(),
            Text(
              title,
              style: GoogleFonts.urbanist(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _grey,
              ),
            ),
            const Spacer(),
            Text('$away$suffix', style: _headingStyle(13)),
          ],
        ),
        const SizedBox(height: 9),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              Expanded(
                flex: (homePercent * 1000).round().clamp(1, 999),
                child: Container(
                  height: 7,
                  color: _blue,
                ),
              ),
              Expanded(
                flex: ((1 - homePercent) * 1000).round().clamp(1, 999),
                child: Container(
                  height: 7,
                  color: const Color(0xFFE2E8F0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _teamLabel(String title) {
    return Text(
      title,
      style: GoogleFonts.urbanist(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: _grey,
      ),
    );
  }

  TextStyle _headingStyle(double size) {
    return GoogleFonts.urbanist(
      fontSize: size,
      fontWeight: FontWeight.w800,
      color: _dark,
    );
  }

  TextStyle _bodyStyle(double size) {
    return GoogleFonts.urbanist(
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: _grey,
    );
  }
}