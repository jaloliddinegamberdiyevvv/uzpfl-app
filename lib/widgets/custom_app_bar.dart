import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        minSize: 0,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFF212121),
          size: 18,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.urbanist(
          fontSize: 20,
          color: Color(0xFF212121),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
