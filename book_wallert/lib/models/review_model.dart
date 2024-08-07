class ReviewModel {
  final int reviewId;
  final int bookId;
  final int userId;
  final String imagePath;
  final String bookName;
  final String authorName;
  final String context;
  final double rating;
  final String reviwerName;

  ReviewModel({
    required this.reviewId,
    required this.bookId,
    required this.userId,
    required this.imagePath,
    required this.bookName,
    required this.authorName,
    required this.context,
    required this.rating,
    required this.reviwerName,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: json['reviewId'],
      bookId: json['bookId'],
      userId: json['userId'],
      imagePath: json['imagePath'],
      bookName: json['bookName'],
      authorName: json['authorName'],
      context: json['context'],
      rating: json['rating'].toDouble(),
      reviwerName: json['reviwerName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewId': reviewId,
      'bookId': bookId,
      'userId': userId,
      'imagePath': imagePath,
      'bookName': bookName,
      'authorName': authorName,
      'context': context,
      'rating': rating,
      'reviwerName': reviwerName,
    };
  }
}
