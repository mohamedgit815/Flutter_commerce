import 'package:avatar_glow/avatar_glow.dart';
import 'package:commerce/App/app.dart';
import 'package:flutter/material.dart';

class AvatarGlowWidget extends StatelessWidget {
  final Widget child;
  const AvatarGlowWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
        duration: const Duration(milliseconds: 1000),
        glowCount: 3,
        glowColor: App.theme.conditionTheme(
            context: context,
            light: App.color.lightMain ,
            dark: App.color.darkMain ,

        ),
      child: child
    );
  }
}
