import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uzpfl_app/widgets/custom_app_bar.dart';

// Futbolchi rasmi mavjud bo'lsa rasmni, bo'lmasa ism-familiya bosh harflarini ko'rsatadi.
// Rasm yuklanmasa ham avtomatik ravishda bosh harflar ko'rinadi.
Widget _buildPlayerAvatar({
  required String name,
  required Color teamColor,
  required double size,
  String? imageUrl,
}) {
  final initials = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();

  Widget initialsWidget() {
    return Center(
      child: Text(
        initials.isEmpty ? '?' : initials,
        style: GoogleFonts.urbanist(
          color: teamColor,
          fontSize: size * 0.38,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: teamColor.withOpacity(0.10),
      shape: BoxShape.circle,
      border: Border.all(color: teamColor.withOpacity(0.20)),
    ),
    child: ClipOval(
      child: imageUrl != null && imageUrl.trim().isNotEmpty
          ? Image.network(
              imageUrl,
              width: size,
              height: size,
              fit: BoxFit.cover,
              // Rasm URL ishlamasa, futbolchi bosh harflari ko'rsatiladi.
              errorBuilder: (context, error, stackTrace) => initialsWidget(),
            )
          : initialsWidget(),
    ),
  );
}

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  static const Color _primary = Color(0xFF087BFF);
  static const Color _dark = Color(0xFF172033);
  static const Color _grey = Color(0xFF8A94A6);
  static const Color _border = Color(0xFFEDF1F7);

  int _selectedSeason = 2026;

  // Hozir tanlangan liga. Dastlab Superliga ochiladi.
  // Pro liga tanlansa, mavjud Superliga statistikasi ko'rsatilmaydi.
  String _selectedLeague = 'Superliga';

  // Mavsumlar ro'yxati
  final List<int> _seasons = List.generate(11, (index) => 2026 - index);

  // 2026-yil to'purarlar statistikasi
  static const List<Map<String, dynamic>> _scorers = [
    {
      'name': 'Eldor Shomurodov',
      'value': 14,
      'logo': 'B',
      'color': Color(0xFFE6B800),
      'subtitle': 'Bunyodkor',
    },
    {
      'name': 'Jasur Yaxshiboyev',
      'value': 13,
      'logo': 'N',
      'color': Color(0xFFE53935),
      'subtitle': 'Nasaf',
    },
    {
      'name': 'Igor Sergeev',
      'value': 12,
      'logo': 'P',
      'color': Color(0xFF00A6B2),
      'subtitle': 'Paxtakor',
    },
    {
      'name': 'Otabek Shukurov',
      'value': 10,
      'logo': 'N',
      'color': Color(0xFFE53935),
      'subtitle': 'Nasaf',
    },
    {
      'name': 'Javohir Sidiqov',
      'value': 9,
      'logo': 'P',
      'color': Color(0xFF00A6B2),
      'subtitle': 'Paxtakor',
    },
    {
      'name': 'Shahzodbek Masharipov',
      'value': 8,
      'logo': 'B',
      'color': Color(0xFFE6B800),
      'subtitle': 'Bunyodkor',
    },
    {
      'name': 'Dostonbek Hamdamov',
      'value': 7,
      'logo': 'N',
      'color': Color(0xFFE53935),
      'subtitle': 'Nasaf',
    },
  ];

  // 2026-yil assistentlar statistikasi
  static const List<Map<String, dynamic>> _assists = [
    {
      'name': 'Otabek Shukurov',
      'value': 8,
      'logo': 'N',
      'color': Color(0xFFE53935),
      'subtitle': 'Nasaf',
    },
    {
      'name': 'Javohir Sidiqov',
      'value': 7,
      'logo': 'P',
      'color': Color(0xFF00A6B2),
      'subtitle': 'Paxtakor',
    },
    {
      'name': 'Shahzodbek Masharipov',
      'value': 6,
      'logo': 'B',
      'color': Color(0xFFE6B800),
      'subtitle': 'Bunyodkor',
    },
    {
      'name': 'Eldor Shomurodov',
      'value': 5,
      'logo': 'B',
      'color': Color(0xFFE6B800),
      'subtitle': 'Bunyodkor',
    },
    {
      'name': 'Dostonbek Hamdamov',
      'value': 5,
      'logo': 'N',
      'color': Color(0xFFE53935),
      'subtitle': 'Nasaf',
    },
    {
      'name': 'Azizbek Turg‘unboyev',
      'value': 4,
      'logo': 'P',
      'color': Color(0xFF00A6B2),
      'subtitle': 'Paxtakor',
    },
    {
      'name': 'Sardor Rashidov',
      'value': 3,
      'logo': 'B',
      'color': Color(0xFFE6B800),
      'subtitle': 'Bunyodkor',
    },
  ];

  // 2026-yil quruq o'yinlar statistikasi
  static const List<Map<String, dynamic>> _cleanSheets = [
    {
      'name': 'Utkir Yusupov',
      'value': 11,
      'logo': 'N',
      'color': Color(0xFF2673D9),
      'subtitle': 'Nasaf',
    },
    {
      'name': 'Abduvohid Ne‘matov',
      'value': 9,
      'logo': 'B',
      'color': Color(0xFFE6B800),
      'subtitle': 'Bunyodkor',
    },
    {
      'name': 'Sanjar Qosimov',
      'value': 8,
      'logo': 'P',
      'color': Color(0xFF00A6B2),
      'subtitle': 'Paxtakor',
    },
    {
      'name': 'Sardor Rahmonov',
      'value': 7,
      'logo': 'N',
      'color': Color(0xFFE53935),
      'subtitle': 'Nasaf',
    },
    {
      'name': 'Javohir Abdullayev',
      'value': 6,
      'logo': 'P',
      'color': Color(0xFF00A6B2),
      'subtitle': 'Paxtakor',
    },
    {
      'name': 'Bekzod Karimov',
      'value': 5,
      'logo': 'B',
      'color': Color(0xFFE6B800),
      'subtitle': 'Bunyodkor',
    },
    {
      'name': 'Akmal Tursunov',
      'value': 4,
      'logo': 'N',
      'color': Color(0xFFE53935),
      'subtitle': 'Nasaf',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 115),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPageHeader(),
            const SizedBox(height: 18),
            // Superliga va Pro liga o'rtasida tanlov qilish paneli.
            _buildLeagueSelector(),
            const SizedBox(height: 18),
            _buildSeasonCard(),
            const SizedBox(height: 26),
            // Reytinglar faqat Superliga 2026 uchun mavjud.
            // Pro liga yoki boshqa mavsum tanlansa, bo'sh holat chiqariladi.
            if (_selectedLeague == 'Superliga' && _selectedSeason == 2026) ...[
              _buildRankingSection(
                title: 'To‘purarlar',
                icon: Icons.sports_soccer_rounded,
                valueLabel: 'Gol',
                data: _scorers,
                valueIcon: Icons.sports_soccer_rounded,
              ),
              const SizedBox(height: 16),
              _buildRankingSection(
                title: 'Assistentlar',
                icon: Icons.assistant_rounded,
                valueLabel: 'Uzatma',
                data: _assists,
                valueIcon: Icons.assistant_rounded,
              ),
              const SizedBox(height: 16),
              _buildRankingSection(
                title: 'Quruq o‘yinlar',
                icon: Icons.front_hand_rounded,
                valueLabel: 'Quruq o‘yin',
                data: _cleanSheets,
                valueIcon: Icons.front_hand_rounded,
              ),
            ] else
              _buildEmptySeason(),
          ],
        ),
      ),
    );
  }

  // Sahifa sarlavhasi
  Widget _buildPageHeader() {
    return Text(
      'Statistika',
      style: GoogleFonts.urbanist(
        fontSize: 25,
        fontWeight: FontWeight.w800,
        color: _dark,
        letterSpacing: -0.5,
      ),
    );
  }

  // Musobaqani tanlash: Superliga yoki Pro liga.
  // Ushbu panel asosiy sahifada mavsum kartasidan oldin joylashadi.
  // Superliga va Pro liga uchun TabBar.
  // Tanlangan liga ko'k indikator bilan ajratiladi.
  Widget _buildLeagueSelector() {
    return DefaultTabController(
      length: 2,
      initialIndex: _selectedLeague == 'Superliga' ? 0 : 1,
      child: Container(
        height: 55,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border),
          boxShadow: [
            BoxShadow(
              color: _dark.withOpacity(0.035),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TabBar(
          onTap: (index) {
            // Tanlangan tabga qarab liga nomini yangilaymiz.
            setState(() {
              _selectedLeague = index == 0 ? 'Superliga' : 'Pro liga';
            });
          },
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.zero,
          indicator: BoxDecoration(
            color: _primary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _primary.withOpacity(0.20),
                blurRadius: 9,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          labelColor: Colors.white,
          unselectedLabelColor: _grey,
          labelStyle: GoogleFonts.urbanist(
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
          unselectedLabelStyle: GoogleFonts.urbanist(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          tabs: const [
            Tab(
              iconMargin: EdgeInsets.only(bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.emoji_events_rounded, size: 17),
                  SizedBox(width: 7),
                  Text('Superliga'),
                ],
              ),
            ),
            Tab(
              iconMargin: EdgeInsets.only(bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sports_soccer_rounded, size: 17),
                  SizedBox(width: 7),
                  Text('Pro liga'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mavsum kartasi
  Widget _buildSeasonCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF087BFF),
            Color(0xFF0759CE),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: _primary.withOpacity(0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
              const SizedBox(width: 11),

              Expanded(
                child: Text(
                  // Sarlavhada tanlangan liga nomi ko'rsatiladi.
                  _selectedLeague,
                  style: GoogleFonts.urbanist(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              // Mavsum tanlash tugmasi
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: _showSeasonBottomSheet,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.17),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '$_selectedSeason',
                          style: GoogleFonts.urbanist(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            'Mavsum davomida',
            style: GoogleFonts.urbanist(
              color: Colors.white.withOpacity(0.75),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Umumiy statistika',
            style: GoogleFonts.urbanist(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 17),
          // Umumiy ko'rsatkichlar faqat Superliga 2026 uchun chiqariladi.
          if (_selectedLeague == 'Superliga' && _selectedSeason == 2026)
            Row(
              children: [
                _seasonInfo('16', 'Jamoa'),
                _verticalDivider(),
                _seasonInfo('120', 'O‘yin'),
                _verticalDivider(),
                _seasonInfo('75', 'G‘alaba'),
                _verticalDivider(),
                _seasonInfo('25', 'Durang'),
              ],
            )
          else
            Text(
              _selectedLeague == 'Pro liga'
                  ? 'Pro liga statistikasi hozircha mavjud emas'
                  : 'Mavsum statistikasi mavjud emas',
              style: GoogleFonts.urbanist(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  // Mavsum tanlash Bottom Sheet
  void _showSeasonBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Drag handle
                    Container(
                      width: 38,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCE2EA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mavsumni tanlang',
                                style: GoogleFonts.urbanist(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w800,
                                  color: _dark,
                                ),
                              ),
                              Text(
                                'Kerakli mavsum statistikasini ko‘ring',
                                style: GoogleFonts.urbanist(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: _grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFFF3F6FA),
                            foregroundColor: _dark,
                          ),
                          icon: const Icon(
                            Icons.close_rounded,
                            size: 20,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _seasons.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 11,
                        mainAxisSpacing: 11,
                        childAspectRatio: 2.1,
                      ),
                      itemBuilder: (context, index) {
                        final year = _seasons[index];
                        final isSelected = _selectedSeason == year;

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(13),
                            onTap: () {
                              setSheetState(() {
                                _selectedSeason = year;
                              });

                              setState(() {
                                _selectedSeason = year;
                              });

                              Navigator.pop(context);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? _primary
                                    : const Color(0xFFF4F6FA),
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: isSelected
                                      ? _primary
                                      : const Color(0xFFEDF1F7),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$year',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: isSelected ? Colors.white : _dark,
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.check_circle_rounded,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 15,
                          color: _grey,
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            'Hozircha 2026-yil statistikasi mavjud.',
                            style: GoogleFonts.urbanist(
                              fontSize: 11,
                              color: _grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Mavsum ko'rsatkichlari
  Widget _seasonInfo(String value, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: GoogleFonts.urbanist(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              maxLines: 1,
              style: GoogleFonts.urbanist(
                color: Colors.white.withOpacity(0.75),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 34,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      color: Colors.white.withOpacity(0.25),
    );
  }

  // TOP 3 reyting bo'limlari
  Widget _buildRankingSection({
    required String title,
    required IconData icon,
    required String valueLabel,
    required List<Map<String, dynamic>> data,
    required IconData valueIcon,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(13, 14, 13, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
            color: _dark.withOpacity(0.025),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: _primary,
                  size: 19,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.urbanist(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: _dark,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatisticsDetailScreen(
                        title: title,
                        data: data,
                        valueLabel: valueLabel,
                        valueIcon: valueIcon,
                        season: _selectedSeason,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 7,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Barchasi',
                        style: GoogleFonts.urbanist(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _primary,
                        ),
                      ),
                      const SizedBox(width: 3),
                      const Icon(
                        Icons.chevron_right_rounded,
                        size: 20,
                        color: _primary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Asosiy sahifada faqat TOP 3
          ...List.generate(
            data.take(3).length,
            (index) => _buildRankingRow(
              data: data[index],
              index: index,
              valueIcon: valueIcon,
            ),
          ),
        ],
      ),
    );
  }

  // Reytingdagi futbolchi qatori
  Widget _buildRankingRow({
    required Map<String, dynamic> data,
    required int index,
    required IconData valueIcon,
  }) {
    final Color teamColor = data['color'] as Color;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Container(
            width: 27,
            height: 27,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFF0F4FA),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              '${index + 1}',
              style: GoogleFonts.urbanist(
                color: _dark,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 13),
          // TOP 3 reytingida futbolchi rasmi yoki bosh harflari.
          _buildPlayerAvatar(
            name: data['name'] as String,
            teamColor: teamColor,
            size: 37,
            imageUrl: data['image'] as String?,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['name'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.urbanist(
                    color: _dark,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  data['subtitle'] as String,
                  style: GoogleFonts.urbanist(
                    color: _grey,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${data['value']}',
            style: GoogleFonts.urbanist(
              fontSize: 19,
              fontWeight: FontWeight.w900,
              color: _dark,
            ),
          ),
        ],
      ),
    );
  }

  // Tanlangan liga yoki mavsum uchun statistika bo'lmaganda ko'rsatiladigan holat.
  // Pro liga tanlanganda ham shu dizayn orqali xabar chiqariladi.
  Widget _buildEmptySeason() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 38,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: _border),
      ),
      child: Column(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              color: Color(0xFFEAF3FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.query_stats_rounded,
              color: _primary,
              size: 30,
            ),
          ),
          const SizedBox(height: 17),
          Text(
            'Ma’lumot mavjud emas',
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              color: _dark,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            _selectedLeague == 'Pro liga'
                ? 'Pro liga uchun hozircha statistik ma’lumotlar mavjud emas.'
                : '$_selectedSeason-yil mavsumi statistikasi hozircha mavjud emas.',
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              color: _grey,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// STATISTIKA ICHKI SAHIFASI
// ======================================================

class StatisticsDetailScreen extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> data;
  final String valueLabel;
  final IconData valueIcon;
  final int season;

  const StatisticsDetailScreen({
    super.key,
    required this.title,
    required this.data,
    required this.valueLabel,
    required this.valueIcon,
    required this.season,
  });

  static const Color _dark = Color(0xFF172033);
  static const Color _primary = Color(0xFF087BFF);
  static const Color _grey = Color(0xFF8A94A6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            if (season == 2026) ...[
              Text(
                'Barcha futbolchilar',
                style: GoogleFonts.urbanist(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _dark,
                ),
              ),
              const SizedBox(height: 12),
              ...List.generate(data.length, (index) {
                return _buildPlayerCard(data[index], index);
              }),
            ] else
              _buildEmptyState(),
          ],
        ),
      ),
    );
  }

  // Ichki sahifa yuqori kartasi
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF087BFF),
            Color(0xFF0759CE),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$season-YILGI MAVSUM',
                  style: GoogleFonts.urbanist(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  title,
                  style: GoogleFonts.urbanist(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Eng yaxshi natijalar reytingi',
                  style: GoogleFonts.urbanist(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 51,
            height: 51,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              valueIcon,
              color: Colors.white,
              size: 27,
            ),
          ),
        ],
      ),
    );
  }

  // Barcha futbolchilar ro'yxatidagi karta
  Widget _buildPlayerCard(
    Map<String, dynamic> item,
    int index,
  ) {
    final Color teamColor = item['color'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFEDF1F7),
        ),
        boxShadow: [
          BoxShadow(
            color: _dark.withOpacity(0.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 33,
            height: 33,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4FA),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Text(
              '${index + 1}',
              style: GoogleFonts.urbanist(
                color: _dark,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // To'liq futbolchilar ro'yxatida ham shu avatar ishlatiladi.
          _buildPlayerAvatar(
            name: item['name'] as String,
            teamColor: teamColor,
            size: 44,
            imageUrl: item['image'] as String?,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.urbanist(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: _dark,
                  ),
                ),
                Text(
                  item['subtitle'] as String,
                  style: GoogleFonts.urbanist(
                    color: _grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    '${item['value']}',
                    style: GoogleFonts.urbanist(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: _dark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Ma'lumot mavjud bo'lmagan mavsum
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.query_stats_rounded,
            color: _primary,
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(
            'Ma’lumot mavjud emas',
            style: GoogleFonts.urbanist(
              color: _dark,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$season-yil statistikasi hozircha mavjud emas.',
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              color: _grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
