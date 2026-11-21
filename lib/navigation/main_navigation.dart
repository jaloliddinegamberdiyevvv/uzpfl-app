import 'package:flutter/material.dart';
import 'package:uzpfl_app/screens/home/home_screen.dart';
import 'package:uzpfl_app/screens/matches/matches_screen.dart';
import 'package:uzpfl_app/screens/more/more_screen.dart';
import 'package:uzpfl_app/screens/standings/standings_screen.dart';
import 'package:uzpfl_app/screens/statistics/statistics_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  /// true  -> ikonlar + matn (kengaygan)
  /// false -> faqat ikonlar (yig'ilgan)
  final ValueNotifier<bool> _expanded = ValueNotifier<bool>(true);

  static const Color _activeColor = Color(0xFF2478E8);
  static const Color _inactiveColor = Color(0xFF9AA4B2);

  // Barcha sahifalar
  late final List<Widget> _pages = [
    HomeScreen(
      onMatchesTap: () => _selectTab(1),
      onStandingsTap: () => _selectTab(2),
    ),
    MatchesScreen(),
    StandingsScreen(),
    StatisticsScreen(),
    MoreScreen(),
  ];

  static const List<_NavigationItem> _items = [
    _NavigationItem(label: 'Asosiy', icon: Icons.home_outlined),
    _NavigationItem(label: "O'yinlar", icon: Icons.sports_soccer_outlined),
    _NavigationItem(label: 'Jadval', icon: Icons.table_chart_outlined),
    _NavigationItem(label: 'Statistika', icon: Icons.bar_chart_rounded),
    _NavigationItem(label: "Ko'proq", icon: Icons.more_horiz_rounded),
  ];

  @override
  void dispose() {
    _expanded.dispose();
    super.dispose();
  }

  void _selectTab(int index) {
    setState(() => _selectedIndex = index);
    _expanded.value = true; // tab almashganda doim kengaysin
  }

  bool _onScroll(ScrollNotification n) {
    // Faqat vertikal va eng tashqi scrollable'lar (ichma-ich ro'yxatlar emas)
    if (n.metrics.axis != Axis.vertical) return false;

    final m = n.metrics;

    // Eng tepada bo'lsa — doim kengaygan
    if (m.pixels <= m.minScrollExtent) {
      _expanded.value = true;
      return false;
    }

    if (n is ScrollUpdateNotification) {
      // Pastdagi bounce (overscroll) paytida holatni o'zgartirmaymiz
      if (m.pixels > m.maxScrollExtent) return false;

      final delta = n.scrollDelta ?? 0;
      if (delta > 1) {
        _expanded.value = false; // ozgina pastga scroll -> darrov yig'il
      } else if (delta < -1) {
        _expanded.value = true; // ozgina tepaga scroll -> darrov kengay
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),

          // Floating nav bar
          Positioned(
            left: 16,
            right: 16,
            bottom: 0,
            child: SafeArea(
              top: false,
              minimum: const EdgeInsets.only(bottom: 16),
              child: ValueListenableBuilder<bool>(
                valueListenable: _expanded,
                builder: (context, expanded, _) {
                  return _FloatingNavBar(
                    expanded: expanded,
                    items: _items,
                    selectedIndex: _selectedIndex,
                    activeColor: _activeColor,
                    inactiveColor: _inactiveColor,
                    onTap: _selectTab,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingNavBar extends StatelessWidget {
  const _FloatingNavBar({
    required this.expanded,
    required this.items,
    required this.selectedIndex,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  final bool expanded;
  final List<_NavigationItem> items;
  final int selectedIndex;
  final Color activeColor;
  final Color inactiveColor;
  final ValueChanged<int> onTap;

  static const double _padding = 6;
  static const double _expandedHeight = 65;
  static const double _collapsedHeight = 48;
  static const double _collapsedWidth = 52;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final expandedWidth =
            (constraints.maxWidth - _padding * 2) / items.length;

        return TweenAnimationBuilder<double>(
          tween: Tween<double>(end: expanded ? 1.0 : 0.0),
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          builder: (context, t, _) {
            final itemWidth =
                _lerp(_collapsedWidth, expandedWidth, t); // 52 -> kengaygan
            final itemHeight = _lerp(_collapsedHeight, _expandedHeight, t);

            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(_padding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF263B59).withValues(alpha: 0.12),
                      blurRadius: 24,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: _lerp(_collapsedHeight, _expandedHeight, t),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(items.length, (index) {
                      return _NavItemView(
                        item: items[index],
                        isSelected: selectedIndex == index,
                        width: itemWidth,
                        height: itemHeight,
                        t: t,
                        activeColor: activeColor,
                        inactiveColor: inactiveColor,
                        onTap: () => onTap(index),
                      );
                    }),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;
}

class _NavItemView extends StatelessWidget {
  const _NavItemView({
    required this.item,
    required this.isSelected,
    required this.width,
    required this.height,
    required this.t,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  final _NavigationItem item;
  final bool isSelected;
  final double width;
  final double height;
  final double t; // 0 = yig'ilgan, 1 = kengaygan
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? activeColor : inactiveColor;

    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: onTap,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFEAF2FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.icon, size: 23, color: color),
                  // Matn t ga qarab silliq paydo bo'ladi / yo'qoladi
                  ClipRect(
                    child: Align(
                      alignment: Alignment.topCenter,
                      heightFactor: t,
                      child: Opacity(
                        opacity: t,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            item.label,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              color: color,
                              fontSize: 10,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationItem {
  const _NavigationItem({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}
