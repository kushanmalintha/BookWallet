class BookModel {
  final String title;
  final String author;
  final int pages;
  final String genre;
  final double totalRating;
  final String imageUrl;

  BookModel({
    required this.title,
    required this.author,
    required this.pages,
    required this.genre,
    required this.totalRating,
    required this.imageUrl,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'],
      author: json['author'],
      pages: json['pages'],
      genre: json['genre'],
      totalRating: json['totalRating'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'pages': pages,
      'genre': genre,
      'totalRating': totalRating,
      'imageUrl': imageUrl,
    };
  }
}
