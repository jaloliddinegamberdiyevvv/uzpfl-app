import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchOverviewTab extends StatelessWidget {
  final String home;
  final String away;

  const MatchOverviewTab({
    super.key,
    required this.home,
    required this.away,
  });

  static const Color _dark = Color(0xFF0F172A);
  static const Color _grey = Color(0xFF64748B);
  static const Color _border = Color(0xFFE2E8F0);
  static const Color _blue = Color(0xFF2478E8);
  static const Color _green = Color(0xFF16A34A);
  static const Color _red = Color(0xFFEF4444);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('O‘yin voqealari', '13 ta voqea'),
          _card(
            child: Column(
              children: [
                _eventRow(
                  minute: '88\'',
                  type: 'red',
                  player: 'Abduqodir Husanov',
                  detail: 'Qizil kartochka',
                  team: away,
                ),
                _eventDivider(),
                _eventRow(
                  minute: '83\'',
                  type: 'sub',
                  player: 'Bekzod Ergashev',
                  detail: 'Igor Sergeev o‘rniga maydonga tushdi',
                  team: home,
                ),
                _eventDivider(),
                _eventRow(
                  minute: '80\'',
                  type: 'sub',
                  player: 'Sanjar Tursunov',
                  detail: 'Javohir Siddiqov o‘rniga maydonga tushdi',
                  team: away,
                ),
                _eventDivider(),
                _eventRow(
                  minute: '78\'',
                  type: 'goal',
                  player: 'Jasur Jaloliddinov',
                  detail: 'Gol',
                  team: home,
                ),
                _eventRow(
                  minute: '78\'',
                  type: 'assist',
                  player: 'Aziz Gʻaniyev',
                  detail: 'Golga assist berdi',
                  team: home,
                ),
                _eventDivider(),
                _eventRow(
                  minute: '72\'',
                  type: 'sub',
                  player: 'Shohruh G‘ulomov',
                  detail: 'Bobur Abduholiqov o‘rniga maydonga tushdi',
                  team: away,
                ),
                _eventDivider(),
                _eventRow(
                  minute: '70\'',
                  type: 'sub',
                  player: 'Muhammadali Rahimov',
                  detail: 'Otabek Shukurov o‘rniga maydonga tushdi',
                  team: home,
                ),
                _eventDivider(),
                _eventRow(
                  minute: '65\'',
                  type: 'yellow',
                  player: 'Sardor Rashidov',
                  detail: 'Sariq kartochka',
                  team: away,
                ),
                _eventDivider(),
                _eventRow(
                  minute: '60\'',
                  type: 'sub',
                  player: 'Oybek Bozorov',
                  detail: 'Sardor Rashidov o‘rniga maydonga tushdi',
                  team: away,
                ),
                _eventDivider(),
                _eventRow(
                  minute: '52\'',
                  type: 'sub',
                  player: 'Alisher Odilov',
                  detail: 'Dostonbek Hamdamov o‘rniga maydonga tushdi',
                  team: home,
                ),
                _eventDivider(),
                _eventRow(
                  minute: '34\'',
                  type: 'goal',
                  player: 'Eldor Shomurodov',
                  detail: 'Gol',
                  team: away,
                ),
                _eventRow(
                  minute: '34\'',
                  type: 'assist',
                  player: 'Abbosbek Fayzullayev',
                  detail: 'Golga assist berdi',
                  team: away,
                ),
                _eventDivider(),
                _eventRow(
                  minute: '21\'',
                  type: 'yellow',
                  player: 'Otabek Shukurov',
                  detail: 'Sariq kartochka',
                  team: home,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _sectionTitle('O‘yin xulosasi', 'Uchrashuv'),
          _card(
            child: Column(
              children: [
                _summaryRow(
                  Icons.sports_soccer_rounded,
                  'Gollar',
                  '1',
                  '1',
                ),
                _summaryDivider(),
                _summaryRow(
                  Icons.style_outlined,
                  'Sariq kartochkalar',
                  '1',
                  '1',
                ),
                _summaryDivider(),
                _summaryRow(
                  Icons.credit_card_rounded,
                  'Qizil kartochkalar',
                  '0',
                  '1',
                ),
                _summaryDivider(),
                _summaryRow(
                  Icons.swap_horiz_rounded,
                  'Almashtirishlar',
                  '3',
                  '3',
                ),
                _summaryDivider(),
                _summaryRow(
                  Icons.flag_outlined,
                  'Burchak to‘plari',
                  '6',
                  '4',
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

  Widget _eventRow({
    required String minute,
    required String type,
    required String player,
    required String detail,
    required String team,
  }) {
    IconData icon;
    Color color;
    String label;

    switch (type) {
      case 'goal':
        icon = Icons.sports_soccer_rounded;
        color = _green;
        label = 'GOL';
        break;
      case 'assist':
        icon = Icons.assistant_rounded;
        color = _blue;
        label = 'ASSIST';
        break;
      case 'yellow':
        icon = Icons.style_rounded;
        color = const Color(0xFFEAB308);
        label = 'SARIQ';
        break;
      case 'red':
        icon = Icons.style_rounded;
        color = _red;
        label = 'QIZIL';
        break;
      default:
        icon = Icons.swap_horiz_rounded;
        color = _blue;
        label = 'ALMASHTIRISH';
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 38,
          child: Text(
            minute,
            style: GoogleFonts.urbanist(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: _dark,
            ),
          ),
        ),
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color.withOpacity(0.10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(player, style: _headingStyle(12)),
              const SizedBox(height: 3),
              Text(detail, style: _bodyStyle(11)),
              const SizedBox(height: 3),
              Text(
                team,
                style: GoogleFonts.urbanist(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: _grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.10),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            label,
            style: GoogleFonts.urbanist(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _eventDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(
        height: 1,
        color: Color(0xFFF1F5F9),
      ),
    );
  }

  Widget _summaryRow(
    IconData icon,
    String title,
    String homeValue,
    String awayValue,
  ) {
    return Row(
      children: [
        Icon(icon, size: 17, color: _grey),
        const SizedBox(width: 9),
        Expanded(
          child: Text(title, style: _bodyStyle(12)),
        ),
        Text(homeValue, style: _headingStyle(13)),
        const SizedBox(width: 28),
        Text(awayValue, style: _headingStyle(13)),
      ],
    );
  }

  Widget _summaryDivider() {
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