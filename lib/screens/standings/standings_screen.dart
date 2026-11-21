
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StandingsScreen extends StatefulWidget {
  const StandingsScreen({super.key});

  @override
  State<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  int selectedSeason = 2026;

  // null — Hozirgacha, 1-30 — tanlangan tur
  int? selectedRound;

  bool showRounds = false;

  final List<String> competitions = [
    'Superliga',
    'Proliga',
    'Birinchi liga',
    'U21 Chempionati',
    'U19 Chempionati',
    'O‘zbekiston kubogi',
    'Superliga. O‘tish o‘yini',
    'O‘zbekiston Superkubogi',
    'Proliga. Pley-off',
  ];

  // Superliga jamoalari va turnir jadvali
  final List<Map<String, String>> teams = [
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'Andijon',
      'p': '11',
      'g': '8',
      'd': '1',
      'm': '2',
      'tf': '+12',
      'pts': '26'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'Bunyodkor',
      'p': '11',
      'g': '7',
      'd': '3',
      'm': '1',
      'tf': '+10',
      'pts': '24'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'Buxoro',
      'p': '11',
      'g': '7',
      'd': '2',
      'm': '2',
      'tf': '+8',
      'pts': '23'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'Dinamo',
      'p': '11',
      'g': '6',
      'd': '3',
      'm': '2',
      'tf': '+6',
      'pts': '21'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'Lokomotiv',
      'p': '11',
      'g': '6',
      'd': '2',
      'm': '3',
      'tf': '+5',
      'pts': '20'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'Mash’al',
      'p': '11',
      'g': '5',
      'd': '3',
      'm': '3',
      'tf': '+3',
      'pts': '18'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'Nasaf',
      'p': '11',
      'g': '5',
      'd': '2',
      'm': '4',
      'tf': '+2',
      'pts': '17'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'Navbahor',
      'p': '11',
      'g': '4',
      'd': '4',
      'm': '3',
      'tf': '+1',
      'pts': '16'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'Neftchi',
      'p': '11',
      'g': '4',
      'd': '3',
      'm': '4',
      'tf': '0',
      'pts': '15'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'OKMK',
      'p': '11',
      'g': '4',
      'd': '2',
      'm': '5',
      'tf': '-1',
      'pts': '14'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'Paxtakor',
      'p': '11',
      'g': '3',
      'd': '4',
      'm': '4',
      'tf': '-2',
      'pts': '13'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'Qizilqum',
      'p': '11',
      'g': '3',
      'd': '3',
      'm': '5',
      'tf': '-3',
      'pts': '12'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'Qo‘qon-1912',
      'p': '11',
      'g': '3',
      'd': '2',
      'm': '6',
      'tf': '-4',
      'pts': '11'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'Surxon',
      'p': '11',
      'g': '2',
      'd': '4',
      'm': '5',
      'tf': '-5',
      'pts': '10'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'So‘g‘diyona',
      'p': '11',
      'g': '2',
      'd': '3',
      'm': '6',
      'tf': '-6',
      'pts': '9'
    },
    {
      'logo': 'assets/images/app_logo.png',
      'name': 'Xorazm',
      'p': '11',
      'g': '1',
      'd': '3',
      'm': '7',
      'tf': '-10',
      'pts': '6'
    },
  ];

  static const _dark = Color(0xFF0F172A);
  static const _grey = Color(0xFF64748B);
  static const _border = Color(0xFFE2E8F0);
  static const _blue = Color(0xFF2478E8);
  static const _tabBackground = Color(0xFFEFF3F8);

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: competitions.length,
      vsync: this,
    );

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        setState(() {
          showRounds = false;
        });
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  // Turnirdagi o'ringa qarab rang
  Color _positionColor(int position) {
    if (position == 1) {
      return Color(0xFF22C55E);
    } else if (position == 2) {
      return Color(0xFF86EFAC);
    } else if (position == 3) {
      return Color(0xFFCD7F32);
    } else if (position >= 12 && position <= 15) {
      return Color(0xFFFFB52E);
    } else if (position == 16) {
      return Color(0xFFF04455);
    }

    return Color(0xFFCBD5E1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Sahifa sarlavhasi
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Text(
                  'To‘liq jadval',
                  style: GoogleFonts.urbanist(
                    fontSize: 24,
                    color: _dark,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),

          // Musobaqalar TabBar
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _tabBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: TabBar(
              controller: tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(4),
              dividerColor: Colors.transparent,
              overlayColor: WidgetStateProperty.all(
                Colors.transparent,
              ),
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
              ),
              labelColor: _blue,
              unselectedLabelColor: _grey,
              labelStyle: GoogleFonts.urbanist(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: GoogleFonts.urbanist(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              tabs: competitions.map((item) {
                return Tab(text: item);
              }).toList(),
            ),
          ),

          // Mavsum va tur tanlash
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _actionButton(
                    icon: CupertinoIcons.calendar,
                    title: 'Mavsum',
                    value: '$selectedSeason',
                    onTap: _showSeasonSheet,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _actionButton(
                    icon: CupertinoIcons.list_bullet,
                    title: 'Fixture',
                    value: selectedRound == null
                        ? 'Hozirgacha'
                        : '$selectedRound-tur',
                    onTap: () {
                      setState(() {
                        showRounds = !showRounds;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Tur tanlash ro'yxati
          if (showRounds)
            Container(
              margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Turni tanlang',
                    style: GoogleFonts.urbanist(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _dark,
                    ),
                  ),
                  SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      // Hozirgacha tanlovi
                      _roundButton(
                        title: 'Hozirgacha',
                        isSelected: selectedRound == null,
                        isWide: true,
                        onTap: () {
                          setState(() {
                            selectedRound = null;
                            showRounds = false;
                          });
                        },
                      ),

                      // 1-30-turlar
                      ...List.generate(30, (index) {
                        final round = index + 1;

                        return _roundButton(
                          title: '$round-tur',
                          isSelected: selectedRound == round,
                          onTap: () {
                            setState(() {
                              selectedRound = round;
                              showRounds = false;
                            });
                          },
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),

          SizedBox(height: 14),

          // Tanlangan musobaqa va mavsum kontenti
          Expanded(
            child: _buildSelectedContent(),
          ),
        ],
      ),
    );
  }

  // Tur tanlash tugmasi
  Widget _roundButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    bool isWide = false,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      pressedOpacity: 0.7,
      onPressed: onTap,
      child: Container(
        width: isWide ? 105 : 65,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? _blue : _tabBackground,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          title,
          style: GoogleFonts.urbanist(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : _grey,
          ),
        ),
      ),
    );
  }

  // Mavsum va Fixture tugmalari
  Widget _actionButton({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      pressedOpacity: 0.7,
      onPressed: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _border),
        ),
        child: Row(
          children: [
            Icon(icon, size: 19, color: _blue),
            SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.urbanist(
                      fontSize: 12,
                      color: _grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      color: _dark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              CupertinoIcons.chevron_down,
              size: 14,
              color: _grey,
            ),
          ],
        ),
      ),
    );
  }

  // Tanlangan musobaqa va mavsum kontenti
  Widget _buildSelectedContent() {
    final selectedCompetition = competitions[tabController.index];

    if (selectedCompetition != 'Superliga' || selectedSeason != 2026) {
      return _emptyState();
    }

    return ListView(
  // Added bottom padding (~110px) for floating navigation bar
    padding: const EdgeInsets.only(bottom: 110),
      children: [
        // Jadval nomi
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Superliga',
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _dark,
                  ),
                ),
              ),
              Text(
                '${selectedRound == null ? 'Hozirgacha' : '$selectedRound-tur'} • $selectedSeason',
                style: GoogleFonts.urbanist(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _grey,
                ),
              ),
            ],
          ),
        ),

        _buildStandingsTable(),

        // Jadval izohi
        Container(
          margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _legendItem(
                Color(0xFF22C55E),
                'Elit Chempionlar Ligasi',
              ),
              SizedBox(height: 10),
              _legendItem(
                Color(0xFF86EFAC),
                'Chempionlar Ligasi 2',
              ),
              SizedBox(height: 10),
              _legendItem(
                Color(0xFFCD7F32),
                'Bronza medal',
              ),
              SizedBox(height: 10),
              _legendItem(
                Color(0xFFFFB52E),
                'Quyi ligaga tushish pley-offi',
              ),
              SizedBox(height: 10),
              _legendItem(
                Color(0xFFF04455),
                'Quyi ligaga tushish',
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Turnir jadvali
  Widget _buildStandingsTable() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Jadval sarlavhasi
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 22,
                  child: _headerText('#', center: true),
                ),
                SizedBox(width: 8),
                Expanded(child: _headerText('Jamoa')),
                SizedBox(width: 24, child: _headerText("O‘", center: true)),
                SizedBox(width: 24, child: _headerText('G‘', center: true)),
                SizedBox(width: 24, child: _headerText('D', center: true)),
                SizedBox(width: 24, child: _headerText('M', center: true)),
                SizedBox(width: 34, child: _headerText('T-F', center: true)),
                SizedBox(width: 42, child: _headerText('O', center: true)),
              ],
            ),
          ),

          // Barcha jamoalar
          ...teams.asMap().entries.map((entry) {
            final index = entry.key;
            final team = entry.value;
            final position = index + 1;
            final isLast = index == teams.length - 1;

            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : Border(
                        bottom: BorderSide(
                          color: Color(0xFFF1F5F9),
                          width: 1,
                        ),
                      ),
              ),
              child: Row(
                children: [
                  // O'rin va rangli chiziq
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 3,
                        height: 19,
                        decoration: BoxDecoration(
                          color: _positionColor(position),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: 22,
                        child: Text(
                          '$position',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: _dark,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 8),

                  // Jamoa logosi
                  Image.asset(
                    team['logo']!,
                    width: 22,
                    height: 22,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(width: 8),

                  // Jamoa nomi
                  Expanded(
                    child: Text(
                      team['name']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.urbanist(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _dark,
                      ),
                    ),
                  ),

                  SizedBox(width: 24, child: _teamText(team['p']!)),
                  SizedBox(
                    width: 24,
                    child: _teamText(
                      team['g']!,
                      color: Color(0xFF16A34A),
                    ),
                  ),
                  SizedBox(width: 24, child: _teamText(team['d']!)),
                  SizedBox(
                    width: 24,
                    child: _teamText(
                      team['m']!,
                      color: Color(0xFFDC2626),
                    ),
                  ),
                  SizedBox(
                    width: 34,
                    child: _teamText(
                      team['tf']!,
                      color: team['tf']!.startsWith('-')
                          ? Color(0xFFDC2626)
                          : Color(0xFF16A34A),
                    ),
                  ),

                  // Ochko
                  Container(
                    width: 42,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _teamText(
                      team['pts']!,
                      bold: true,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // Mavsum tanlash Bottom Sheet
  void _showSeasonSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, sheetSetState) {
            return Container(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _sheetHeader(
                      title: 'Mavsumni tanlang',
                      subtitle: 'Kerakli mavsumni belgilang',
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: _tabBackground,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 11,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 6,
                          childAspectRatio: 2.2,
                        ),
                        itemBuilder: (context, index) {
                          final year = 2026 - index;
                          final isSelected = selectedSeason == year;

                          return CupertinoButton(
                            padding: EdgeInsets.zero,
                            minSize: 0,
                            pressedOpacity: 0.7,
                            onPressed: () {
                              sheetSetState(() {
                                selectedSeason = year;
                              });

                              setState(() {
                                selectedSeason = year;
                              });

                              Navigator.pop(sheetContext);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '$year',
                                style: GoogleFonts.urbanist(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected ? _blue : _grey,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      '2016–2026 mavsumlari',
                      style: GoogleFonts.urbanist(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _grey,
                      ),
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

  // Bottom Sheet umumiy sarlavhasi
  Widget _sheetHeader({
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [
        Container(
          width: 38,
          height: 4,
          decoration: BoxDecoration(
            color: Color(0xFFCBD5E1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.urbanist(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: _dark,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _grey,
                    ),
                  ),
                ],
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 0,
              onPressed: () => Navigator.pop(context),
              child: Icon(
                CupertinoIcons.xmark_circle_fill,
                color: Color(0xFFCBD5E1),
                size: 25,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Ma'lumot mavjud bo'lmagan holat
  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.chart_bar,
                size: 28,
                color: _grey,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Ma’lumot mavjud emas',
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: _dark,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Tanlangan musobaqa yoki mavsum uchun hozircha ma’lumot topilmadi.',
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: _grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Rangli nuqta va izoh
  Widget _legendItem(Color color, String title) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.urbanist(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _grey,
          ),
        ),
      ],
    );
  }

  // Jadval ustunlari
  Widget _headerText(String text, {bool center = false}) {
    return Text(
      text,
      textAlign: center ? TextAlign.center : TextAlign.start,
      style: GoogleFonts.urbanist(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: _grey,
      ),
    );
  }

  // Jamoa statistikasi
  Widget _teamText(
    String text, {
    Color color = _dark,
    bool bold = false,
  }) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.urbanist(
        fontSize: 13,
        fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
        color: color,
      ),
    );
  }
}
