import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchInfoTab extends StatelessWidget {
  final Map<String, dynamic> match;

  const MatchInfoTab({
    super.key,
    required this.match,
  });

  static const Color _dark = Color(0xFF0F172A);
  static const Color _grey = Color(0xFF64748B);
  static const Color _border = Color(0xFFE2E8F0);
  static const Color _blue = Color(0xFF2478E8);

  @override
  Widget build(BuildContext context) {
    final info = [
      ['Musobaqa', match['competition']?.toString() ?? 'Superliga'],
      ['Bosqich', '${match['round'] ?? 1}-tur'],
      ['Sana', match['date']?.toString() ?? '17.11.2026'],
      ['Boshlanish vaqti', match['time']?.toString() ?? '18:00'],
      ['Stadion', 'Bunyodkor stadioni'],
      ['Shahar', 'Toshkent'],
      ['Bosh hakam', 'Ilgiz Tantashev'],
      ['Yordamchi hakam', 'Andrey Tsapenko'],
      ['Zaxira hakami', 'Akmal Buriev'],
      ['Tomoshabinlar', '12 450'],
      ['Stadion bandligi', '78%'],
    ];

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            'Uchrashuv ma’lumotlari',
            'Rasmiy ma’lumot',
          ),
          _card(
            child: Column(
              children: [
                ...info.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;

                  return Column(
                    children: [
                      _infoRow(item[0], item[1]),
                      if (index != info.length - 1)
                        _divider(),
                    ],
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF4FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.stadium_outlined,
                    color: _blue,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bunyodkor stadioni',
                        style: _headingStyle(14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Toshkent shahri, O‘zbekiston',
                        style: _bodyStyle(12),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Stadion sig‘imi: 34 000 tomoshabin',
                        style: _bodyStyle(12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Eslatma: barcha qo‘shimcha ma’lumotlar hozircha demo '
            'ko‘rinishida berilgan.',
            style: _bodyStyle(12),
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

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: _bodyStyle(12),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: _headingStyle(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(
        height: 1,
        color: Color(0xFFF1F5F9),
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