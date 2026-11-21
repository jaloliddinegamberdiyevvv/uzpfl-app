
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uzpfl_app/widgets/match_card.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen>
    with TickerProviderStateMixin {
  late TabController statusController;
  late TabController competitionController;

  int selectedSeason = 2026;
  int selectedRound = 1;

  bool showRounds = false;

  final List<String> competitions = [
    'Barcha o‘yinlar',
    'Superliga',
    'Proliga',
    'Birinchi liga',
    'U21 Chempionati',
    'U19 Chempionati',
    'O‘zbekiston kubogi',
    'Superliga. O‘tish o‘yini',
    'O‘zbekiston Superkubogi',
  ];

  final List<String> statuses = [
    'Jonli',
    'Bo‘lajak',
    'Tugagan',
  ];

  // Demo uchrashuvlar
  final List<Map<String, dynamic>> matches = [
    {
      'home': 'Paxtakor',
      'away': 'Nasaf',
      'homeLogo': 'assets/images/app_logo.png',
      'awayLogo': 'assets/images/app_logo.png',
      'homeScore': '2',
      'awayScore': '1',
      'competition': 'Superliga',
      'round': 12,
      'date': '13-noyabr, 2026',
      'time': '18:00',
      'status': 'Jonli',
      'minute': '67\'',
    },
    {
      'home': 'Neftchi',
      'away': 'Andijon',
      'homeLogo': 'assets/images/app_logo.png',
      'awayLogo': 'assets/images/app_logo.png',
      'homeScore': '-',
      'awayScore': '-',
      'competition': 'Superliga',
      'round': 12,
      'date': '13-noyabr, 2026',
      'time': '20:00',
      'status': 'Bo‘lajak',
      'minute': '',
    },
    {
      'home': 'Bunyodkor',
      'away': 'Navbahor',
      'homeLogo': 'assets/images/app_logo.png',
      'awayLogo': 'assets/images/app_logo.png',
      'homeScore': '1',
      'awayScore': '1',
      'competition': 'Superliga',
      'round': 11,
      'date': '12-noyabr, 2026',
      'time': '17:00',
      'status': 'Tugagan',
      'minute': '',
    },
    {
      'home': 'Dinamo',
      'away': 'Mash’al',
      'homeLogo': 'assets/images/app_logo.png',
      'awayLogo': 'assets/images/app_logo.png',
      'homeScore': '0',
      'awayScore': '0',
      'competition': 'Proliga',
      'round': 8,
      'date': '14-noyabr, 2026',
      'time': '16:00',
      'status': 'Bo‘lajak',
      'minute': '',
    },
    {
      'home': 'Paxtakor',
      'away': 'Bunyodkor',
      'homeLogo': 'assets/images/app_logo.png',
      'awayLogo': 'assets/images/app_logo.png',
      'homeScore': '3',
      'awayScore': '0',
      'competition': 'O‘zbekiston kubogi',
      'round': 1,
      'date': '10-noyabr, 2026',
      'time': '19:00',
      'status': 'Tugagan',
      'minute': '',
    },
    {
      'home': 'Andijon',
      'away': 'Neftchi',
      'homeLogo': 'assets/images/app_logo.png',
      'awayLogo': 'assets/images/app_logo.png',
      'homeScore': '2',
      'awayScore': '0',
      'competition': 'O‘zbekiston Superkubogi',
      'round': 1,
      'date': '09-noyabr, 2026',
      'time': '18:00',
      'status': 'Tugagan',
      'minute': '',
    },
  ];

  static const Color _dark = Color(0xFF0F172A);
  static const Color _grey = Color(0xFF64748B);
  static const Color _border = Color(0xFFE2E8F0);
  static const Color _blue = Color(0xFF2478E8);
  static const Color _tabBackground = Color(0xFFEFF3F8);

  @override
  void initState() {
    super.initState();

    statusController = TabController(
      length: statuses.length,
      vsync: this,
    );

    competitionController = TabController(
      length: competitions.length,
      vsync: this,
    );

    competitionController.addListener(() {
      if (!competitionController.indexIsChanging) {
        setState(() {
          selectedRound = 1;
          showRounds = false;
        });
      }
    });
  }

  @override
  void dispose() {
    statusController.dispose();
    competitionController.dispose();
    super.dispose();
  }

  // Tanlangan musobaqa
  String get selectedCompetition {
    return competitions[competitionController.index];
  }

  // Musobaqa bo'yicha o'yinlarni filtrlash
  List<Map<String, dynamic>> _getMatches(String status) {
    return matches.where((match) {
      final statusMatch = match['status'] == status;

      final competitionMatch = selectedCompetition == 'Barcha o‘yinlar' ||
          match['competition'] == selectedCompetition;

      final roundMatch = selectedCompetition == 'Barcha o‘yinlar' ||
          match['round'] == selectedRound;

      return statusMatch && competitionMatch && roundMatch;
    }).toList();
  }

  // Har bir tabdagi o'yinlar soni
  int _getCount(String status) {
    return matches.where((match) {
      final competitionMatch = selectedCompetition == 'Barcha o‘yinlar' ||
          match['competition'] == selectedCompetition;

      final roundMatch = selectedCompetition == 'Barcha o‘yinlar' ||
          match['round'] == selectedRound;

      return match['status'] == status &&
          competitionMatch &&
          roundMatch;
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Sahifa sarlavhasi
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
              child: Row(
                children: [
                  Text(
                    'O‘yinlar taqvimi',
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

            // Jonli / Bo'lajak / Tugagan TabBar
            AnimatedBuilder(
              animation: Listenable.merge([
                statusController,
                competitionController,
              ]),
              builder: (context, child) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _tabBackground,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TabBar(
                    controller: statusController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: const EdgeInsets.all(4),
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
                    tabs: [
                      Tab(text: 'Jonli (${_getCount('Jonli')})'),
                      Tab(text: 'Bo‘lajak (${_getCount('Bo‘lajak')})'),
                      Tab(text: 'Tugagan (${_getCount('Tugagan')})'),
                    ],
                  ),
                );
              },
            ),

            // Musobaqalar TabBar
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: _tabBackground,
                borderRadius: BorderRadius.circular(14),
              ),
              child: TabBar(
                controller: competitionController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.all(4),
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

            // Mavsum va Fixture tugmalari
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  const SizedBox(width: 10),
                  Expanded(
                    child: _actionButton(
                      icon: CupertinoIcons.list_bullet,
                      title: 'Fixture',
                      value: '$selectedRound-tur',
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

            // Fixture turlar ro'yxati
            if (showRounds)
              Container(
                margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fixture — turni tanlang',
                      style: GoogleFonts.urbanist(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _dark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(30, (index) {
                        final round = index + 1;
                        final isSelected = selectedRound == round;

                        return CupertinoButton(
                          padding: EdgeInsets.zero,
                          minSize: 0,
                          onPressed: () {
                            setState(() {
                              selectedRound = round;
                              showRounds = false;
                            });
                          },
                          child: Container(
                            width: 65,
                            height: 38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? _blue
                                  : _tabBackground,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Text(
                              '$round-tur',
                              style: GoogleFonts.urbanist(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? Colors.white
                                    : _grey,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 14),

            // O'yinlar ro'yxati
            Expanded(
              child: TabBarView(
                controller: statusController,
                children: [
                  _buildMatchList('Jonli'),
                  _buildMatchList('Bo‘lajak'),
                  _buildMatchList('Tugagan'),
                ],
              ),
            ),
          ],
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
        padding: const EdgeInsets.symmetric(
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
            const SizedBox(width: 9),
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
                  const SizedBox(height: 2),
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
            const Icon(
              CupertinoIcons.chevron_down,
              size: 14,
              color: _grey,
            ),
          ],
        ),
      ),
    );
  }

  // Tanlangan holatdagi o'yinlar
  Widget _buildMatchList(String status) {
    final items = _getMatches(status);

    if (items.isEmpty) {
      return _emptyState();
    }

    return ListView.builder(
      // Floating navigation uchun pastki bo'sh joy
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 110),
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return MatchCard(match: items[index]);
      },
    );
  }

  // Mavsum tanlash
  void _showSeasonSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, sheetSetState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              decoration: const BoxDecoration(
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
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: _tabBackground,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 11,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                selectedRound = 1;
                                showRounds = false;
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
                    const SizedBox(height: 14),
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

  // Bottom Sheet sarlavhasi
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
            color: const Color(0xFFCBD5E1),
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
                    title,
                    style: GoogleFonts.urbanist(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: _dark,
                    ),
                  ),
                  const SizedBox(height: 4),
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
              child: const Icon(
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

  // O'yinlar mavjud bo'lmaganda
  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.sportscourt,
                size: 28,
                color: _grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'O‘yinlar mavjud emas',
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: _dark,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Tanlangan musobaqa, mavsum yoki tur uchun hozircha uchrashuvlar topilmadi.',
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
}
