class Book {
  int _id;
  String _title;
  String _author;
  String _description;
  double _rating;

  Book({
    required int id,
    required String title,
    required String author,
    required String description,
    required double rating,
  })  : _id = id,
        _title = title,
        _author = author,
        _description = description,
        _rating = rating;

  int get id => _id;
  String get title => _title;
  String get author => _author;
  String get description => _description;
  double get rating => _rating;

  set title(String title) {
    _title = title;
  }

  set author(String author) {
    _author = author;
  }

  set description(String description) {
    _description = description;
  }

  set rating(double rating) {
    _rating = rating;
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      description: json['description'],
      rating: json['rating'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'title': _title,
      'author': _author,
      'description': _description,
      'rating': _rating,
    };
  }
}
