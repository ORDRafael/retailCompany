import 'package:flutter/material.dart';
import 'package:obramat/utils/colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showMenu;
  final bool showSearch;
  final VoidCallback? onConfigPressed;

  const AppBarWidget({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.showMenu = true,
    this.showSearch = true,
    this.onConfigPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title ?? 'OBRAMAT',
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: leading ?? (showMenu ? IconButton(
        icon: Icon(Icons.menu,
          color: AppColors.primaryColor,
        ),
        onPressed: () {},
      ) : null),
      actions: [
        if (showSearch) IconButton(
          icon: Icon(Icons.search,
            color: AppColors.primaryColor,
          ),
          onPressed: (){},
        ),
        if (onConfigPressed != null) IconButton(
          icon: Icon(Icons.settings,
            color: AppColors.primaryColor,
          ),
          onPressed: onConfigPressed,
        ),
        ...actions ?? [],
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}