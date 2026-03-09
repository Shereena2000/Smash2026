import "package:flutter/material.dart";
import "package:smash_music_app/widgets/glass_container.dart";

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: GlassContainer(
        width: 45,
        height: 45,
        padding: EdgeInsets.zero,
        blur: 15,
        opacity: 0.2,
        borderRadius: BorderRadius.circular(15),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
