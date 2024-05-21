import 'package:flutter/material.dart';

import '../../models/typedefs.dart';

class CustomListView<T> extends StatelessWidget {
  const CustomListView({
    super.key,
    this.withExpanded = true,
    this.shrinkWrap = false,
    this.bottomSpacing = 56.0,
    this.axis = Axis.vertical,
    required this.items,
    required this.listBuilder,
    this.controller,
  });

  final bool withExpanded;
  final bool shrinkWrap;
  final double bottomSpacing;
  final Axis axis;
  final List<T> items;
  final ListBuilder<T> listBuilder;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    Widget child = ListView.builder(
      shrinkWrap: shrinkWrap,
      primary: !shrinkWrap,
      scrollDirection: axis,
      controller: this.controller,
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (items.length == index) return SizedBox(height: bottomSpacing);

        return listBuilder(items.elementAt(index));
      },
    );

    if (withExpanded && !shrinkWrap) child = Expanded(child: child);

    return child;
  }
}
