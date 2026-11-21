
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _kDark = Color(0xFF0F172A);
const Color _kGrey = Color(0xFF64748B);
const Color _kBorder = Color(0xFFE2E8F0);
const Color _kRed = Color(0xFFEF4444);
const Color _kBlue = Color(0xFF2478E8);
const Color _kGreen = Color(0xFF16A34A);
const Color _kYellow = Color(0xFFEAB308);

// Asosiy tarkibdagi futbolchi
class _Player {
  final String number;
  final String name;
  final String position;
  final int goals;
  final int assists;
  final bool yellow;
  final bool red;
  final String? subOut;

  const _Player({
    required this.number,
    required this.name,
    required this.position,
    this.goals = 0,
    this.assists = 0,
    this.yellow = false,
    this.red = false,
    this.subOut,
  });
}

// Zaxira futbolchisi
class _Sub {
  final String number;
  final String name;
  final String position;
  final String? inMinute;
  final String? replaced;

  const _Sub({
    required this.number,
    required this.name,
    required this.position,
    this.inMinute,
    this.replaced,
  });
}

// Jamoa tarkibi modeli
class _TeamLineup {
  final String formation;
  final List<int> lines;
  final List<_Player> players;
  final List<_Sub> subs;
  final String coach;

  const _TeamLineup({
    required this.formation,
    required this.lines,
    required this.players,
    required this.subs,
    required this.coach,
  });
}

class MatchLineupsTab extends StatefulWidget {
  final String home;
  final String away;
  final String homeLogo;
  final String awayLogo;

  const MatchLineupsTab({
    super.key,
    required this.home,
    required this.away,
    required this.homeLogo,
    required this.awayLogo,
  });

  @override
  State<MatchLineupsTab> createState() => _MatchLineupsTabState();
}

class _MatchLineupsTabState extends State<MatchLineupsTab> {
  int _selected = 0;

  // Mezbonlar tarkibi
  static const _homeLineup = _TeamLineup(
    formation: '4-3-3',
    lines: [1, 4, 3, 3],
    coach: 'Jasur Abduraimov',
    players: [
      _Player(number: '1', name: 'Abduvohid Ne’matov', position: 'Darvozabon'),
      _Player(number: '4', name: 'Husniddin Aliqulov', position: 'Himoyachi'),
      _Player(number: '5', name: 'Rustam Ashurmatov', position: 'Himoyachi'),
      _Player(number: '2', name: 'Sherzod Nasrullayev', position: 'Himoyachi'),
      _Player(number: '3', name: 'Islom To‘xtaxo‘jayev', position: 'Himoyachi'),
      _Player(
        number: '8',
        name: 'Otabek Shukurov',
        position: 'Yarim himoyachi',
        yellow: true,
        subOut: '70\'',
      ),
      _Player(
        number: '6',
        name: 'Aziz Gʻaniyev',
        position: 'Yarim himoyachi',
        assists: 1,
      ),
      _Player(
        number: '10',
        name: 'Jasur Jaloliddinov',
        position: 'Yarim himoyachi',
        goals: 1,
      ),
      _Player(number: '11', name: 'Sherzod Karimov', position: 'Hujumchi'),
      _Player(
        number: '9',
        name: 'Igor Sergeev',
        position: 'Hujumchi',
        subOut: '83\'',
      ),
      _Player(
        number: '7',
        name: 'Dostonbek Hamdamov',
        position: 'Hujumchi',
        subOut: '52\'',
      ),
    ],
    subs: [
      _Sub(
        number: '14',
        name: 'Alisher Odilov',
        position: 'Hujumchi',
        inMinute: '52\'',
        replaced: 'Dostonbek Hamdamov',
      ),
      _Sub(
        number: '16',
        name: 'Muhammadali Rahimov',
        position: 'Yarim himoyachi',
        inMinute: '70\'',
        replaced: 'Otabek Shukurov',
      ),
      _Sub(
        number: '19',
        name: 'Bekzod Ergashev',
        position: 'Hujumchi',
        inMinute: '83\'',
        replaced: 'Igor Sergeev',
      ),
      _Sub(number: '12', name: 'Javlon Ergashev', position: 'Darvozabon'),
      _Sub(number: '15', name: 'Sardor Abdullayev', position: 'Himoyachi'),
      _Sub(number: '17', name: 'Akmal Xolmatov', position: 'Himoyachi'),
      _Sub(number: '18', name: 'Doniyor Karimov', position: 'Yarim himoyachi'),
      _Sub(number: '20', name: 'Umidbek Toirov', position: 'Hujumchi'),
    ],
  );

