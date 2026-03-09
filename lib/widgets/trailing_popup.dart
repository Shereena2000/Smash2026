import 'package:flutter/material.dart';

import 'package:popover/popover.dart';
import 'package:smash_music_app/db/functions/fvrt_function.dart';
import 'package:smash_music_app/db/model/data_model.dart';
import 'package:smash_music_app/widgets/all_color.dart';
import 'package:smash_music_app/widgets/playlist_bottom_sheet.dart';

class PopUp extends StatelessWidget {
  final Music song;
  const PopUp({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    TextStyle smallTextStyle = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 15, color: itembgcolor);
    return GestureDetector(
      onTap: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  playlistBottomSheet(context, song);
                },
                child: Container(
                  height: 40,
                  child: Center(
                    child: Text("Add to playlist", style: smallTextStyle),
                  ),
                ),
              ),
              if (FavoriteFunctions.isFavour(song) == false)
                GestureDetector(
                  onTap: () {
                    FavoriteFunctions.addToFavorite(song: song);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        "Add to Favorite",
                        style: smallTextStyle,
                      ),
                    ),
                  ),
                ),
              if (FavoriteFunctions.isFavour(song) == true)
                GestureDetector(
                  onTap: () {
                    FavoriteFunctions.deleteFromFav(song.id);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        "Remove from Favorite",
                        style: smallTextStyle,
                      ),
                    ),
                  ),
                )
            ],
          ),
          onPop: () {},
          direction: PopoverDirection.left,
          width: 180,
          height: 80,
        );
      },
      child: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
    );
  }
}
