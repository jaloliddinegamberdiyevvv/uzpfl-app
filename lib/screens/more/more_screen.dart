import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uzpfl_app/widgets/custom_app_bar.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  static const Color _primary = Color(0xFF087BFF);
  static const Color _dark = Color(0xFF0F172A);
  static const Color _grey = Color(0xFF8491A5);
  static const Color _background = Color(0xFFF5F7FB);

  String _firstName = '';
  String _lastName = '';
  String _language = 'O‘zbekcha';

  bool _notifications = true;
  bool _matchNotifications = true;
  bool _newsNotifications = true;

  final List<String> _favoriteTeams = [];

  final List<String> _teams = [
    'Paxtakor',
    'Nasaf',
    'Neftchi',
    'Navbahor',
    'Bunyodkor',
    'Dinamo',
    'Andijon',
    'So‘g‘diyona',
    'OKMK',
    'Surxon',
    'Qizilqum',
    'Buxoro',
    'Xorazm',
    'Qo‘qon-1912',
  ];

  String get _fullName {
    final name = '$_firstName $_lastName'.trim();
    return name.isEmpty ? 'Ism Familiya' : name;
  }

  // SnackBar
  // Barcha xabarlar uchun yagona SnackBar dizayni
  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: const Color(0xFF111111),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          elevation: 0,
        ),
      );
  }

  // Ichki sahifaga o'tish
  void _openPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  // Profilni tahrirlash
  void _editProfile() {
    final firstController = TextEditingController(text: _firstName);
    final lastController = TextEditingController(text: _lastName);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Profil ma’lumotlari',
            style: TextStyle(
              color: _dark,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstController,
                cursorColor: _primary,
                decoration: _inputDecoration('Ism'),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: lastController,
                cursorColor: _primary,
                decoration: _inputDecoration('Familiya'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Bekor qilish',
                style: TextStyle(color: _grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                setState(() {
                  _firstName = firstController.text.trim();
                  _lastName = lastController.text.trim();
                });
                Navigator.pop(dialogContext);
              },
              child: const Text('Saqlash'),
            ),
          ],
        );
      },
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _grey, fontSize: 14),
      filled: true,
      fillColor: _background,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: _primary, width: 1.2),
      ),
    );
  }

  // Sevimli jamoa qo'shish
  Future<void> _addTeam() async {
    final availableTeams =
        _teams.where((team) => !_favoriteTeams.contains(team)).toList();

    if (availableTeams.isEmpty) {
      _showMessage('Barcha jamoalar qo‘shilgan');
      return;
    }

    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1E6EE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 22),
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Jamoani tanlang',
                        style: TextStyle(
                          color: _dark,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.shield_outlined,
                      color: _primary,
                      size: 23,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sevimli jamoangizni ro‘yxatga qo‘shing',
                    style: TextStyle(color: _grey, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 18),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: availableTeams.length,
                    separatorBuilder: (_, __) => const Divider(
                      height: 1,
                      color: Color(0xFFF0F2F6),
                    ),
                    itemBuilder: (context, index) {
                      final team = availableTeams[index];

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const _TeamLogo(size: 42),
                        title: Text(
                          team,
                          style: const TextStyle(
                            color: _dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.add_circle_outline_rounded,
                          color: _primary,
                          size: 22,
                        ),
                        onTap: () => Navigator.pop(context, team),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null && mounted) {
      setState(() {
        _favoriteTeams.add(selected);
      });
    }
  }

  // Sevimli jamoadan chiqarish
  void _removeTeam(String team) {
    setState(() {
      _favoriteTeams.remove(team);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 115),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ko‘proq',
              style: GoogleFonts.urbanist(
                color: _dark,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.6,
              ),
            ),
            const Text(
              'Shaxsiy kabinet va ilova sozlamalari',
              style: TextStyle(
                color: _grey,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 22),

            // Profil kartasi
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFEDF0F5)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF3FF),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: _primary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _fullName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _dark,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'UZPFL foydalanuvchisi',
                          style: TextStyle(
                            color: _grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _editProfile,
                    style: IconButton.styleFrom(
                      backgroundColor: _background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: _primary,
                      size: 19,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Sevimli jamoalar
            _sectionTitle('SEVIMLI JAMOALAR'),
            const SizedBox(height: 11),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(),
              child: Column(
                children: [
                  if (_favoriteTeams.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: Column(
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: _background,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.shield_outlined,
                              color: _grey,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Hozircha jamoalar yo‘q',
                            style: TextStyle(
                              color: _dark,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Sevimli jamoalaringizni qo‘shing',
                            style: TextStyle(
                              color: _grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ..._favoriteTeams.map(
                      (team) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            const _TeamLogo(size: 42),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                team,
                                style: const TextStyle(
                                  color: _dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _removeTeam(team),
                              icon: const Icon(
                                Icons.close_rounded,
                                color: _grey,
                                size: 19,
                              ),
                              tooltip: 'Olib tashlash',
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: OutlinedButton.icon(
                      onPressed: _addTeam,
                      icon: const Icon(Icons.add_rounded, size: 20),
                      label: const Text(
                        'Jamoa qo‘shish',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _primary,
                        side: const BorderSide(
                          color: Color(0xFFDCEAFF),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Shaxsiy sozlamalar
            _sectionTitle('SHAXSIY SOZLAMALAR'),
            const SizedBox(height: 11),

            Container(
              decoration: _cardDecoration(),
              child: Column(
                children: [
                  _MoreTile(
                    icon: Icons.notifications_none_rounded,
                    title: 'Bildirishnomalar',
                    subtitle: 'Xabarlar va o‘yin yangiliklari',
                    onTap: () => _openPage(
                      NotificationSettingsScreen(
                        notifications: _notifications,
                        matchNotifications: _matchNotifications,
                        newsNotifications: _newsNotifications,
                        onChanged: (all, matches, news) {
                          setState(() {
                            _notifications = all;
                            _matchNotifications = matches;
                            _newsNotifications = news;
                          });
                        },
                      ),
                    ),
                  ),
                  _tileDivider(),
                  _MoreTile(
                    icon: Icons.bookmark_border_rounded,
                    title: 'Sevimli o‘yinlar',
                    subtitle: 'Saqlangan uchrashuvlar',
                    onTap: () => _openPage(
                      const FavoriteMatchesScreen(),
                    ),
                  ),
                  _tileDivider(),
                  _MoreTile(
                    icon: Icons.language_rounded,
                    title: 'Til sozlamalari',
                    subtitle: _language,
                    onTap: () async {
                      final result = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LanguageScreen(
                            selectedLanguage: _language,
                          ),
                        ),
                      );

                      if (result != null && mounted) {
                        setState(() {
                          _language = result;
                        });
                      }
                    },
                  ),
                  _tileDivider(),
                  _MoreTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'Tungi rejim',
                    subtitle: 'Ko‘rinish sozlamalari',
                    trailing: Switch(
                      value: false,
                      activeColor: _primary,
                      onChanged: (_) {
                        _showMessage(
                          'Tungi rejim hozircha mavjud emas',
                        );
                      },
                    ),
                    onTap: () {
                      _showMessage(
                        'Tungi rejim hozircha mavjud emas',
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Yordam va ma'lumot
            _sectionTitle('YORDAM VA MA’LUMOT'),
            const SizedBox(height: 11),

            Container(
              decoration: _cardDecoration(),
              child: Column(
                children: [
                  _MoreTile(
                    icon: Icons.support_agent_rounded,
                    title: 'Yordam markazi',
                    subtitle: 'Savollar va murojaatlar',
                    onTap: () => _openPage(
                      const HelpCenterScreen(),
                    ),
                  ),
                  _tileDivider(),
                  _MoreTile(
                    icon: Icons.info_outline_rounded,
                    title: 'Ilova haqida',
                    subtitle: 'UZPFL haqida ma’lumot',
                    onTap: () => _openPage(
                      const AboutAppScreen(),
                    ),
                  ),
                  _tileDivider(),
                  _MoreTile(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Maxfiylik siyosati',
                    subtitle: 'Ma’lumotlardan foydalanish',
                    onTap: () => _openPage(
                      const PrivacyScreen(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 27),

            // Ilova pastki qismi
            Center(
              child: Column(
                children: [
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: _grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: _grey,
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.1,
      ),
    );
  }

  Widget _tileDivider() {
    return const Padding(
      padding: EdgeInsets.only(left: 57),
      child: Divider(
        height: 1,
        color: Color(0xFFF0F2F6),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: const Color(0xFFEDF0F5),
      ),
    );
  }
}

// Jamoa logotipi
class _TeamLogo extends StatelessWidget {
  final double size;

  const _TeamLogo({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Image.asset(
        'assets/icons/app_icon.png',
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) {
          return const Icon(
            Icons.shield_rounded,
            color: Color(0xFF087BFF),
            size: 25,
          );
        },
      ),
    );
  }
}

// Umumiy menyu elementi
class _MoreTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  final bool showArrow;

  const _MoreTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
  }) : showArrow = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 14,
        ),
        child: Row(
          children: [
            Container(
              width: 39,
              height: 39,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF5FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF087BFF),
                size: 21,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF172033),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF8491A5),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else if (showArrow)
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFB0BAC8),
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}

// Umumiy ichki sahifa dizayni
// Barcha ichki sahifalarda CustomAppBar ishlatiladi.
class _MoreSubPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _MoreSubPage({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: CustomAppBar(
        title: title,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF8491A5),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

// Bildirishnomalar
class NotificationSettingsScreen extends StatefulWidget {
  final bool notifications;
  final bool matchNotifications;
  final bool newsNotifications;
  final Function(bool, bool, bool) onChanged;

  const NotificationSettingsScreen({
    super.key,
    required this.notifications,
    required this.matchNotifications,
    required this.newsNotifications,
    required this.onChanged,
  });

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  late bool _all;
  late bool _matches;
  late bool _news;

  @override
  void initState() {
    super.initState();
    _all = widget.notifications;
    _matches = widget.matchNotifications;
    _news = widget.newsNotifications;
  }

  void _update() {
    widget.onChanged(_all, _matches, _news);
  }

  @override
  Widget build(BuildContext context) {
    return _MoreSubPage(
      title: 'Bildirishnomalar',
      subtitle: 'Sizga keladigan xabarlarni boshqaring',
      child: _SettingsCard(
        children: [
          _SettingsSwitch(
            title: 'Barcha bildirishnomalar',
            subtitle: 'Bildirishnomalarni yoqish yoki o‘chirish',
            value: _all,
            onChanged: (value) {
              setState(() {
                _all = value;
                if (!value) {
                  _matches = false;
                  _news = false;
                }
              });
              _update();
            },
          ),
          const _SettingsDivider(),
          _SettingsSwitch(
            title: 'O‘yinlar haqida',
            subtitle: 'Uchrashuv boshlanishi va natijalari',
            value: _matches,
            onChanged: _all
                ? (value) {
                    setState(() {
                      _matches = value;
                    });
                    _update();
                  }
                : null,
          ),
          const _SettingsDivider(),
          _SettingsSwitch(
            title: 'Yangiliklar',
            subtitle: 'Futbol yangiliklari va e’lonlar',
            value: _news,
            onChanged: _all
                ? (value) {
                    setState(() {
                      _news = value;
                    });
                    _update();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

// Sevimli o'yinlar
class FavoriteMatchesScreen extends StatelessWidget {
  const FavoriteMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _MoreSubPage(
      title: 'Sevimli o‘yinlar',
      subtitle: 'Saqlab qo‘ygan uchrashuvlaringiz shu yerda ko‘rinadi',
      child: _SettingsCard(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF5FF),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Icon(
                      Icons.bookmark_border_rounded,
                      color: Color(0xFF087BFF),
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Hozircha saqlangan o‘yinlar yo‘q',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF172033),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'O‘yinlar sahifasida uchrashuvlarni\nsevimlilarga qo‘shishingiz mumkin',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8491A5),
                      fontSize: 12,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Til sozlamalari
class LanguageScreen extends StatefulWidget {
  final String selectedLanguage;

  const LanguageScreen({
    super.key,
    required this.selectedLanguage,
  });

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late String _selected;

  final List<Map<String, String>> _languages = [
    {'name': 'O‘zbekcha', 'code': 'UZ'},
    {'name': 'Русский', 'code': 'RU'},
    {'name': 'English', 'code': 'EN'},
  ];

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return _MoreSubPage(
      title: 'Til sozlamalari',
      subtitle: 'Ilova tilini tanlang',
      child: _SettingsCard(
        children: [
          ..._languages.map((language) {
            final name = language['name']!;
            final isSelected = _selected == name;

            return Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  leading: Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF5FF),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Text(
                      language['code']!,
                      style: const TextStyle(
                        color: Color(0xFF087BFF),
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(
                      color: Color(0xFF172033),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  trailing: Icon(
                    isSelected
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_off_rounded,
                    color: isSelected
                        ? const Color(0xFF087BFF)
                        : const Color(0xFFB0BAC8),
                  ),
                  onTap: () {
                    setState(() {
                      _selected = name;
                    });
                  },
                ),
                if (name != _languages.last['name']) const _SettingsDivider(),
              ],
            );
          }),
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, _selected),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF087BFF),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                child: const Text(
                  'Saqlash',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Yordam markazi
class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _MoreSubPage(
      title: 'Yordam markazi',
      subtitle: 'UZPFL ilovasi bo‘yicha yordam va ma’lumotlar',
      child: Column(
        children: [
          _SettingsCard(
            children: const [
              _InfoRow(
                icon: Icons.help_outline_rounded,
                title: 'Ilovadan qanday foydalaniladi?',
                subtitle: 'Ilovaning asosiy imkoniyatlari bilan tanishing.',
              ),
              _SettingsDivider(),
              _InfoRow(
                icon: Icons.sports_soccer_rounded,
                title: 'O‘yinlar va natijalar',
                subtitle: 'Uchrashuvlar haqidagi ma’lumotlar.',
              ),
              _SettingsDivider(),
              _InfoRow(
                icon: Icons.notifications_none_rounded,
                title: 'Bildirishnomalar',
                subtitle: 'Xabarlar sozlamalarini boshqarish.',
              ),
            ],
          ),
          const SizedBox(height: 18),
          _SettingsCard(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Biz bilan bog‘lanish',
                      style: TextStyle(
                        color: Color(0xFF172033),
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Savol yoki takliflaringiz bo‘lsa, bizga murojaat qiling.',
                      style: TextStyle(
                        color: Color(0xFF8491A5),
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const _SettingsDivider(),
              ListTile(
                leading: const Icon(
                  Icons.mail_outline_rounded,
                  color: Color(0xFF087BFF),
                ),
                title: const Text(
                  'Elektron pochta',
                  style: TextStyle(fontSize: 13),
                ),
                subtitle: const Text(
                  'Aloqa manzili kiritilmagan',
                  style: TextStyle(fontSize: 11),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Aloqa manzili hali belgilanmagan'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Ilova haqida
class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _MoreSubPage(
      title: 'Ilova haqida',
      subtitle: 'UZPFL — O‘zbekiston futboli bir joyda',
      child: Column(
        children: [
          _SettingsCard(
            children: [
              const SizedBox(height: 25),
              Center(
                child: Container(
                  width: 94,
                  height: 94,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF5FF),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset(
                    'assets/icons/app_icon.png',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.sports_soccer_rounded,
                        color: Color(0xFF087BFF),
                        size: 48,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 17),
              const Center(
                child: Text(
                  'UZPFL',
                  style: TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 7),
              const Center(
                child: Text(
                  'O‘zbekiston futboli haqida barcha ma’lumotlar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8491A5),
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const _SettingsDivider(),
              const _InfoRow(
                icon: Icons.info_outline_rounded,
                title: 'Ilova',
                subtitle: 'UZPFL',
              ),
              const _SettingsDivider(),
              const _InfoRow(
                icon: Icons.update_rounded,
                title: 'Versiya',
                subtitle: '1.0.0',
              ),
              const _SettingsDivider(),
              const _InfoRow(
                icon: Icons.sports_soccer_rounded,
                title: 'Yo‘nalish',
                subtitle: 'O‘zbekiston futboli',
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

// Maxfiylik siyosati
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _MoreSubPage(
      title: 'Maxfiylik siyosati',
      subtitle: 'Foydalanuvchi ma’lumotlari va maxfiylik',
      child: _SettingsCard(
        children: const [
          _PolicySection(
            title: '1. Umumiy ma’lumot',
            description:
                'UZPFL ilovasi foydalanuvchilarga O‘zbekiston futboli, '
                'uchrashuvlar, jamoalar va musobaqalar haqida ma’lumot '
                'taqdim etish uchun ishlab chiqilgan.',
          ),
          _SettingsDivider(),
          _PolicySection(
            title: '2. Shaxsiy ma’lumotlar',
            description: 'Ilovada kiritilgan ism va familiya kabi profil '
                'ma’lumotlaridan ilova imkoniyatlarini taqdim etish '
                'maqsadida foydalanilishi mumkin.',
          ),
          _SettingsDivider(),
          _PolicySection(
            title: '3. Ma’lumotlar xavfsizligi',
            description: 'Foydalanuvchi ma’lumotlarining maxfiyligi va '
                'xavfsizligini ta’minlash muhim hisoblanadi. '
                'Ma’lumotlarni saqlash va qayta ishlash tartibi '
                'ilovaning amaldagi texnik imkoniyatlariga bog‘liq.',
          ),
          _SettingsDivider(),
          _PolicySection(
            title: '4. Siyosatdagi o‘zgarishlar',
            description: 'Maxfiylik siyosati ilova rivojlanishi davomida '
                'yangilanishi mumkin.',
          ),
        ],
      ),
    );
  }
}

// Umumiy sozlamalar kartasi
class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDF0F5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

// Ajratuvchi chiziq
class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        height: 1,
        color: Color(0xFFF0F2F6),
      ),
    );
  }
}

// Sozlamalar switch elementi
class _SettingsSwitch extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const _SettingsSwitch({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF087BFF),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF172033),
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF8491A5),
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}

// Ma'lumot qatori
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF087BFF),
            size: 22,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF8491A5),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Maxfiylik siyosati bo'limi
class _PolicySection extends StatelessWidget {
  final String title;
  final String description;

  const _PolicySection({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF172033),
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 12,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
