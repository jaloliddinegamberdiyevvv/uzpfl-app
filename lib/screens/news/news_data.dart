import 'package:flutter/material.dart';

class NewsData extends ChangeNotifier {
  NewsData._();

  // Bitta umumiy NewsData obyekti
  static final NewsData instance = NewsData._();

  // Barcha yangiliklar
  // Eslatma: Map<String, String> turi saqlab qolindi, shuning uchun
  // ko'p qiymatlar '|' belgisi bilan ajratib yoziladi.
  final List<Map<String, String>> _news = [
    {
      'title': 'Nasaf yangi mavsumga tayyorgarlikni boshladi',
      'date': '2026-11-11',
      'time': '16:00',
      'image': '',
      // Bir nechta rasm (karusel uchun). Bo'sh bo'lsa 'image' ishlatiladi
      'images': '',
      'tags': 'Nasaf|Superliga|Yangiliklar',
      'views': '18.7K',
      // Abzatslar bo'sh qator (\n\n) bilan ajratiladi
      'content':
          'Qarshining Nasaf klubi yangi mavsumga tayyorgarlik jarayonini boshladi. '
              'Jamoa futbolchilari mashg‘ulotlarga kirishdi.\n\n'
              'Murabbiylar shtabi futbolchilarning jismoniy holatini yaxshilash va '
              'jamoaviy o‘yinni kuchaytirishga alohida e’tibor qaratmoqda.\n\n'
              'Yaqin kunlarda klub tomonidan tayyorgarlik jarayoni bo‘yicha '
              'qo‘shimcha ma’lumotlar e’lon qilinishi kutilmoqda.',
    },
    {
      'title': 'Bunyodkor yangi futbolchi bilan shartnoma imzoladi',
      'date': '2026-11-11',
      'time': '15:35',
      'image': 'assets/images/background.jpg',
      // Bir nechta rasm (karusel uchun). Bo'sh bo'lsa 'image' ishlatiladi
      'images':
          'assets/images/background.jpg|assets/images/background.jpg|assets/images/background.jpg',
      'tags': 'Superliga|Yangiliklar|Rasmiy',
      'views': '25.4K',
      // Abzatslar bo'sh qator (\n\n) bilan ajratiladi
      'content': 'Bunyodkor klubi yangi mavsum oldidan safini mustahkamladi. '
          'Futbolchi bilan shartnoma rasman imzolandi.\n\n'
          'Klub matbuot xizmati ma\'lumotiga ko\'ra, yangi futbolchi '
          'jamoaga yaqin kunlarda qo\'shiladi va birinchi mashg\'ulotni '
          'o\'tkazadi.\n\n'
          'Superliga bahslari davom etmoqda.',
    },
  ];

  // Yangiliklarni tashqariga o'zgartirib bo'lmaydigan ro'yxat sifatida berish
  List<Map<String, String>> get news {
    return List.unmodifiable(_sortedNews);
  }

  // Yangiliklarni sana va vaqt bo'yicha saralash
  List<Map<String, String>> get _sortedNews {
    final sorted = [..._news];

    sorted.sort(
      (a, b) => getNewsDate(b).compareTo(getNewsDate(a)),
    );

    return sorted;
  }

  // HomeScreen uchun eng so'nggi 3 ta yangilik
  List<Map<String, String>> get latestNews {
    return _sortedNews.take(3).toList();
  }

  // "Boshqa yangiliklar" uchun: joriy yangilikdan tashqari eng so'nggilari
  List<Map<String, String>> relatedNews(
    Map<String, String> current, {
    int limit = 2,
  }) {
    return _sortedNews
        .where((item) => item['title'] != current['title'])
        .take(limit)
        .toList();
  }

  // Yangilikning rasmlari ro'yxati
  static List<String> imagesOf(Map<String, String> item) {
    final raw = item['images'];
    if (raw == null || raw.trim().isEmpty) return [item['image']!];
    return raw.split('|').where((e) => e.trim().isNotEmpty).toList();
  }

  // Yangilikning teglari
  static List<String> tagsOf(Map<String, String> item) {
    final raw = item['tags'];
    if (raw == null || raw.trim().isEmpty) return ['Yangiliklar'];
    return raw.split('|').where((e) => e.trim().isNotEmpty).toList();
  }

  // Yangilik matni abzatslari
  static List<String> paragraphsOf(Map<String, String> item) {
    final raw = item['content'];
    if (raw == null || raw.trim().isEmpty) return [];
    return raw
        .split('\n\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  // Yangi yangilik qo'shish
  void addNews({
    required String title,
    required String date,
    required String time,
    required String image,
    String? images,
    String? tags,
    String? views,
    String? content,
  }) {
    final newNews = {
      'title': title,
      'date': date,
      'time': time,
      'image': image,
      'images': images ?? image,
      'tags': tags ?? 'Yangiliklar',
      'views': views ?? '0',
      'content': content ?? '',
    };

    _news.add(newNews);

    // Barcha ulangan ekranlarni yangilash
    notifyListeners();
  }

  // Yangilikni o'chirish
  void removeNews(Map<String, String> item) {
    _news.remove(item);
    notifyListeners();
  }

  // Yangilik sanasi va vaqtini DateTime ga o'tkazish
  DateTime getNewsDate(Map<String, String> item) {
    return DateTime.parse('${item['date']}T${item['time']}:00');
  }

  // Sanani formatlash
  static String formatDate(String date) {
    final parsedDate = DateTime.parse(date);

    final months = [
      'yan',
      'fev',
      'mar',
      'apr',
      'may',
      'iyn',
      'iyl',
      'avg',
      'sen',
      'okt',
      'noy',
      'dek',
    ];

    return '${parsedDate.day}-${months[parsedDate.month - 1]} ${parsedDate.year}';
  }
}
