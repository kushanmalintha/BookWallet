class User {
  int _id;
  String _username;
  String _email;

  User({required int id, required String username, required String email})
      : _id = id,
        _username = username,
        _email = email;

  int get id => _id;
  String get username => _username;
  String get email => _email;

  set username(String username) {
    _username = username;
  }

  set email(String email) {
    _email = email;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'username': _username,
      'email': _email,
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
