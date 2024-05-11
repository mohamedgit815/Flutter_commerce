import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';

class ConditionalBuilder extends StatelessWidget {
  final bool condition ;
  final WidgetBuilder builder ;
  final WidgetBuilder? fallback ;
  final Duration? duration , reverseDuration ;
  final Curve? switchInCurve , switchOutCurve ;
  final AnimatedSwitcherTransitionBuilder? transitionBuilder ;
  final AnimatedSwitcherLayoutBuilder? layoutBuilder ;

  const ConditionalBuilder({
    super.key ,
    required this.condition ,
    required this.builder ,
    required this.fallback ,
    this.duration ,
    this.reverseDuration ,
    this.switchOutCurve ,
    this.switchInCurve ,
    this.layoutBuilder ,
    this.transitionBuilder ,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedConditionalBuilder(
        condition: condition,
        builder: builder,
        fallback: fallback ,
        transitionBuilder: transitionBuilder ,
        layoutBuilder: layoutBuilder ,
        switchInCurve: switchInCurve ,
        switchOutCurve: switchOutCurve ,
        reverseDuration: reverseDuration ,
        duration: duration,
    );
  }
}
