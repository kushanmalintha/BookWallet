class GroupModel {
  final String name;
  final int memberCount;
  final int discussionCount;
  final String imageUrl;

  GroupModel({
    required this.name,
    required this.memberCount,
    required this.discussionCount,
    required this.imageUrl,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      name: json['name'],
      memberCount: json['memberCount'],
      discussionCount: json['discussionCount'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'memberCount': memberCount,
      'discussionCount': discussionCount,
      'imageUrl': imageUrl,
    };
  }
}
