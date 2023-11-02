part of '../login_screen.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [KColors.vividTangerine, KColors.iris],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.decal,
        ),
      ),
    );
  }
}
