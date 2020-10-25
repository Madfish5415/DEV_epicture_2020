import 'package:epicture/models/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomBarWidget extends StatelessWidget {
  final int currentIndex;
  final List<PageModel> pages;
  final ValueChanged<int> onTap;

  BottomBarWidget({
    @required this.currentIndex,
    @required this.pages,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _generateItems(),
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }

  List<BottomNavigationBarItem> _generateItems() {
    final List<BottomNavigationBarItem> items = pages.map((page) {
      return BottomNavigationBarItem(
        icon: Icon(page.item.iconData),
        label: page.item.label,
      );
    }).toList();

    return items;
  }
}
