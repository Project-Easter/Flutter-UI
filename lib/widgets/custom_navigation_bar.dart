import 'package:flutter/material.dart';

ItemBuilder _defaultItemBuilder({
  Function(int val) onTap,
  List<FloatingNavbarItem> items,
  int currentIndex,
  Color selectedBackgroundColor,
  Color selectedItemColor,
  Color unselectedItemColor,
  Color backgroundColor,
  double fontSize,
  double iconSize,
  double itemBorderRadius,
  double borderRadius,
  bool showSelectedLabels,
  bool showUnselectedLabels,
}) {
  return (BuildContext context, FloatingNavbarItem item) => Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  color: currentIndex == items.indexOf(item)
                      ? selectedBackgroundColor
                      : backgroundColor,
                  borderRadius: BorderRadius.circular(itemBorderRadius)),
              child: InkWell(
                onTap: () {
                  onTap(items.indexOf(item));
                },
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Container(
                  height: 54,
                  width: 54,
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        item.icon,
                        color: currentIndex == items.indexOf(item)
                            ? selectedItemColor
                            : unselectedItemColor,
                        size: iconSize,
                      ),
                      Text(
                        item.title,
                        style: TextStyle(
                          color: currentIndex == items.indexOf(item)
                              ? selectedItemColor
                              : unselectedItemColor,
                          fontSize: fontSize,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

typedef ItemBuilder = Widget Function(
    BuildContext context, FloatingNavbarItem items);

class FloatingNavbar extends StatefulWidget {
  final List<FloatingNavbarItem> items;
  final int currentIndex;
  final void Function(int val) onTap;
  final Color selectedBackgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Color backgroundColor;
  final double fontSize;
  final double iconSize;
  final double itemBorderRadius;
  final double borderRadius;
  final ItemBuilder itemBuilder;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double width;
  final double elevation;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  FloatingNavbar({
    Key key,
    @required this.items,
    @required this.currentIndex,
    @required this.onTap,
    ItemBuilder itemBuilder,
    this.backgroundColor = Colors.white,
    this.selectedBackgroundColor = Colors.black,
    this.selectedItemColor = Colors.white,
    this.iconSize = 24.0,
    this.fontSize = 11.0,
    this.borderRadius = 8,
    this.itemBorderRadius = 20,
    this.unselectedItemColor = Colors.black,
    this.margin = const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    this.padding = const EdgeInsets.only(bottom: 8, top: 8),
    this.width = double.infinity,
    this.elevation = 0.0,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
  })  : assert(items.length > 1),
        assert(items.length <= 5),
        assert(currentIndex <= items.length),
        assert(width > 50),
        itemBuilder = itemBuilder ??
            _defaultItemBuilder(
              showUnselectedLabels: showUnselectedLabels,
              showSelectedLabels: showSelectedLabels,
              unselectedItemColor: unselectedItemColor,
              selectedItemColor: selectedItemColor,
              borderRadius: borderRadius,
              fontSize: fontSize,
              backgroundColor: backgroundColor,
              currentIndex: currentIndex,
              iconSize: iconSize,
              itemBorderRadius: itemBorderRadius,
              items: items,
              onTap: onTap,
              selectedBackgroundColor: selectedBackgroundColor,
            ),
        super(key: key);

  @override
  _FloatingNavbarState createState() => _FloatingNavbarState();
}

class FloatingNavbarItem {
  final String title;
  final IconData icon;
  final Widget customWidget;

  FloatingNavbarItem({
    @required this.icon,
    @required this.title,
    this.customWidget = const SizedBox(),
  });
}

class _FloatingNavbarState extends State<FloatingNavbar> {
  List<FloatingNavbarItem> get items => widget.items;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: widget.elevation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 70,
            padding: widget.padding,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                const BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 20,
                  color: Colors.black26,
                )
              ],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: widget.backgroundColor,
            ),
            width: widget.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: items.map((FloatingNavbarItem f) {
                  return widget.itemBuilder(context, f);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
