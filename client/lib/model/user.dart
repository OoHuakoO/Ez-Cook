class User {
  final String email;
  final String imageProfile;
  final String password;
  final String username;
  User.fromJson(Map json)
      : email = json["email"],
        imageProfile = json["imageProfile"],
        password = json["password"],
        username = json["username"];
}
