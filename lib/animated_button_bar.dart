library flex_animated_button_bar;

import 'package:flutter/material.dart';

class AnimatedButtonBarController {
  AnimatedButtonBarController();

  Function(int index)? _onChange;
  void _onChangeListener(Function(int index) onChange) {
    _onChange = onChange;
  }

  void changeIndex(int index) {
    _onChange?.call(index);
  }
}

///A row of buttons with animated selection
class FlexAnimatedButtonBar extends StatefulWidget {
  ///Duration for the selection animation
  final Duration animationDuration;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BoxBorder? foregroundBoxBorder;
  final double radius;

  ///A list of [ButtonBarEntry] to display
  final List<ButtonBarEntry> children;
  final double innerVerticalPadding;
  final double elevation;
  final Color? borderColor;
  final double? borderWidth;
  final Curve curve;
  final EdgeInsets padding;
  final double spacing;
  final int defultIndex;
  final Function(int index)? onChanged;

  ///Invert color of the child when true
  final bool invertedSelection;

  final AnimatedButtonBarController? controller;

  const FlexAnimatedButtonBar({
    Key? key,
    this.controller,
    required this.children,
    this.animationDuration = const Duration(milliseconds: 200),
    this.backgroundColor,
    this.foregroundColor,
    this.foregroundBoxBorder,
    this.radius = 0.0,
    this.innerVerticalPadding = 8.0,
    this.elevation = 0,
    this.borderColor,
    this.borderWidth,
    this.spacing = 0,
    this.defultIndex = 0,
    this.curve = Curves.fastOutSlowIn,
    this.padding = const EdgeInsets.all(0),
    this.invertedSelection = false,
    this.onChanged,
  }) : super(key: key);

  @override
  _FlexAnimatedButtonBarState createState() => _FlexAnimatedButtonBarState();
}

class _FlexAnimatedButtonBarState extends State<FlexAnimatedButtonBar> {
  int _index = 0;
  @override
  void initState() {
    _index = widget.defultIndex;
    super.initState();
    widget.controller?._onChangeListener((i) => setState(() => _index = i));
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        widget.backgroundColor ?? Theme.of(context).backgroundColor;
    return Padding(
      padding: widget.padding,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Card(
          color: backgroundColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              side: BorderSide(
                color: widget.borderColor ?? Colors.transparent,
                width: widget.borderWidth ??
                    (widget.borderColor != null ? 1.0 : 0.0),
              )),
          elevation: widget.elevation,
          child: Stack(
            fit: StackFit.loose,
            children: [
              AnimatedPositioned(
                top: 0,
                bottom: 0,
                left: _index == 0
                    ? 0
                    : _index == 1
                        ? (constraints.maxWidth) / 2
                        : ((constraints.maxWidth) / 2) +
                            (((constraints.maxWidth) / 2) / 2),
                right: _index == 2
                    ? 0
                    : _index == 1
                        ? ((constraints.maxWidth) / 2) / 2
                        : (constraints.maxWidth) / 2,
                duration: widget.animationDuration,
                curve: widget.curve,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: widget.spacing),
                  decoration: BoxDecoration(
                    color: widget.foregroundColor ??
                        Theme.of(context).colorScheme.secondary,
                    border: widget.foregroundBoxBorder,
                    borderRadius:
                        BorderRadius.all(Radius.circular(widget.radius)),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: widget.children
                    .asMap()
                    .map((i, sideButton) => MapEntry(
                          i,
                          Expanded(
                            flex: sideButton.flex,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: widget.spacing),
                              child: InkWell(
                                onTap: () {
                                  try {
                                    sideButton.onTap();
                                    widget.onChanged?.call(i);
                                  } catch (e) {
                                    print('onTap implementation is missing');
                                  }
                                  setState(() {
                                    _index = i;
                                  });
                                },
                                borderRadius: BorderRadius.all(
                                    Radius.circular(widget.radius)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: widget.innerVerticalPadding),
                                  child: Center(
                                      child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              backgroundColor,
                                              widget.invertedSelection &&
                                                      _index == i
                                                  ? BlendMode.srcIn
                                                  : BlendMode.dstIn),
                                          child:
                                              sideButton.child(_index == i))),
                                ),
                              ),
                            ),
                          ),
                        ))
                    .values
                    .toList(),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ButtonBarEntry {
  final Widget Function(bool isActive) child;
  final int flex;
  final VoidCallback onTap;
  ButtonBarEntry(
      {required this.child, required this.flex, required this.onTap});
}
