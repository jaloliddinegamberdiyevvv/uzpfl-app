import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Top5Standings extends StatelessWidget {
  Top5Standings({super.key});

  // Superliga Top 5 jamoalari
  final List<Map<String, String>> teams = [
    {
      'rank': '1',
      'logo': 'assets/images/app_logo.png',
      'name': 'Andijon',
      'p': '11',
      'g': '8',
      'm': '2',
      'pts': '26',
    },
    {
      'rank': '2',
      'logo': 'assets/images/app_logo.png',
      'name': 'Bunyodkor',
      'p': '11',
      'g': '7',
      'm': '1',
      'pts': '24',
    },
    {
      'rank': '3',
      'logo': 'assets/images/app_logo.png',
      'name': 'Buxoro',
      'p': '11',
      'g': '7',
      'm': '2',
      'pts': '23',
    },
    {
      'rank': '4',
      'logo': 'assets/images/app_logo.png',
      'name': 'Dinamo',
      'p': '11',
      'g': '6',
      'm': '2',
      'pts': '21',
    },
    {
      'rank': '5',
      'logo': 'assets/images/app_logo.png',
      'name': 'Lokomotiv',
      'p': '11',
      'g': '6',
      'm': '3',
      'pts': '20',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Jadval sarlavhasi
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  child: Text(
                    '#',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
                SizedBox(width: 12),

                // Jamoa
                Expanded(
                  child: Text(
                    'Jamoa',
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),

                // O'yinlar
                SizedBox(
                  width: 28,
                  child: Text(
                    "O'",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),

                SizedBox(width: 6),

                // G'alaba
                SizedBox(
                  width: 24,
                  child: Text(
                    'G',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),

                SizedBox(width: 6),

                // Mag'lubiyat
                SizedBox(
                  width: 24,
                  child: Text(
                    'M',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),

                SizedBox(width: 6),

                // Ochko
                SizedBox(
                  width: 44,
                  child: Text(
                    'Ochko',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Jamoalar ro'yxati
          ...teams.asMap().entries.map((entry) {
            final index = entry.key;
            final team = entry.value;
            final isLast = index == teams.length - 1;

            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : Border(
                        bottom: BorderSide(
                          color: Color(0xFFF1F5F9),
                          width: 1,
                        ),
                      ),
              ),
              child: Row(
                children: [
                  // O'rin raqami
                  SizedBox(
                    width: 24,
                    child: Text(
                      team['rank']!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),

                  SizedBox(width: 12),

                  // Jamoa logotipi
                  Image.asset(
                    team['logo']!,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(width: 12),

                  // Jamoa nomi
                  Expanded(
                    child: Text(
                      team['name']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.urbanist(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),

                  // O'yinlar soni
                  SizedBox(
                    width: 28,
                    child: Text(
                      team['p']!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),

                  SizedBox(width: 6),

                  // G'alabalar soni
                  SizedBox(
                    width: 24,
                    child: Text(
                      team['g']!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF16A34A),
                      ),
                    ),
                  ),

                  SizedBox(width: 6),

                  // Mag'lubiyatlar soni
                  SizedBox(
                    width: 24,
                    child: Text(
                      team['m']!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFDC2626),
                      ),
                    ),
                  ),

                  SizedBox(width: 6),

                  // Ochko
                  Container(
                    width: 44,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      team['pts']!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}