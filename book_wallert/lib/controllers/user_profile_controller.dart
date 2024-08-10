import 'package:book_wallert/dummy_data/user_dummy.dart';
import 'package:book_wallert/services/user_profile_api_service.dart';
import '../models/user_profile_model.dart';

class GetUserProfileController {
  final GetUserProfileService _getUserProfileService = GetUserProfileService();
  final int userId;

  GetUserProfileController(this.userId);

  Future<UserProfileModel> fetchUserProfile() async {
    try {
      UserProfileModel fetchedUserProfile =
          await _getUserProfileService.fetchUserProfile(userId);
      return fetchedUserProfile;
    } catch (e) {
      print('Error fetching user profile: $e');
    }
    return dummyUserProfile;
  }
}
