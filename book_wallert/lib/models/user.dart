class User {
  int _userId;
  String _username;
  String _email;
  String _description;
  String _imageUrl;

  User({
    required int userId,
    required String username,
    required String email,
    String description = '',
    String imageUrl = 'images/userimage.jpg',
  })  : _userId = userId,
        _username = username,
        _email = email,
        _description = description,
        _imageUrl = imageUrl;

  int get userId => _userId;
  String get username => _username;
  String get email => _email;
  String get description => _description;
  String get imageUrl => _imageUrl;

  set username(String username) {
    _username = username;
  }

  set email(String email) {
    _email = email;
  }

  set description(String description) {
    _description = description;
  }

  set imageUrl(String imageUrl) {
    _imageUrl = imageUrl;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      username: json['username'],
      email: json['email'],
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? 'images/userimage.jpg',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': _userId,
      'username': _username,
      'email': _email,
      'description': _description,
      'imageUrl': _imageUrl,
    };
  }
}







// void main() {
//   // Example usage
//   // Create a User object using the constructor
//   User user = User(id: 1, username: 'john_doe', email: 'john@example.com');

//   // Accessing user data using getters
//   print(user.id); // Output: 1
//   print(user.username); // Output: john_doe
//   print(user.email); // Output: john@example.com

//   // Using setters to update user data
//   user.username = 'jane_doe'; // Update username
//   user.email = 'jane@example.com'; // Update email

//   // Accessing updated user data using getters
//   print(user.username); // Output: jane_doe (updated value)
//   print(user.email); // Output: jane@example.com (updated value)

//   // Convert User object to JSON format using toJson method
//   Map<String, dynamic> userJson = user.toJson();
//   print(userJson); // Output: {id: 1, username: jane_doe, email: jane@example.com}

//   // Example of creating User object from JSON data using fromJson factory method
//   Map<String, dynamic> json = {
//     'id': 2,
//     'username': 'alice_smith',
//     'email': 'alice@example.com',
//   };

//   User anotherUser = User.fromJson(json);
//   print(anotherUser.username); // Output: alice_smith
// }
