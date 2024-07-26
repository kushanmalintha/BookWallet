class GroupModel {
  final String name;
  final int memberCount;
  final int discussionCount;
  final String imageUrl;
  final String about;
  final List<String> memberIds;

  GroupModel({
    required this.name,
    required this.memberCount,
    required this.discussionCount,
    required this.imageUrl,
    required this.about,
    required this.memberIds,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      name: json['name'],
      memberCount: json['memberCount'],
      discussionCount: json['discussionCount'],
      imageUrl: json['imageUrl'],
      about: json['about'],
      memberIds: List<String>.from(json['memberIds']),
    );
  }

  get reviewerName => null;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'memberCount': memberCount,
      'discussionCount': discussionCount,
      'imageUrl': imageUrl,
      'about': about,
      'memberIds': memberIds,
    };
  }
}
