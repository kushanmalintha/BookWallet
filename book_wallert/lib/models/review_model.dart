class ReviewModel {
  final int reviewId;
  final int bookId;
  final int userId;
  final String imagePath;
  final String bookName;
  final String authorName;
  final String context;
  final double rating;
  final String date;
  final String reviwerName;
  late final int likesCount;
  final int commentsCount;
  final int sharesCount;

  ReviewModel({
    required this.reviewId,
    required this.bookId,
    required this.userId,
    required this.imagePath,
    required this.bookName,
    required this.authorName,
    required this.context,
    required this.rating,
    required this.date,
    required this.reviwerName,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
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
      date: json['date'],
      reviwerName: json['reviwerName'],
      likesCount: json['likesCount'], // Nullable
      commentsCount: json['commentsCount'], // Nullable
      sharesCount: json['sharesCount'], // Nullable
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
      'date': date,
      'reviwerName': reviwerName,
      'likesCount': likesCount, // Nullable
      'commentsCount': commentsCount, // Nullable
      'sharesCount': sharesCount, // Nullable
    };
  }
}
