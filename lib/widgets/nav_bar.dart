import "package:flutter/material.dart";

import "package:smash_music_app/screens/favorite_screen.dart";
import "package:smash_music_app/screens/home_screen.dart";
import "package:smash_music_app/screens/search_screen.dart";
import "package:smash_music_app/screens/tab_screen/song_screen.dart";
import "package:smash_music_app/widgets/all_color.dart";

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: Colors.white,
      selectedItemColor: itemcolor,
      backgroundColor: itembgcolor,
      iconSize: 30,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Music'),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) =>const  HomeScreen()));
            break;
          case 1:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>const  SongScreen(initialTabIndex: 0)));
            break;
          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>const  FavoriteScreen()));
            break;
          case 3:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>const  SearchScreen()));
            break;
        }
      },
    );
  }
}
