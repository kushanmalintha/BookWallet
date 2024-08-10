class UserProfileModel {
  final String username;

  UserProfileModel({
    required this.username,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(username: json['username']);
  }

  Map<String, dynamic> toJson() {
    return {'username': username};
  }
}
