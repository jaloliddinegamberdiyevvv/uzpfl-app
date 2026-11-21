import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uzpfl_app/screens/news/news_data.dart';
import 'package:uzpfl_app/screens/news/news_detail_screen.dart';

class TopNews extends StatelessWidget {
  TopNews({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: NewsData.instance,
      builder: (context, child) {
        // Har doim eng yangi 3 ta yangilik
        final latestNews = NewsData.instance.latestNews;

        return Column(
          children: latestNews.map((item) {
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
          }).toList(),
        );
      },
    );
  }
}