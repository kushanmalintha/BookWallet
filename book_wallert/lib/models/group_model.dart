class GroupModel {
  final int group_id;
  final String name;
  final String about;
  final String imageUrl;
  final int memberCount;
  final int discussionCount;
  final List<String>? memberIds;
  late final String? membershipStatus; // New field to handle membership status

  GroupModel({
    required this.group_id,
    required this.name,
    required this.about,
    required this.imageUrl,
    required this.memberCount,
    required this.discussionCount,
    this.memberIds,
    this.membershipStatus, // New field added in the constructor
  });

  // Factory method for creating a GroupModel from JSON
  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      group_id: json['group_id'],
      name: json['group_name'],
      about: json['group_description'],
      imageUrl: json['group_image_url'],
      memberCount: json['memberCount'],
      discussionCount: json['discussionCount'] ?? 0, // Default to 0 if missing
      memberIds: json['memberIds'] != null
          ? List<String>.from(json['memberIds'])
          : [], // Handle null case
      membershipStatus: json['membershipStatus'],
    );
  }

  // Method to convert the GroupModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      'group_id': group_id,
      'group_name': name,
      'group_description': about,
      'group_image_url': imageUrl,
      'memberCount': memberCount,
      'discussionCount': discussionCount,
      'memberIds': memberIds,
      'membershipStatus':
          membershipStatus, //for check user is member or have sent req for group or not
    };
  }
}
