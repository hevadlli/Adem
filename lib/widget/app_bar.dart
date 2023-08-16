import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Image.asset(
          'assets/images/LogoAdemHi.png',
          width: 90,
          height: 200,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
