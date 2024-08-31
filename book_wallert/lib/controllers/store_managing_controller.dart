import '../models/shop_model.dart';
import '../services/store_managing_api_service.dart';

class ShopController {
  late final ShopService _shopService;
  List<Shop> shops = [];
  bool isLoading = true;

  ShopController() {
    _shopService = ShopService(); // Ensure the correct URL is used
  }

  Future<void> fetchShops(int bookId) async {
    try {
      isLoading = true;
      shops = await _shopService.fetchShopsForBook(bookId);
    } catch (e) {
      print('Error fetching shops: $e');
    } finally {
      isLoading = false;
    }
  }
}
