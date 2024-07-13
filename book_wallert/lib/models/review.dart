class Review {
  int _id;
  int _userId;
  int _bookId;
  String _comment;
  double _rating;

  Review({
    required int id,
    required int userId,
    required int bookId,
    required String comment,
    required double rating,
  })  : _id = id,
        _userId = userId,
        _bookId = bookId,
        _comment = comment,
        _rating = rating;

  int get id => _id;
  int get userId => _userId;
  int get bookId => _bookId;

  String get comment => _comment;
  double get rating => _rating;

  set comment(String comment) {
    _comment = comment;
  }

  set rating(double rating) {
    _rating = rating;
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      userId: json['userId'],
      bookId: json['bookId'],
      comment: json['comment'],
      rating: json['rating'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'userId': _userId,
      'bookId': _bookId,
      'comment': _comment,
      'rating': _rating,
    };
  }
}
