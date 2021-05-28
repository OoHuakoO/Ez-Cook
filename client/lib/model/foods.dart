class Foods {
  List<String> howCook;
  List<String> ingredient;
  int like;
  String timeCook;
  String nameFood;
  String linkYoutube;
  int date;
  String userId;
  String imageFood;
  String categoryFood;
  String username;
  String imageProfile;

  Foods(
      {this.howCook,
      this.ingredient,
      this.like,
      this.timeCook,
      this.nameFood,
      this.linkYoutube,
      this.date,
      this.userId,
      this.imageFood,
      this.categoryFood,
      this.username,
      this.imageProfile});

  Foods.fromJson(Map<String, dynamic> json) {
    howCook = json['howCook'].cast<String>();
    ingredient = json['ingredient'].cast<String>();
    like = json['like'];
    timeCook = json['timeCook'];
    nameFood = json['nameFood'];
    linkYoutube = json['linkYoutube'];
    date = json['date'];
    userId = json['userId'];
    imageFood = json['imageFood'];
    categoryFood = json['categoryFood'];
    username = json['username'];
    imageProfile = json['imageProfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['howCook'] = this.howCook;
    data['ingredient'] = this.ingredient;
    data['like'] = this.like;
    data['timeCook'] = this.timeCook;
    data['nameFood'] = this.nameFood;
    data['linkYoutube'] = this.linkYoutube;
    data['date'] = this.date;
    data['userId'] = this.userId;
    data['imageFood'] = this.imageFood;
    data['categoryFood'] = this.categoryFood;
    data['username'] = this.username;
    data['imageProfile'] = this.imageProfile;
    return data;
  }
}
