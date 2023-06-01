// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CContainer extends StatefulWidget {
  Widget child;
  Duration? duration;
  EdgeInsets? padding;

  EdgeInsets? margin;
  double? width;
  double? height;
  Alignment? alignment;
  Color? backgroundColor, borderColor;
  bool? isHover;
  CContainer({
    super.key,
    required this.child,
    this.duration,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.alignment,
    this.backgroundColor,
    this.borderColor,
    this.isHover = false,
  });

  @override
  State<CContainer> createState() => _CContainerState();
}

class _CContainerState extends State<CContainer> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => widget.isHover = true),
      onExit: (event) => setState(() => widget.isHover = false),
      child: AnimatedContainer(
        duration: widget.duration ?? const Duration(milliseconds: 200),
        width: widget.width,
        height: widget.height,
        alignment: widget.alignment,
        padding: widget.padding,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: widget.backgroundColor ??
              Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(
            color:
                widget.borderColor ?? Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(2),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(4, 4),
              color: widget.isHover ?? false
                  ? Colors.transparent
                  : widget.borderColor ??
                      Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
