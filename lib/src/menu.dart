// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

/// A widget representing the application menu.
class AppMenu extends StatelessWidget {
  /// Constructs an instance of [AppMenu].
  ///
  /// [actions]: List of menu actions.
  ///
  /// [child]: Widget to display within the menu.
  ///
  /// [boxDecoration]: Decoration for the menu container.
  ///
  /// [exit]: Widget to display as an exit button.
  ///
  /// [logout]: Widget to display as a logout button.
  ///
  /// [exitAlignment]: Alignment for the exit button.
  const AppMenu({
    required this.actions,
    required this.child,
    super.key,
    this.boxDecoration,
    this.exit,
    this.logout,
    this.exitAlignment,
  });

  /// List of menu actions.
  final List<MenuAction> actions;

  /// Widget to display within the menu.
  final Widget child;

  /// Decoration for the menu container.
  final BoxDecoration? boxDecoration;

  /// Widget to display as an exit button.
  final Widget? exit;

  /// Widget to display as a logout button.
  final Widget? logout;

  /// Alignment for the exit button.
  final AlignmentGeometry? exitAlignment;

  @override
  Widget build(BuildContext context) => Container(
        decoration: boxDecoration,
        child: Column(
          children: [
            if (exit != null) ...[
              Align(
                alignment: exitAlignment ?? Alignment.topRight,
                child: exit,
              ),
            ],
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (MenuAction action in actions) ...[
                      action,
                    ],
                  ],
                ),
              ),
            ),
            if (logout != null) ...[
              logout!,
              MenuAction.spacer(),
            ],
          ],
        ),
      );
}

/// A callback for menu actions.
typedef MenuActionCallBack = void Function(BuildContext context);

/// An abstract class representing a menu action.
abstract class MenuAction extends StatelessWidget {
  /// Constructs an instance of [MenuAction].
  const MenuAction({super.key});

  /// Constructs a text menu action.
  factory MenuAction.text({
    required String text,
    required MenuActionCallBack onTap,
    TextStyle textStyle = const TextStyle(),
    double leftTextOffset = 100,
    IconData? icon,
    IconData? trailingIcon,
  }) =>
      TextMenuAction(
        text: text,
        onTap: onTap,
        icon: icon,
        trailingIcon: trailingIcon,
        style: textStyle,
        leftTextOffset: leftTextOffset,
      );

  /// Constructs a divider menu action.
  factory MenuAction.divider() => const ActionDivider();

  /// Constructs a spacer menu action.
  factory MenuAction.spacer({
    double height = 20,
  }) =>
      ActionSpacer(
        height: height,
      );

  /// Constructs a search menu action.
  factory MenuAction.search({
    required SearchMenuActionCallBack onSearch,
    Icon? icon,
    InputDecoration? inputDecoration,
  }) =>
      SearchAction(
        onSearch: onSearch,
        icon: icon,
        inputDecoration: inputDecoration,
      );

  /// Constructs a custom menu action.
  factory MenuAction.custom({
    required WidgetBuilder builder,
  }) =>
      CustomMenuAction(
        builder: builder,
      );

  /// Builds the action widget.
  Widget buildAction(BuildContext context);

  @override
  Widget build(BuildContext context) => buildAction(context);
}

/// A custom menu action.
class CustomMenuAction extends MenuAction {
  /// Constructs an instance of [CustomMenuAction].
  const CustomMenuAction({
    required this.builder,
    super.key,
  });

  /// Builder for the custom menu action.
  final WidgetBuilder builder;

  @override
  Widget buildAction(BuildContext context) => builder.call(context);
}

/// A spacer menu action.
class ActionSpacer extends MenuAction {
  /// Constructs an instance of [ActionSpacer].
  const ActionSpacer({super.key, this.height = 20});

  /// Height of the spacer.
  final double height;

  @override
  Widget buildAction(BuildContext context) => Container(
        height: height,
      );
}

/// A divider menu action.
class ActionDivider extends MenuAction {
  /// Constructs an instance of [ActionDivider].
  const ActionDivider({super.key});

  @override
  Widget buildAction(BuildContext context) => const Divider(
        thickness: 1,
      );
}

/// A callback for search menu actions.
typedef SearchMenuActionCallBack = void Function(
  BuildContext context,
  String value,
);

/// A search menu action.
class SearchAction extends MenuAction {
  /// Constructs an instance of [SearchAction].
  const SearchAction({
    required this.onSearch,
    super.key,
    this.icon,
    this.inputDecoration,
  });

  /// Callback for the search action.
  final SearchMenuActionCallBack onSearch;

  /// Icon for the search action.
  final Icon? icon;

  /// Input decoration for the search action.
  final InputDecoration? inputDecoration;

  @override
  Widget buildAction(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child:
            SearchInput(onSearch, icon: icon, inputDecoration: inputDecoration),
      );
}

/// A stateful widget for search input.
class SearchInput extends StatefulWidget {
  /// Constructs an instance of [SearchInput].
  const SearchInput(
    this.onSearch, {
    super.key,
    this.icon,
    this.inputDecoration,
  });

  /// Callback for search action.
  final SearchMenuActionCallBack onSearch;

  /// Icon for the search action.
  final Icon? icon;

  /// Input decoration for the search action.
  final InputDecoration? inputDecoration;

  @override
  SearchInputState createState() => SearchInputState();
}

/// State for [SearchInput].
class SearchInputState extends State<SearchInput> {
  /// Current value of the search input.
  String value = '';

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  onSubmitted: (_) {
                    widget.onSearch(context, value);
                  },
                  onChanged: (value) {
                    setState(() {
                      this.value = value;
                    });
                  },
                  decoration: widget.inputDecoration,
                ),
              ),
            ),
            if (widget.icon != null)
              IconButton(
                icon: widget.icon!,
                onPressed: () {
                  widget.onSearch(
                    context,
                    value,
                  );
                },
              ),
          ],
        ),
      );
}

/// A menu action representing text.
class TextMenuAction extends MenuAction {
  /// Constructs an instance of [TextMenuAction].
  const TextMenuAction({
    required this.onTap,
    required this.text,
    super.key,
    this.icon,
    this.leftTextOffset = 100,
    this.trailingIcon,
    this.style = const TextStyle(),
  });

  /// Text to display.
  final String text;

  /// Icon for the text action.
  final IconData? icon;

  /// Callback for the text action.
  final MenuActionCallBack onTap;

  /// Icon to display at the end of the text.
  final IconData? trailingIcon;

  /// Style for the text.
  final TextStyle style;

  /// Offset for the text from the left.
  final double leftTextOffset;

  @override
  Widget buildAction(BuildContext context) => InkWell(
        onTap: () => onTap.call(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: (icon != null)
                      ? Icon(
                          icon,
                          size: (style.fontSize ?? 16) * 1.5,
                          color: style.color,
                        )
                      : SizedBox(
                          width: leftTextOffset,
                        ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        text,
                        style: style,
                      ),
                      if (trailingIcon != null) ...[
                        Icon(
                          trailingIcon,
                          size: style.fontSize ?? 16,
                          color: style.color,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
