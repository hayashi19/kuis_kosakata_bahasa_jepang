// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CTextfield extends StatefulWidget {
  String? hintText;
  Duration? duration;
  EdgeInsets? margin;
  Color? backgroundColor, borderColor;
  TextEditingController? textEditingController;
  FocusNode? focusNode;
  Function(String value)? onChange;
  Function(String value)? onSubmitted;
  Function()? onEditingComplete;
  CTextfield({
    super.key,
    this.hintText,
    this.duration,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.textEditingController,
    this.focusNode,
    this.onChange,
    this.onEditingComplete,
    this.onSubmitted,
  });

  void _onChange(String value) {
    onChange?.call(value);
    if (onChange != null) {
      onChange!(value);
    }
  }

  void _onEditingComplete() {
    onEditingComplete?.call();
    if (onEditingComplete != null) {
      onEditingComplete!();
    }
  }

  void _onSubmitted(String value) {
    onSubmitted?.call(value);
    if (onSubmitted != null) {
      onSubmitted!(value);
    }
  }

  @override
  State<CTextfield> createState() => _CTextfieldState();
}

class _CTextfieldState extends State<CTextfield> {
  bool _isHover = false, _isFocuse = false;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (value) => setState(() => _isHover = _isFocuse = value),
        child: MouseRegion(
          onEnter: (event) => setState(() => _isHover = true),
          onExit: (event) => setState(
            () => _isFocuse ? _isHover = true : _isHover = false,
          ),
          child: AnimatedContainer(
            duration: widget.duration ?? const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(10),
            margin: widget.margin,
            decoration: BoxDecoration(
              color: widget.backgroundColor ??
                  Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(
                color: widget.borderColor ??
                    Theme.of(context).colorScheme.secondary,
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
              //> textfield
              child: TextField(
                controller: widget.textEditingController,
                keyboardType: TextInputType.text,
                //> function
                onChanged: (searchValue) => widget._onChange(searchValue),
                onEditingComplete: () => widget._onEditingComplete(),
                onSubmitted: (value) => widget._onSubmitted(value),
                //> style
                style: Theme.of(context).textTheme.bodyText2,
                autofocus: false,
                focusNode: widget.focusNode,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.hintText,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .merge(const TextStyle(color: Colors.grey)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: (widget.borderColor ??
                              Theme.of(context).colorScheme.secondary)
                          .withAlpha(50),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.borderColor ??
                          Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.borderColor ??
                          Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
