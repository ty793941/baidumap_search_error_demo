import 'dart:math';

import 'package:flutter/material.dart';

class MyDraggableSheetWidget extends StatefulWidget {
  final double? initialChildSize;
  final double? maxChildSize;
  final double? minChildSize;
  final List<double>? snapSizes;
  final Widget Function(
    BuildContext context,
    ScrollController scrollController,
  ) itemBuilder;
  final Function(double)? onDragUpdate;

  const MyDraggableSheetWidget({this.initialChildSize, this.maxChildSize, this.minChildSize, this.snapSizes, required this.itemBuilder, this.onDragUpdate});

  @override
  State<MyDraggableSheetWidget> createState() => _MyDraggableSheetWidgetState();
}

class _MyDraggableSheetWidgetState extends State<MyDraggableSheetWidget> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onChanged);
  }

  void onChanged() {
    final currentSize = controller.size;
    if (currentSize <= 0.05) collapse();
    if (widget.onDragUpdate != null) {
      widget.onDragUpdate!(controller.size);
    }
  }

  void collapse() => animateSheet(getSheet.snapSizes!.first);

  void animateSheet(double size) {
    controller.animateTo(
      size,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  DraggableScrollableSheet get getSheet => (sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    // return LayoutBuilder(builder: (context, constraints) {
    return DraggableScrollableSheet(
      key: sheet,
      initialChildSize: widget.initialChildSize ?? 180 / MediaQuery.of(context).size.height,
      maxChildSize: widget.maxChildSize ?? 0.95,
      minChildSize: widget.minChildSize ?? 0,
      expand: true,
      snap: true,
      snapSizes: widget.snapSizes ?? [180 / MediaQuery.of(context).size.height, 0.7, 0.9],
      controller: controller,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, -6),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: CustomScrollView(controller: scrollController, slivers: [
              SliverPersistentHeader(pinned: true, delegate: _SliverAppBarDelegate(minHeight: 40, maxHeight: 40, child: topButtonIndicator())),
              SliverToBoxAdapter(
                  child: Container(
                child: widget.itemBuilder(
                  context,
                  scrollController,
                ),
              )),
              const SliverPadding(padding: EdgeInsets.only(bottom: 100))
            ]));
      },
    );
    // } );
  }

  Widget topButtonIndicator() {
    return Container(
        width: 40,
        margin: const EdgeInsets.only(top: 15, bottom: 15),
        height: 5,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      child: Align(
          alignment: Alignment.topCenter, // 可以根据需求调整对齐方式
          child: child),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}
