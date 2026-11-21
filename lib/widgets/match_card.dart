import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uzpfl_app/screens/match_detail/match_detail_screen.dart';

class MatchCard extends StatelessWidget {
  final Map<String, dynamic> match;

  const MatchCard({
    super.key,
    required this.match,
  });

  static const Color _dark = Color(0xFF0F172A);
  static const Color _grey = Color(0xFF64748B);
  static const Color _border = Color(0xFFE2E8F0);
  static const Color _red = Color(0xFFEF4444);
  static const Color _blue = Color(0xFF2478E8);
  static const Color _green = Color(0xFF22C55E);
  // 0xFF16A34A

  @override
  Widget build(BuildContext context) {
    final isLive = match['status'] == 'Jonli';
    final isFinished = match['status'] == 'Tugagan';

    final statusColor = isLive
        ? _red
        : isFinished
            ? _green
            : _blue;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      pressedOpacity: 0.75,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MatchDetailScreen(
              match: match,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _border),
        ),
        child: Column(
          children: [
            // Musobaqa va sana
            Row(
              children: [
                Expanded(
                  child: Text(
                    match['competition'],
                    style: GoogleFonts.urbanist(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _grey,
                    ),
                  ),
                ),
                Text(
                  match['date'],
                  style: GoogleFonts.urbanist(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: _grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Jamoalar va hisob
            Row(
              children: [
                Expanded(
                  child: _buildTeam(
                    match['home'],
                    match['homeLogo'],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      isLive || isFinished
                          ? '${match['homeScore']} : ${match['awayScore']}'
                          : match['time'],
                      style: GoogleFonts.urbanist(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: _dark,
                      ),
                    ),
                    const SizedBox(height: 2),

                    // Kutilayotgan o'yinda vaqt tagidagi yozuv olib tashlandi
                    if (isLive || isFinished)
                      Text(
                        isLive ? match['minute'] : 'Yakunlandi',
                        style: GoogleFonts.urbanist(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: _buildTeam(
                    match['away'],
                    match['awayLogo'],
                    right: true,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            const Divider(
              height: 1,
              color: Color(0xFFF1F5F9),
            ),

            const SizedBox(height: 8),

            // Pastki ma'lumotlar
            Row(
              children: [
                const Icon(
                  Icons.sports_soccer_rounded,
                  size: 14,
                  color: _grey,
                ),
                const SizedBox(width: 5),
                Text(
                  '${match['round']}-tur',
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _grey,
                  ),
                ),
                const Spacer(),
                Text(
                  isLive
                      ? 'Jonli'
                      : isFinished
                          ? 'Natija'
                          : 'Uchrashuv',
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Jamoa logosi va nomi
  Widget _buildTeam(
    String name,
    String logo, {
    bool right = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: right ? 0 : 16,
        right: right ? 16 : 0,
      ),
      child: Column(
        crossAxisAlignment:
            right ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Image.asset(
            logo,
            width: 36,
            height: 36,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.shield_outlined,
                size: 36,
                color: _grey,
              );
            },
          ),
          const SizedBox(height: 4),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.urbanist(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _dark,
            ),
          ),
        ],
      ),
    );
  }
}
