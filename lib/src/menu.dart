import 'package:flutter/material.dart';

class AppMenu extends StatelessWidget {
  final List<MenuAction> actions;
  final Widget child;
  final BoxDecoration? boxDecoration;
  final Widget? exit;
  final Widget? logout;

  const AppMenu(
      {Key? key,
      this.boxDecoration,
      this.exit,
      this.logout,
      required this.actions,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      child: Column(
        children: [
          if (exit != null) ...[
            Align(
              alignment: Alignment.topRight,
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
}

typedef MenuActionCallBack = void Function(BuildContext context);

abstract class MenuAction extends StatelessWidget {
  const MenuAction({super.key});
  factory MenuAction.text({
    required String text,
    required MenuActionCallBack onTap,
    TextStyle textStyle = const TextStyle(),
    double leftTextOffset = 100,
    IconData? icon,
    IconData? trailingIcon,
  }) {
    return TextMenuAction(
      text: text,
      onTap: onTap,
      icon: icon,
      trailingIcon: trailingIcon,
      style: textStyle,
      leftTextOffset: leftTextOffset,
    );
  }

  factory MenuAction.divider() => const ActionDivider();

  factory MenuAction.spacer({
    double height = 20,
  }) {
    return ActionSpacer(
      height: height,
    );
  }

  factory MenuAction.search({
    required SearchMenuActionCallBack onSearch,
    Icon? icon,
    InputDecoration? inputDecoration,
  }) {
    return SearchAction(
      onSearch: onSearch,
      icon: icon,
      inputDecoration: inputDecoration,
    );
  }

  factory MenuAction.custom({
    required WidgetBuilder builder,
  }) {
    return CustomMenuAction(
      builder: builder,
    );
  }

  Widget buildAction(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return buildAction(context);
  }
}

class CustomMenuAction extends MenuAction {
  final WidgetBuilder builder;

  const CustomMenuAction({
    super.key,
    required this.builder,
  });

  @override
  Widget buildAction(BuildContext context) {
    return builder.call(context);
  }
}

class ActionSpacer extends MenuAction {
  const ActionSpacer({super.key, this.height = 20});

  final double height;

  @override
  Widget buildAction(BuildContext context) {
    return Container(
      height: height,
    );
  }
}

class ActionDivider extends MenuAction {
  const ActionDivider({super.key});

  @override
  Widget buildAction(BuildContext context) {
    return const Divider(
      thickness: 1,
    );
  }
}

typedef SearchMenuActionCallBack = void Function(
    BuildContext context, String value);

class SearchAction extends MenuAction {
  final SearchMenuActionCallBack onSearch;
  final Icon? icon;
  final InputDecoration? inputDecoration;

  const SearchAction({
    super.key,
    required this.onSearch,
    this.icon,
    this.inputDecoration,
  });

  @override
  Widget buildAction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child:
          SearchInput(onSearch, icon: icon, inputDecoration: inputDecoration),
    );
  }
}

class SearchInput extends StatefulWidget {
  final SearchMenuActionCallBack onSearch;
  final Icon? icon;
  final InputDecoration? inputDecoration;
  const SearchInput(
    this.onSearch, {
    Key? key,
    this.icon,
    this.inputDecoration,
  }) : super(key: key);

  @override
  SearchInputState createState() => SearchInputState();
}

class SearchInputState extends State<SearchInput> {
  String value = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black.withOpacity(0.2),
            )
          ]),
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
}

class TextMenuAction extends MenuAction {
  final String text;
  final IconData? icon;
  final MenuActionCallBack onTap;
  final IconData? trailingIcon;
  final TextStyle style;
  final double leftTextOffset;

  const TextMenuAction(
      {super.key,
      required this.onTap,
      required this.text,
      this.icon,
      this.leftTextOffset = 100,
      this.trailingIcon,
      this.style = const TextStyle()});

  @override
  Widget buildAction(BuildContext context) {
    return InkWell(
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
}
