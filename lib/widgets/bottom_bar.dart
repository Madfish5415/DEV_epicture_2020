import 'package:epicture/models/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomBarWidget extends StatelessWidget {
  final List<PageModel> _pages;
  final int _currentIndex;
  final Function(int) _onTap;

  BottomBarWidget(this._pages, this._currentIndex, this._onTap);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _generateItems(),
      currentIndex: _currentIndex,
      onTap: _onTap,
    );
  }

  List<BottomNavigationBarItem> _generateItems() {
    final List<BottomNavigationBarItem> items = _pages.map((page) {
      return BottomNavigationBarItem(
        icon: Icon(page.item.iconData),
        label: page.item.label,
      );
    }).toList();

    return items;
  }
}
