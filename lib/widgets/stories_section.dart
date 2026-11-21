import 'package:flutter/cupertino.dart';

class StoriesSection extends StatelessWidget {
  StoriesSection({super.key});

  final List<Map<String, String>> clubs = [
    {'logo': 'assets/images/app_logo.png', 'name': 'Andijon'},
    {'logo': 'assets/images/app_logo.png', 'name': 'Bunyodkor'},
    {'logo': 'assets/images/app_logo.png', 'name': 'Buxoro'},
    {'logo': 'assets/images/app_logo.png', 'name': 'Dinamo'},
    {'logo': 'assets/images/app_logo.png', 'name': 'Lokomotiv'},
    {'logo': 'assets/images/app_logo.png', 'name': 'Mash’al'},
    {'logo': 'assets/images/app_logo.png', 'name': 'Nasaf'},
    {'logo': 'assets/images/app_logo.png', 'name': 'Navbahor'},
    {'logo': 'assets/images/app_logo.png', 'name': 'Neftchi'},
    {'logo': 'assets/images/app_logo.png', 'name': 'OKMK'},
    {'logo': 'assets/images/app_logo.png', 'name': 'Paxtakor'},
    {'logo': 'assets/images/app_logo.png', 'name': 'Qizilqum'},
    {'logo': 'assets/images/app_logo.png', 'name': 'Qo‘qon-1912'},
    {'logo': 'assets/images/app_logo.png', 'name': 'Surxon'},
    {'logo': 'assets/images/app_logo.png', 'name': 'So‘g‘diyona'},
    {'logo': 'assets/images/app_logo.png', 'name': 'Xorazm'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 12,
        children: clubs.map((club) {
          return CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 0,
            onPressed: () {},
            child: Column(
              spacing: 6,
              children: [
                SizedBox(
                  width: 68,
                  height: 68,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: Color(0xFF2563EB),
                        width: 2.5,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: Image.asset(
                          club['logo']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 68,
                  child: Text(
                    club['name']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      inherit: false,
                      fontSize: 12,
                      color: Color(0xFF0F172A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