  // Mehmonlar tarkibi
  static const _awayLineup = _TeamLineup(
    formation: '4-3-3',
    lines: [1, 4, 3, 3],
    coach: 'Timur Kapadze',
    players: [
      _Player(number: '1', name: 'Sardor Qodirqulov', position: 'Darvozabon'),
      _Player(number: '3', name: 'Akmal Mozgovoy', position: 'Himoyachi'),
      _Player(number: '4', name: 'Sardor Rakhmanov', position: 'Himoyachi'),
      _Player(
        number: '5',
        name: 'Abduqodir Husanov',
        position: 'Himoyachi',
        red: true,
      ),
      _Player(number: '2', name: 'Farrux Sayfiyev', position: 'Himoyachi'),
      _Player(
        number: '8',
        name: 'Sardor Rashidov',
        position: 'Yarim himoyachi',
        yellow: true,
        subOut: '60\'',
      ),
      _Player(
        number: '6',
        name: 'Otabek Jo‘raqulov',
        position: 'Yarim himoyachi',
      ),
      _Player(
        number: '10',
        name: 'Abbosbek Fayzullayev',
        position: 'Yarim himoyachi',
        assists: 1,
      ),
      _Player(
        number: '17',
        name: 'Eldor Shomurodov',
        position: 'Hujumchi',
        goals: 1,
      ),
      _Player(
        number: '9',
        name: 'Bobur Abduholiqov',
        position: 'Hujumchi',
        subOut: '72\'',
      ),
      _Player(
        number: '11',
        name: 'Javohir Siddiqov',
        position: 'Hujumchi',
        subOut: '80\'',
      ),
    ],
    subs: [
      _Sub(
        number: '14',
        name: 'Oybek Bozorov',
        position: 'Yarim himoyachi',
        inMinute: '60\'',
        replaced: 'Sardor Rashidov',
      ),
      _Sub(
        number: '16',
        name: 'Shohruh G‘ulomov',
        position: 'Hujumchi',
        inMinute: '72\'',
        replaced: 'Bobur Abduholiqov',
      ),
      _Sub(
        number: '19',
        name: 'Sanjar Tursunov',
        position: 'Hujumchi',
        inMinute: '80\'',
        replaced: 'Javohir Siddiqov',
      ),
      _Sub(number: '12', name: 'Akbar To‘xtayev', position: 'Darvozabon'),
      _Sub(number: '15', name: 'Diyorbek Hamroyev', position: 'Himoyachi'),
      _Sub(number: '18', name: 'Jasurbek Yusupov', position: 'Himoyachi'),
      _Sub(number: '20', name: 'Sardor Mirzayev', position: 'Yarim himoyachi'),
      _Sub(number: '21', name: 'Murodjon Soliyev', position: 'Hujumchi'),
    ],
  );

  TextStyle _heading(double size) => GoogleFonts.urbanist(
        fontSize: size,
        fontWeight: FontWeight.w800,
        color: _kDark,
      );

  TextStyle _body(double size) => GoogleFonts.urbanist(
        fontSize: size,
        fontWeight: FontWeight.w500,
        color: _kGrey,
        height: 1.4,
      );

