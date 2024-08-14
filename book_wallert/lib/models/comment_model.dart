class Comment {
  final int commentId;
  final int userId;
  final int reviewId;
  final String context;
  final String date;
  final String time;
  final String username;

  Comment({
    required this.commentId,
    required this.userId,
    required this.reviewId,
    required this.context,
    required this.date,
    required this.time,
    required this.username,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'],
      userId: json['userId'],
      reviewId: json['reviewId'],
      context: json['context'],
      date: json['date'],
      time: json['time'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'userId': userId,
      'reviewId': reviewId,
      'context': context,
      'date': date,
      'time': time,
      'username': username,
    };
  }
}
