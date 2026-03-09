import 'package:flutter/material.dart';
import 'package:smash_music_app/db/model/playlist_model.dart';
import 'package:smash_music_app/screens/playlist_screen_4_each_folder.dart';
import 'package:smash_music_app/widgets/constant.dart';
import 'package:smash_music_app/widgets/playlist_folder_popup.dart';


class PlaylistFolder extends StatelessWidget {
  final Playlist playlistObj;
  final int index;
  const PlaylistFolder({
    super.key,
    required this.playlistObj,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlaylistFolderScreen(
                    playlistObj: playlistObj,
                    playlistIndex: index,
                  ))),
      child: ListTile(
          leading: Container(
            height: 80.0,
            width: 70.0,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: const DecorationImage(
                image: AssetImage('assets/images/music2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            playlistObj.name,
            maxLines: 1,
            style: commontext,
          ),
          trailing: PlaylistFolderPopUp(
            folderName: playlistObj.name,
            index: index,
          )),
    );
  }
}