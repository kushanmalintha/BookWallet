class BookModel {
  final String title;
  final String author;
  final int pages;
  final String genre;
  final String ISBN10;
  final String ISBN13;
  final int totalRating;
  final String publishedDate;
  final String imageUrl;
  final String description;
  final String resource;

  BookModel({
    this.title = '',
    this.author = '',
    this.pages = 0,
    this.genre = '',
    this.ISBN10 = '',
    this.ISBN13 = '',
    this.publishedDate = '',
    this.totalRating = 0,
    this.imageUrl = '',
    this.description = '',
    this.resource = '',
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'],
      author: json['author'],
      pages: json['pages'],
      genre: json['genre'],
      ISBN10: json['ISBN10'],
      ISBN13: json['ISBN13'],
      publishedDate: json['publishedDate'],
      totalRating: json['totalRating'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      resource: json['resource'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'pages': pages,
      'genre': genre,
      'ISBN10': ISBN10,
      'ISBN13': ISBN13,
      'publishedDate': publishedDate,
      'totalRating': totalRating,
      'imageUrl': imageUrl,
      'description': description,
      'resource': resource,
    };
  }
}
