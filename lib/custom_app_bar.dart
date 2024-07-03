import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback cartPressed;
  final bool centerTitle;

  CustomAppBar({
    required this.title,
    required this.cartPressed,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: cartPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
