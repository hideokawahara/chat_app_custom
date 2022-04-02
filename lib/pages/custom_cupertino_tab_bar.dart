//Packages
import 'dart:ui';
import 'package:flutter/cupertino.dart';

const double _defaultTabBarHeight = 50.0;

const Color _defaultTabBarBorderColor = CupertinoDynamicColor.withBrightness(
  color: Color(0x4C000000),
  darkColor: Color(0x29000000),
);

const Color _defaultTabBarInactiveColor = CupertinoColors.inactiveGray;

class CustomCupertinoTabBar extends CupertinoTabBar {
  CustomCupertinoTabBar({
    Key? key,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor = _defaultTabBarInactiveColor,
    this.iconSize = 30.0,
    this.border = const Border(
      top: BorderSide(
        color: _defaultTabBarBorderColor,
        width: 0.0,
        style: BorderStyle.solid,
      ),
    ),
    this.height,
    this.labelStyle,
    this.activeLabelStyle,
  }) : super(items: items);

  final List<BottomNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  final int currentIndex;
  final Color? backgroundColor;
  final Color? activeColor;
  final Color inactiveColor;
  final double iconSize;
  final Border? border;

  final double? height;
  final TextStyle? labelStyle;
  final TextStyle? activeLabelStyle;

  @override
  Size get preferredSize =>
      Size.fromHeight(height != null ? height! : _defaultTabBarHeight);

  bool opaque(BuildContext context) {
    final Color backgroundColor =
        this.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor;
    return CupertinoDynamicColor.resolve(backgroundColor, context).alpha ==
        0xFF;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    final Color backgroundColor = CupertinoDynamicColor.resolve(
      this.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor,
      context,
    );

    BorderSide resolveBorderSide(BorderSide side) {
      return side == BorderSide.none
          ? side
          : side.copyWith(
              color: CupertinoDynamicColor.resolve(side.color, context));
    }

    final Border? resolvedBorder =
        border == null || border.runtimeType != Border
            ? border
            : Border(
                top: resolveBorderSide(border!.top),
                left: resolveBorderSide(border!.left),
                bottom: resolveBorderSide(border!.bottom),
                right: resolveBorderSide(border!.right),
              );

    final Color inactive =
        CupertinoDynamicColor.resolve(inactiveColor, context);

    final double setHeight = height != null ? height! : _defaultTabBarHeight;

    Widget result = DecoratedBox(
      decoration: BoxDecoration(
        border: resolvedBorder,
        color: backgroundColor,
      ),
      child: SizedBox(
        height: setHeight + bottomPadding,
        child: IconTheme.merge(
          data: IconThemeData(color: inactive, size: iconSize),
          child: DefaultTextStyle(
            style: CupertinoTheme.of(context)
                .textTheme
                .tabLabelTextStyle
                .copyWith(color: inactive),
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: Semantics(
                explicitChildNodes: true,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _buildTabItems(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (!opaque(context)) {
      result = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: result,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildTabItems(BuildContext context) {
    final List<Widget> result = <Widget>[];
    final CupertinoLocalizations localizations =
        CupertinoLocalizations.of(context);

    for (int index = 0; index < items.length; index += 1) {
      final bool active = index == currentIndex;
      result.add(
        _wrapActiveItem(
          context,
          Expanded(
            child: Semantics(
              selected: active,
              hint: localizations.tabSemanticsLabel(
                tabIndex: index + 1,
                tabCount: items.length,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap == null
                    ? null
                    : () {
                        onTap!(index);
                      },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _buildSingleTabItem(items[index], active),
                  ),
                ),
              ),
            ),
          ),
          active: active,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildSingleTabItem(BottomNavigationBarItem item, bool active) {
    return <Widget>[
      Expanded(
        child: Center(child: active ? item.activeIcon : item.icon),
      ),
      if (item.title != null) item.title!,
      if (item.label != null) Text(item.label!),
    ];
  }

  Widget _wrapActiveItem(BuildContext context, Widget item,
      {required bool active}) {
    if (!active) {
      if (labelStyle != null) {
        return DefaultTextStyle.merge(
          style: labelStyle,
          child: item,
        );
      } else {
        return item;
      }
    }

    final Color activeColor = CupertinoDynamicColor.resolve(
      this.activeColor ?? CupertinoTheme.of(context).primaryColor,
      context,
    );
    return IconTheme.merge(
      data: IconThemeData(color: activeColor),
      child: DefaultTextStyle.merge(
        style: activeLabelStyle != null
            ? activeLabelStyle
            : TextStyle(color: activeColor),
        child: item,
      ),
    );
  }

  @override
  CustomCupertinoTabBar copyWith({
    Key? key,
    List<BottomNavigationBarItem>? items,
    Color? backgroundColor,
    Color? activeColor,
    Color? inactiveColor,
    double? iconSize,
    Border? border,
    int? currentIndex,
    ValueChanged<int>? onTap,
    double? height,
    TextStyle? labelStyle,
    TextStyle? activeLabelStyle,
  }) {
    return CustomCupertinoTabBar(
      key: key ?? this.key,
      items: items ?? this.items,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      iconSize: iconSize ?? this.iconSize,
      border: border ?? this.border,
      currentIndex: currentIndex ?? this.currentIndex,
      onTap: onTap ?? this.onTap,
      height: height ?? this.height,
      labelStyle: labelStyle ?? this.labelStyle,
      activeLabelStyle: activeLabelStyle ?? this.activeLabelStyle,
    );
  }
}
