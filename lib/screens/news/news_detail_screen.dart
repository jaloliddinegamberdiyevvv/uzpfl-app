import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uzpfl_app/screens/news/news_data.dart';
import 'package:uzpfl_app/screens/news/news_screen.dart';

class NewsDetailScreen extends StatefulWidget {
  final Map<String, String> item;

  const NewsDetailScreen({super.key, required this.item});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final PageController _pageController = PageController();
  int _currentImage = 0;
  bool _isSaved = false;

  static const _dark = Color(0xFF0F172A);
  static const _grey = Color(0xFF64748B);
  static const _border = Color(0xFFE2E8F0);
  static const _blue = Color(0xFF2478E8);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openNews(Map<String, String> item) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => NewsDetailScreen(item: item)),
    );
  }

  // share_plus paketi qo'shilsa, shu yerda Share.share(...) ishlating
  void _share() {
    Clipboard.setData(ClipboardData(text: widget.item['title']!));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            'Yangilik sarlavhasi nusxalandi',
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color(0xFF111111),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.fromLTRB(24, 0, 24, 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        elevation: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final images = NewsData.imagesOf(item);
    final paragraphs = NewsData.paragraphsOf(item);
    final related = NewsData.instance.relatedNews(item);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildGallery(images),

                  // Teglar
                  SizedBox(height: 14),

                  // Sarlavha
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
                    child: Text(
                      item['title']!,
                      style: GoogleFonts.urbanist(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: _dark,
                        height: 1.2,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),

                  // Sana, vaqt, ko'rishlar
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Row(
                      children: [
                        _buildMeta(
                          Icons.calendar_month_rounded,
                          NewsData.formatDate(item['date']!),
                        ),
                        _buildDivider(),
                        _buildMeta(Icons.access_time_rounded, item['time']!),
                        if (item['views'] != null) ...[
                          _buildDivider(),
                          _buildMeta(
                            Icons.visibility_outlined,
                            item['views']!,
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Matn
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 18, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final p in paragraphs)
                          Padding(
                            padding: EdgeInsets.only(bottom: 14),
                            child: Text(
                              p,
                              style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1E293B),
                                height: 1.5,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Boshqa yangiliklar
                  if (related.isNotEmpty) ...[
                    SizedBox(height: 6),
                    Divider(color: _border, height: 1),
                    _buildRelatedHeader(),
                    for (final r in related) _buildRelatedCard(r),
                  ],

                  // _buildBanner(),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- YUQORI PANEL ----------
  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 10),
      child: Row(
        children: [
          _circleButton(
            icon: Icons.chevron_left_rounded,
            iconSize: 26,
            onTap: () => Navigator.of(context).pop(),
          ),
          Spacer(),
          _circleButton(icon: Icons.ios_share_rounded, onTap: _share),
          SizedBox(width: 8),
          _circleButton(
            icon: _isSaved
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            color: _isSaved ? _blue : _dark,
            onTap: () => setState(() => _isSaved = !_isSaved),
          ),
        ],
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    double iconSize = 20,
    Color color = _dark,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _border),
        ),
        child: Icon(icon, size: iconSize, color: color),
      ),
    );
  }

  // ---------- RASMLAR (1/5 hisoblagich bilan) ----------
  Widget _buildGallery(List<String> images) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 16 / 10,
          child: Stack(
            fit: StackFit.expand,
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                onPageChanged: (i) => setState(() => _currentImage = i),
                itemBuilder: (context, index) {
                  return Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Color(0xFFF1F5F9),
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Color(0xFF94A3B8),
                          size: 32,
                        ),
                      );
                    },
                  );
                },
              ),
              if (images.length > 1)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '${_currentImage + 1}/${images.length}',
                      style: GoogleFonts.urbanist(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _dark,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMeta(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 15, color: _grey),
        SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.urbanist(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: _grey,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 14,
      margin: EdgeInsets.symmetric(horizontal: 10),
      color: _border,
    );
  }

  // ---------- BOSHQA YANGILIKLAR ----------
  Widget _buildRelatedHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 18,
            decoration: BoxDecoration(
              color: _blue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 8),
          Text(
            'Boshqa yangiliklar',
            style: GoogleFonts.urbanist(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: _dark,
            ),
          ),
          Spacer(),
          CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 0,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return NewsScreen();
                },
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Barchasi',
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _blue,
                  ),
                ),
                Icon(Icons.chevron_right_rounded, size: 18, color: _blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedCard(Map<String, String> r) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        minSize: 0,
        pressedOpacity: 0.7,
        onPressed: () => _openNews(r),
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _border),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Row(
              children: [
                Image.asset(
                  r['image']!,
                  width: 110,
                  height: 78,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 110,
                      height: 78,
                      color: Color(0xFFF1F5F9),
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Color(0xFF94A3B8),
                      ),
                    );
                  },
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r['title']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.urbanist(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: _dark,
                          height: 1.25,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.calendar_month_rounded,
                              size: 13, color: _grey),
                          SizedBox(width: 4),
                          Text(
                            '${NewsData.formatDate(r['date']!)} • ${r['time']}',
                            style: GoogleFonts.urbanist(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: _grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 28,
                  height: 28,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF1F5F9),
                    shape: BoxShape.circle,
                  ),
                  child:
                      Icon(Icons.chevron_right_rounded, size: 18, color: _dark),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
