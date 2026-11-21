
import 'package:flutter/material.dart';
import 'package:uzpfl_app/screens/match_detail/match_detail_tab_bar.dart';
import 'package:uzpfl_app/screens/match_detail/match_empty_state.dart';
import 'package:uzpfl_app/screens/match_detail/match_header_card.dart';
import 'package:uzpfl_app/screens/match_detail/match_info_tab.dart';
import 'package:uzpfl_app/screens/match_detail/match_lineups_tab.dart';
import 'package:uzpfl_app/screens/match_detail/match_overview_tab.dart';
import 'package:uzpfl_app/screens/match_detail/match_statistics_tab.dart';
import 'package:uzpfl_app/widgets/custom_app_bar.dart';

class MatchDetailScreen extends StatelessWidget {
  final Map<String, dynamic> match;

  const MatchDetailScreen({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    final isLive = match['status'] == 'Jonli';
    final isFinished = match['status'] == 'Tugagan';

    // Bo'lajak o'yin jonli ham, tugagan ham bo'lmagan holat
    final isUpcoming = !isLive && !isFinished;

    final home = match['home']?.toString() ?? 'Mezbonlar';
    final away = match['away']?.toString() ?? 'Mehmonlar';

    final homeLogo = match['homeLogo']?.toString() ?? '';
    final awayLogo = match['awayLogo']?.toString() ?? '';

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: CustomAppBar(title: 'O‘yin statistikasi'),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // O'yinning asosiy kartasi
              SliverToBoxAdapter(
                child: MatchHeaderCard(match: match),
              ),

              // TabBar yuqorida mahkam turadi
              SliverPersistentHeader(
                pinned: true,
                delegate: _TabBarHeaderDelegate(
                  child: const MatchDetailTabBar(),
                ),
              ),
            ];
          },

          // Tab sahifalari
          body: TabBarView(
            children: [
              // Umumiy
              isUpcoming
                  ? const MatchEmptyState(
                      icon: Icons.timeline_rounded,
                      title: 'O‘yin hali boshlanmadi',
                      description:
                          'Uchrashuv boshlangandan so‘ng gollar, assistlar, '
                          'kartochkalar va boshqa voqealar shu yerda ko‘rsatiladi.',
                    )
                  : MatchOverviewTab(
                      home: home,
                      away: away,
                    ),

              // Statistika
              isUpcoming
                  ? const MatchEmptyState(
                      icon: Icons.bar_chart_rounded,
                      title: 'Statistika mavjud emas',
                      description:
                          'Uchrashuv boshlangandan so‘ng to‘p nazorati, '
                          'zarbalar, uzatmalar va boshqa statistikalar ko‘rsatiladi.',
                    )
                  : const MatchStatisticsTab(),

              // Tarkib
              isUpcoming
                  ? const MatchEmptyState(
                      icon: Icons.groups_rounded,
                      title: 'Tarkib hali e’lon qilinmagan',
                      description:
                          'Jamoalarning asosiy tarkibi va zaxira futbolchilari '
                          'haqidagi ma’lumotlar e’lon qilingach shu yerda chiqadi.',
                    )
                  : MatchLineupsTab(
                      home: home,
                      away: away,
                      homeLogo: homeLogo,
                      awayLogo: awayLogo,
                    ),

              // Ma'lumot
              MatchInfoTab(match: match),
            ],
          ),
        ),
      ),
    );
  }
}

// TabBar uchun mahkamlangan sarlavha
class _TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _TabBarHeaderDelegate({
    required this.child,
  });

  static const double _height = 66;

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarHeaderDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
