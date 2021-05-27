class Food {
  final String nameFood;
  final String timeCook;
  final String categoryFood;
  final List ingredient;
  final String linkYoutube;
  final List howCook;
  final String imageFood;
  final int like;
  final String username;
  final String imageProfile;

  Food.fromJson(Map json)
      : nameFood = json["nameFood"],
        timeCook = json["timeCook"],
        categoryFood = json["categoryFood"],
        ingredient = json["ingredient"],
        linkYoutube = json["linkYoutube"],
        howCook = json["howCook"],
        imageFood = json["imageFood"],
        like = json['like'],
        username = json['username'],
        imageProfile = json['imageProfile'];
}
