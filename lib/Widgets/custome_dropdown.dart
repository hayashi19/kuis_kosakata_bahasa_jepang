// ignore_for_file: iterable_contains_unrelated_type, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CDropdown extends StatefulWidget {
  bool isSingleValue;
  String? hint;
  String title, check;
  Duration? duration;
  Color? backgroundColor, borderColor;
  List<Map> value, selectedValue;
  bool expandValueDisplay;
  Function() onChange;
  CDropdown({
    Key? key,
    this.isSingleValue = false,
    this.hint,
    this.title = 'title',
    this.check = 'check',
    this.duration,
    this.backgroundColor,
    this.borderColor,
    required this.value,
    required this.selectedValue,
    required this.onChange,
    this.expandValueDisplay = false,
  }) : super(key: key);

  @override
  State<CDropdown> createState() => _CDropdownState();
}

class _CDropdownState extends State<CDropdown> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHover = true),
      onExit: (event) => setState(() => _isHover = false),
      child: AnimatedContainer(
        duration: widget.duration ?? const Duration(milliseconds: 200),
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
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<dynamic>(
              //> style
              isExpanded: true,
              isDense: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: InputBorder.none,
              ),

              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              icon: Icon(
                Icons.arrow_drop_down_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
              //> hint
              value: null,
              hint: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "${widget.hint}",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: widget.expandValueDisplay
                        ? SingleChildScrollView(
                            child: Text(
                              '${widget.selectedValue.map((element) => element[widget.title]).toList()}',
                              softWrap: true,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          )
                        : Text(
                            '${widget.selectedValue.map((element) => element[widget.title]).toList()}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                  ),
                ],
              ),
              //> item choice
              items: List.generate(
                widget.value.length,
                (index) => DropdownMenuItem(
                  value: widget.value[index][widget.title],
                  child: Theme(
                    data: ThemeData(
                        unselectedWidgetColor:
                            Theme.of(context).colorScheme.secondary),
                    child: CheckboxListTile(
                      //> style
                      checkColor: Theme.of(context).scaffoldBackgroundColor,
                      activeColor: Theme.of(context).colorScheme.primary,
                      dense: true,
                      //> check box title
                      title: Text(
                        "${widget.value[index][widget.title]}",
                        style: Theme.of(context).textTheme.bodyText2!.merge(
                              TextStyle(
                                color: widget.value[index][widget.check]
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                      ),
                      //> value
                      value: widget.value[index][widget.check],
                      onChanged: (value) {
                        setState(() {
                          if (widget.isSingleValue) {
                            //[] set all checkbock to false
                            for (var element in widget.value) {
                              element[widget.check] = false;
                            }
                          }
                          //[] set the selected checkbox value to true
                          widget.value[index][widget.check] = value;
                          //[] check if selected value exist in the selected list
                          if (widget.selectedValue
                              .contains(widget.value[index])) {
                            //[] remove it
                            widget.selectedValue.remove(widget.value[index]);
                          } else {
                            //[] add it
                            if (widget.isSingleValue) {
                              widget.selectedValue.first = widget.value[index];
                            } else {
                              widget.selectedValue.add(widget.value[index]);
                            }
                          }
                          //[] prevent null value
                          if (widget.selectedValue.isEmpty) {
                            "tidak boleh kosong".printInfo();
                            widget.selectedValue.clear();
                            widget.selectedValue.add(widget.value.first);
                            widget.value.first[widget.check] = true;
                          }
                          widget.onChange();
                          Get.back();
                        });
                      },
                    ),
                  ),
                ),
              ),
              //> function
              onChanged: (value) {
                "$value telah dipilih".printInfo();
              },
            ),
          ),
        ),
      ),
    );
  }
}
