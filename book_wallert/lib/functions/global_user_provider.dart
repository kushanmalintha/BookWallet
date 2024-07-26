import 'package:book_wallert/models/user.dart';

User? _user;

User? get globalUser => _user;

void setUser(User user) {
  _user = user;
}

void clearUser() {
  _user = null;
}
