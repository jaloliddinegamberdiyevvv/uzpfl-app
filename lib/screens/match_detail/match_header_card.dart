import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uzpfl_app/screens/match_detail/match_team_info.dart';

class MatchHeaderCard extends StatelessWidget {
  final Map<String, dynamic> match;

  const MatchHeaderCard({
    super.key,
    required this.match,
  });

  static const Color _dark = Color(0xFF0F172A);
  static const Color _grey = Color(0xFF64748B);
  static const Color _border = Color(0xFFE2E8F0);
  static const Color _red = Color(0xFFEF4444);
  static const Color _blue = Color(0xFF2478E8);
  static const Color _green = Color(0xFF16A34A);

  @override
  Widget build(BuildContext context) {
    final isLive = match['status'] == 'Jonli';
    final isFinished = match['status'] == 'Tugagan';

    // O'yin holatiga qarab rang tanlanadi
    final statusColor = isLive
        ? _red
        : isFinished
            ? _green
            : _blue;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
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
                    match['competition']?.toString() ?? '',
                    style: GoogleFonts.urbanist(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _grey,
                    ),
                  ),
                ),
                Text(
                  match['date']?.toString() ?? '',
                  style: GoogleFonts.urbanist(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: _grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Jamoalar va hisob yoki boshlanish vaqti
            Row(
              children: [
                Expanded(
                  child: MatchTeamInfo(
                    name: match['home']?.toString() ?? '',
                    logo: match['homeLogo']?.toString() ?? '',
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        isLive || isFinished
                            ? '${match['homeScore']} : ${match['awayScore']}'
                            : match['time']?.toString() ?? '',
                        style: GoogleFonts.urbanist(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: _dark,
                        ),
                      ),
                      const SizedBox(height: 3),

                      // Jonli va tugagan o'yin holati
                      if (isLive || isFinished)
                        Text(
                          isLive
                              ? match['minute']?.toString() ?? ''
                              : 'Yakunlandi',
                          style: GoogleFonts.urbanist(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: statusColor,
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: MatchTeamInfo(
                    name: match['away']?.toString() ?? '',
                    logo: match['awayLogo']?.toString() ?? '',
                    right: true,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            const Divider(
              height: 1,
              color: Color(0xFFF1F5F9),
            ),

            const SizedBox(height: 14),

            // Tur raqami va o'yin holati
            Row(
              children: [
                const Icon(
                  Icons.sports_soccer_rounded,
                  size: 15,
                  color: _grey,
                ),
                const SizedBox(width: 6),
                Text(
                  '${match['round'] ?? ''}-tur',
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
}