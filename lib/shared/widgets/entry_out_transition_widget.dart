
import 'package:flutter/material.dart';

class EntryOutTransition extends StatelessWidget {
  const EntryOutTransition({
    required this.child,
    required this.entryAnimation,
    this.outAnimation = const AlwaysStoppedAnimation(1),
    this.entryBeginOffset = Offset.zero,
    this.outBeginOffset = Offset.zero,
  });

  final Animation<double> entryAnimation;
  final Animation<double> outAnimation;
  final Offset entryBeginOffset;
  final Offset outBeginOffset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position:
          Tween(begin: outBeginOffset, end: Offset.zero).animate(outAnimation),
      child: FadeTransition(
        opacity: outAnimation,
        child: SlideTransition(
          position: Tween(begin: entryBeginOffset, end: Offset.zero)
              .animate(entryAnimation),
          child: FadeTransition(opacity: entryAnimation, child: child),
        ),
      ),
    );
  }
}