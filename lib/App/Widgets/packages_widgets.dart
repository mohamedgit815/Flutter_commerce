import 'package:avatar_glow/avatar_glow.dart';
import 'package:commerce/App/WidgetsHelper/Packges/animated_condidtional_builder.dart';
import 'package:commerce/App/WidgetsHelper/Packges/avatar_glow.dart';
import 'package:commerce/App/WidgetsHelper/Packges/responsive_builder.dart';
import 'package:commerce/App/WidgetsHelper/Packges/shimmer.dart';
import 'package:flutter/material.dart';


abstract class BasePackagesWidgets {
  /// Function App for Packages

  // Package ResponsiveBuilder
  ResponsiveBuilderScreen responsiveBuilderScreen({
    required Widget mobile ,
    Widget? tablet ,
    Widget? deskTop
  });


  ConditionalBuilder condition({
    required Duration duration ,
    required bool condition ,
    required WidgetBuilder builder ,
    required WidgetBuilder fallback
  });


  Widget shimmer({required Widget child});

  Widget avatarGlow({required Widget child});

}


class PackagesWidgets implements BasePackagesWidgets {

  @override
  ResponsiveBuilderScreen responsiveBuilderScreen({
    required Widget mobile ,
    Widget? tablet ,
    Widget? deskTop
  }) {
    return ResponsiveBuilderScreen(
      mobile: mobile ,
      tablet: tablet ?? mobile ,
      deskTop:deskTop ?? mobile ,
    );
  }


  @override
  ConditionalBuilder condition({
    required bool condition ,
    required WidgetBuilder builder ,
    required WidgetBuilder fallback ,
    required Duration duration
}) {
    // TODO: implement condition
    return ConditionalBuilder(
        condition: condition,
        builder: builder,
        fallback: fallback ,
        duration: duration ,
    );
  }

  @override
  Widget shimmer({required Widget child}) {
    // TODO: implement shimmer
    return ShimmerWidget(child: child);
  }

  @override
  Widget avatarGlow({required Widget child}) {
    // TODO: implement avatarGlow
    return AvatarGlowWidget(child: child);
  }



}