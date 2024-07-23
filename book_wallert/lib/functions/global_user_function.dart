import 'package:book_wallert/models/user.dart';

User createUser(int id, String username, String email) {
  return User(id: id, username: username, email: email);
}
