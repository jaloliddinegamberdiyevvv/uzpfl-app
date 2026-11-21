import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uzpfl_app/screens/news/news_data.dart';
import 'package:uzpfl_app/screens/news/news_detail_screen.dart';
import 'package:uzpfl_app/widgets/custom_app_bar.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  // Yangiliklar kartalarini chiqarish
  Widget _buildNewsList(List<Map<String, String>> items) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          'Hozircha yangiliklar mavjud emas',
          style: GoogleFonts.urbanist(
            fontSize: 14,
            color: Color(0xFF64748B),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 12, bottom: 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CupertinoButton(
            // Yangilik sahifasini ochish
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => NewsDetailScreen(item: item),
                ),
              );
            },
            padding: EdgeInsets.zero,
            minSize: 0,
            pressedOpacity: 0.7,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Row(
                  children: [
                    // Yangilik rasmi
                    Image.asset(
                      item['image']!,
                      width: 124,
                      height: 96,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 124,
                          height: 96,
                          color: Color(0xFFF1F5F9),
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: Color(0xFF94A3B8),
                          ),
                        );
                      },
                    ),

                    SizedBox(width: 12),

                    // Yangilik matnlari
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item['title']!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.urbanist(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                                height: 1.25,
                                letterSpacing: -0.2,
                              ),
                            ),

                            SizedBox(height: 8),

                            // Sana va vaqt
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_rounded,
                                  size: 14,
                                  color: Color(0xFF64748B),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  NewsData.formatDate(item['date']!),
                                  style: GoogleFonts.urbanist(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: 1,
                                  height: 14,
                                  color: Color(0xFFE2E8F0),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.access_time_rounded,
                                  size: 14,
                                  color: Color(0xFF64748B),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  item['time']!,
                                  style: GoogleFonts.urbanist(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(width: 8),

                    // Yo‘nalish belgisi
                    Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 20,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F8FC),
      appBar: CustomAppBar(title: 'Yangiliklar'),

      // NewsData o‘zgarganda ekran avtomatik yangilanadi
      body: AnimatedBuilder(
        animation: NewsData.instance,
        builder: (context, child) {
          final now = DateTime.now();
          final sevenDaysAgo = now.subtract(Duration(days: 7));

          // Umumiy yangiliklar ro‘yxati
          final news = NewsData.instance.news;

          // So‘nggi 7 kun ichidagi yangiliklar
          final recentNews = news.where((item) {
            final date = NewsData.instance.getNewsDate(item);

            return !date.isBefore(sevenDaysAgo);
          }).toList();

          // 7 kundan oldingi yangiliklar
          final oldNews = news.where((item) {
            final date = NewsData.instance.getNewsDate(item);

            return date.isBefore(sevenDaysAgo);
          }).toList();

          return Column(
            children: [
              // So‘nggi va eski yangiliklar tablari
              Container(
                margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFFEFF3F8),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TabBar(
                  controller: tabController,
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
                  labelColor: Color(0xFF2478E8),
                  unselectedLabelColor: Color(0xFF64748B),
                  labelStyle: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  tabs: [
                    Tab(text: 'So‘nggi (${recentNews.length})'),
                    Tab(text: 'Eski (${oldNews.length})'),
                  ],
                ),
              ),

              // Yangiliklar ro‘yxati
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    _buildNewsList(recentNews),
                    _buildNewsList(oldNews),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}