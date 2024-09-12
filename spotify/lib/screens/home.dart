import 'package:flutter/material.dart';
import 'package:spotify/models/Category.dart';
import 'package:spotify/models/CategoryOperation.dart';
import 'package:spotify/models/music.dart';
import 'package:spotify/services/music_operations.dart';

class Home extends StatelessWidget {
  final Function(Music) updateMiniPlayer;

  Home(this.updateMiniPlayer);

  List<Widget> createListOfCategories() {
    List<Category> categories = CategoryOperations.getCategories();
    return categories.map((category) {
      return Container(
        width: 150,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(category.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  category.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget createMusicList(String label) {
    List<Music> musicList = MusicOperations.getMusic();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        Container(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: musicList.length,
            itemBuilder: (context, index) {
              return createMusic(musicList[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget createMusic(Music music) {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 200,
            child: InkWell(
              onTap: () {
                updateMiniPlayer(music);
              },
              child: Image.network(music.imageUrl, fit: BoxFit.cover),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[900],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            music.name,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            music.desc,
            style: TextStyle(color: Colors.white, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget createGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(8.0),
      crossAxisCount: 2,
      childAspectRatio: 2,
      children: createListOfCategories(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Color.fromARGB(255, 93, 102, 109),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              foregroundColor: Color.fromARGB(255, 223, 136, 231),
              title: Text("Good Morning"),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(Icons.settings),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: createGrid(),
            ),
            SliverToBoxAdapter(
              child: createMusicList("Suggested For You"),
            ),
            SliverToBoxAdapter(
              child: createMusicList("Popular Playlist"),
            ),
          ],
        ),
      ),
    );
  }
}
