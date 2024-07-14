// review_model.dart

class ReviewModel {
  final String imagePath;
  final String bookName;
  final String authorName;
  final String description;
  final double rating;
  final String reviewedBy;
  final String userName;

  ReviewModel({
    required this.imagePath,
    required this.bookName,
    required this.authorName,
    required this.description,
    required this.rating,
    required this.reviewedBy,
    required this.userName,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      imagePath: json['imagePath'],
      bookName: json['bookName'],
      authorName: json['authorName'],
      description: json['description'],
      rating: json['rating'].toDouble(),
      reviewedBy: json['reviewedBy'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'bookName': bookName,
      'authorName': authorName,
      'description': description,
      'rating': rating,
      'reviewedBy': reviewedBy,
      'userName': userName,
    };
  }
}
