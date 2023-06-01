// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CButton extends StatefulWidget {
  Widget child;
  double? widht, heigh;
  EdgeInsets? margin;
  Color? backgroundColor, borderColor;
  Function() onTap;

  CButton({
    super.key,
    required this.child,
    this.widht,
    this.heigh,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    required this.onTap,
  });

  @override
  State<CButton> createState() => _CButtonState();
}

class _CButtonState extends State<CButton> {
  bool _isHover = false, _isFocuse = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHover = _isFocuse = true),
      onExit: (event) => setState(() => _isHover = _isFocuse = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: widget.widht,
        height: widget.heigh,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(
            color:
                widget.borderColor ?? Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(2),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(4, 4),
              color: _isHover
                  ? Colors.transparent
                  : widget.borderColor ??
                      Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              widget.onTap();
              setState(() => _isHover = true);
              if (!_isFocuse) {
                await Future.delayed(
                  const Duration(
                    milliseconds: 140,
                  ),
                ).then(
                  (value) => setState(
                    () => _isHover = false,
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
