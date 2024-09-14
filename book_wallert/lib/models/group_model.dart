class GroupModel {
  final int group_id;
  final String name;
  final String about;
  final String imageUrl;
  final String? createdAt; // Allow null values
  final int memberCount;
  final int discussionCount;
  final List<String>? memberIds;

  GroupModel({
    required this.group_id,
    required this.name,
    required this.about,
    required this.imageUrl,
    this.createdAt,
    required this.memberCount,
    required this.discussionCount,
    this.memberIds,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      group_id: json['group_id'], // Ensure correct data type
      name: json['group_name'],
      about: json['group_description'],
      imageUrl: json['group_image_url'],
      createdAt: json['createdAt'], // Optional, can be null
      memberCount: json['memberCount'], // Default to 0 if missing
      discussionCount: json['discussionCount'] ?? 0, // Default to 0 if missing
      memberIds: json['memberIds'] != null
          ? List<String>.from(json['memberIds'])
          : [], // Handle null case
    );
  }

  get id => null;

  Map<String, dynamic> toJson() {
    return {
      'group_id': group_id,
      'group_name': name,
      'group_description': about,
      'group_image_url': imageUrl,
      'createdAt': createdAt,
      'memberCount': memberCount,
      'discussionCount': discussionCount,
      'memberIds': memberIds,
    };
  }
}