  @override
  Widget build(BuildContext context) {
    final isHome = _selected == 0;
    final lineup = isHome ? _homeLineup : _awayLineup;
    final teamName = isHome ? widget.home : widget.away;
    final shirtColor = isHome ? _kBlue : const Color(0xFF1E293B);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Jamoa tanlash
          Row(
            children: [
              Expanded(
                child: _teamBox(
                  index: 0,
                  name: widget.home,
                  logo: widget.homeLogo,
                  caption: 'Mezbonlar',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _teamBox(
                  index: 1,
                  name: widget.away,
                  logo: widget.awayLogo,
                  caption: 'Mehmonlar',
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Tarkib sarlavhasi va o'yin sxemasi
          Row(
            children: [
              Expanded(
                child: Text(
                  '$teamName tarkibi',
                  style: _heading(16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF4FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  lineup.formation,
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: _kBlue,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Futbol maydoni
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: KeyedSubtree(
              key: ValueKey(_selected),
              child: _buildPitch(lineup, shirtColor),
            ),
          ),

          const SizedBox(height: 12),
          _buildLegend(),

          const SizedBox(height: 20),

          // Zaxira futbolchilari
          Row(
            children: [
              Expanded(
                child: Text('Zaxira o‘yinchilar', style: _heading(16)),
              ),
              Text(
                '${lineup.subs.length} nafar',
                style: GoogleFonts.urbanist(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _kGrey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          _card(
            child: Column(
              children: [
                ...lineup.subs.asMap().entries.map((entry) {
                  final i = entry.key;

                  return Column(
                    children: [
                      _subRow(entry.value),
                      if (i != lineup.subs.length - 1)
                        const Divider(
                          height: 1,
                          color: Color(0xFFF1F5F9),
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Murabbiy
          Text('Bosh murabbiy', style: _heading(16)),
          const SizedBox(height: 12),

          _card(
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF4FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: _kBlue,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lineup.coach, style: _heading(13)),
                      const SizedBox(height: 3),
                      Text(teamName, style: _body(11)),
                    ],
                  ),
                ),
                const Icon(
                  Icons.sports_rounded,
                  size: 18,
                  color: _kGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Jamoa tanlash kartasi
  Widget _teamBox({
    required int index,
    required String name,
    required String logo,
    required String caption,
  }) {
    final selected = _selected == index;

    return GestureDetector(
      onTap: () => setState(() => _selected = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEEF4FF) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? _kBlue : _kBorder,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              logo,
              width: 30,
              height: 30,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.shield_outlined,
                  size: 30,
                  color: selected ? _kBlue : _kGrey,
                );
              },
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: selected ? _kBlue : _kDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    caption,
                    style: GoogleFonts.urbanist(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _kGrey,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: selected ? 1 : 0,
              child: const Icon(
                Icons.check_circle_rounded,
                size: 18,
                color: _kBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Futbol maydoni
  Widget _buildPitch(_TeamLineup lineup, Color shirtColor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = w * 1.28;

        final positioned = <Widget>[];
        int cursor = 0;
        final lineCount = lineup.lines.length;

        for (int l = 0; l < lineCount; l++) {
          final count = lineup.lines[l];

          double y;

          if (l == 0) {
            y = 0.89;
          } else {
            final outfieldLines = lineCount - 1;
            y = outfieldLines == 1
                ? 0.5
                : 0.70 -
                    (l - 1) * (0.70 - 0.14) / (outfieldLines - 1);
          }

          for (int i = 0; i < count; i++) {
            if (cursor >= lineup.players.length) break;

            final player = lineup.players[cursor++];
            final x = (i + 1) / (count + 1);

            positioned.add(
              Positioned(
                left: x * w - 34,
                top: y * h - 30,
                width: 68,
                child: _pitchPlayer(player, shirtColor),
              ),
            );
          }
        }

        return Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF14532D),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _PitchPainter(),
                  ),
                ),
                ...positioned,
              ],
            ),
          ),
        );
      },
    );
  }

  // Maydondagi bitta futbolchi
  Widget _pitchPlayer(_Player p, Color shirtColor) {
    final lastName = p.name.split(' ').last;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 52,
          height: 42,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: shirtColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  p.number,
                  style: GoogleFonts.urbanist(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),

              // Gol belgisi
              if (p.goals > 0)
                Positioned(
                  top: -2,
                  right: 0,
                  child: _miniBadge(
                    child: const Icon(
                      Icons.sports_soccer_rounded,
                      size: 11,
                      color: _kDark,
                    ),
                  ),
                ),

              // Assist belgisi
              if (p.assists > 0)
                Positioned(
                  top: -2,
                  left: 0,
                  child: _miniBadge(
                    bg: _kBlue,
                    child: const Icon(
                      Icons.assistant_rounded,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),

              // Sariq yoki qizil kartochka
              if (p.yellow || p.red)
                Positioned(
                  bottom: -1,
                  right: 4,
                  child: Container(
                    width: 9,
                    height: 13,
                    decoration: BoxDecoration(
                      color: p.red ? _kRed : _kYellow,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                  ),
                ),

              // Almashtirilgan futbolchi
              if (p.subOut != null)
                Positioned(
                  bottom: -1,
                  left: 0,
                  child: _miniBadge(
                    bg: _kRed,
                    child: const Icon(
                      Icons.arrow_downward_rounded,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 3),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.38),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            lastName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        if (p.subOut != null)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              p.subOut!,
              style: GoogleFonts.urbanist(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  // Kichik belgi
  Widget _miniBadge({
    required Widget child,
    Color bg = Colors.white,
  }) {
    return Container(
      width: 16,
      height: 16,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: child,
    );
  }

  // Maydon belgilarining izohi
  Widget _buildLegend() {
    Widget item(Widget icon, String text) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 5),
          Text(
            text,
            style: GoogleFonts.urbanist(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: _kGrey,
            ),
          ),
        ],
      );
    }

    return _card(
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: [
          item(
            const Icon(
              Icons.sports_soccer_rounded,
              size: 14,
              color: _kDark,
            ),
            'Gol',
          ),
          item(
            const Icon(
              Icons.assistant_rounded,
              size: 14,
              color: _kBlue,
            ),
            'Assist',
          ),
          item(
            Container(
              width: 8,
              height: 11,
              decoration: BoxDecoration(
                color: _kYellow,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            'Sariq',
          ),
          item(
            Container(
              width: 8,
              height: 11,
              decoration: BoxDecoration(
                color: _kRed,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            'Qizil',
          ),
          item(
            const Icon(
              Icons.arrow_downward_rounded,
              size: 14,
              color: _kRed,
            ),
            'Almashtirildi',
          ),
        ],
      ),
    );
  }

  // Zaxira futbolchisi qatori
  Widget _subRow(_Sub s) {
    final played = s.inMinute != null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              s.number,
              style: GoogleFonts.urbanist(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: _kDark,
              ),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.name, style: _heading(12)),
                const SizedBox(height: 3),
                Text(
                  played && s.replaced != null
                      ? '${s.position} · ${s.replaced} o‘rniga'
                      : s.position,
                  style: _body(10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (played)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF7EF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_upward_rounded,
                    size: 12,
                    color: _kGreen,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    s.inMinute!,
                    style: GoogleFonts.urbanist(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: _kGreen,
                    ),
                  ),
                ],
              ),
            )
          else
            Text(
              'Zaxirada',
              style: GoogleFonts.urbanist(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: _kGrey,
              ),
            ),
        ],
      ),
    );
  }

  // Umumiy oq karta
  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: child,
    );
  }
}

// Futbol maydonini chizuvchi
class _PitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Maydon foni
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF2E9E4F),
    );

    // Maydondagi chiziqli o'tlar
    const stripes = 10;
    final stripeH = h / stripes;
    final stripePaint = Paint()..color = const Color(0xFF38AA58);

    for (int i = 0; i < stripes; i += 2) {
      canvas.drawRect(
        Rect.fromLTWH(0, i * stripeH, w, stripeH),
        stripePaint,
      );
    }

    final line = Paint()
      ..color = Colors.white.withOpacity(0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    const m = 10.0;
    final field = Rect.fromLTWH(
      m,
      m,
      w - m * 2,
      h - m * 2,
    );

    // Tashqi chiziq
    canvas.drawRect(field, line);

    // Markaziy chiziq va doira
    canvas.drawLine(
      Offset(field.left, h / 2),
      Offset(field.right, h / 2),
      line,
    );

    canvas.drawCircle(Offset(w / 2, h / 2), w * 0.14, line);

    canvas.drawCircle(
      Offset(w / 2, h / 2),
      3,
      Paint()..color = Colors.white.withOpacity(0.7),
    );

    // Jarima maydonchalari
    final boxW = w * 0.58;
    final boxH = h * 0.15;
    final smallW = w * 0.28;
    final smallH = h * 0.06;

    // Yuqori jarima maydoni
    canvas.drawRect(
      Rect.fromLTWH((w - boxW) / 2, field.top, boxW, boxH),
      line,
    );

    canvas.drawRect(
      Rect.fromLTWH((w - smallW) / 2, field.top, smallW, smallH),
      line,
    );

    // Pastki jarima maydoni
    canvas.drawRect(
      Rect.fromLTWH(
        (w - boxW) / 2,
        field.bottom - boxH,
        boxW,
        boxH,
      ),
      line,
    );

    canvas.drawRect(
      Rect.fromLTWH(
        (w - smallW) / 2,
        field.bottom - smallH,
        smallW,
        smallH,
      ),
      line,
    );

    // Jarima nuqtalari
    final dot = Paint()..color = Colors.white.withOpacity(0.7);

    canvas.drawCircle(
      Offset(w / 2, field.top + h * 0.1),
      2,
      dot,
    );

    canvas.drawCircle(
      Offset(w / 2, field.bottom - h * 0.1),
      2,
      dot,
    );

    // Jarima yoylari
    final arcR = w * 0.11;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(w / 2, field.top + h * 0.1),
        radius: arcR,
      ),
      0.55,
      2.04,
      false,
      line,
    );

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(w / 2, field.bottom - h * 0.1),
        radius: arcR,
      ),
      3.69,
      2.04,
      false,
      line,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
