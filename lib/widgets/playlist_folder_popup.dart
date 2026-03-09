import 'package:flutter/material.dart';

import 'package:popover/popover.dart';
import 'package:smash_music_app/db/functions/playlist_func.dart';
import 'package:smash_music_app/widgets/all_color.dart';

class PlaylistFolderPopUp extends StatelessWidget {
  final String folderName;
  final int index;
  const PlaylistFolderPopUp(
      {super.key, required this.folderName, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopover(
          direction: PopoverDirection.bottom,
          context: context,
          bodyBuilder: (context) {
            return Column(
              children: [removeFolder(context), editFolder(context)],
            );
          },
          width: 250,
          height: 100),
      child: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
    );
  }

  GestureDetector removeFolder(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PlaylistFunc.deletePlaylist(index);
      
        Navigator.pop(context);
      },
      child: Container(
        height: 50,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Remove Folder'),
          ],
        ),
      ),
    );
  }

  GestureDetector editFolder(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
        PlaylistEditName editName = PlaylistEditName();
        Navigator.pop(context);
        editName.folderNameAlertDialog(context, index, folderName);
       
       
      },
      child: Container(
        height: 50,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Edit Folder Name'),
          ],
        ),
      ),
    );
  }

 
}

class PlaylistEditName {
  final _key = GlobalKey<FormState>();
  String folderName = "";
  TextEditingController folderNameController = TextEditingController();
  void saveEditFolder(int index) {
    final isValid = _key.currentState?.validate();

    if (isValid != null && isValid) {
      _key.currentState?.save();
      PlaylistFunc.updateFolderName(index, folderName);
    }
  }

  Future<dynamic> folderNameAlertDialog(
      BuildContext context, int index, String PlaylistFolderName) {
    folderNameController.text = PlaylistFolderName;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Give your playlist a name',style: TextStyle(color: itembgcolor),),
          content: Form(
            key: _key,
            child: TextFormField(
              controller: folderNameController,
              decoration: InputDecoration(labelText: 'Folder Name'),
              onSaved: (value) {
                folderName = value.toString();
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                saveEditFolder(index);
                Navigator.pop(context);
                folderNameController.clear();
              },
              child: Text(
                'Save',
              ),
            )
          ],
        );
      },
    );
  }
}
