import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onActionTap;
  const SectionHeader(
      {super.key,
      required this.title,
      required this.actionText,
      required this.onActionTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.urbanist(
              fontSize: 20,
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
          CupertinoButton(
            onPressed: onActionTap,
            padding: EdgeInsets.zero,
            minSize: 0,
            child: Row(
              children: [
                Text(
                  actionText,
                  style: GoogleFonts.urbanist(
                    fontSize: 15,
                    color: Color(0xFF0F172A),
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 14,
                  color: Color(0xFF101828),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
