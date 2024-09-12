import 'package:spotify/models/Category.dart';

class CategoryOperations {
  static List<Category> getCategories() {
    return <Category>[
      Category("Top Songs",
          "https://wrapped-images.spotifycdn.com/image/yts-2023/default/your-top-songs-2023_DEFAULT_en.jpg"),
      Category("New Releases",
          "https://storage.googleapis.com/pr-newsroom-wp/1/2019/10/New-Release-Burst2-768x381.jpg"),
      Category("Charts",
          "https://variety.com/wp-content/uploads/2020/10/chartspress-2.jpg"),
      Category("Genres",
          "https://miro.medium.com/v2/resize:fit:2000/1*E3a2meIx2byinkTnjf8UYg.jpeg"),
      // Add more categories as needed
    ];
  }
}
