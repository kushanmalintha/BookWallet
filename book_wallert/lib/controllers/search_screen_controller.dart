import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/models/group_model.dart';
import 'package:book_wallert/models/user.dart';
import 'package:book_wallert/services/search_api_service.dart';

class SearchScreenController {
  final SearchApiService _searchApiService = SearchApiService();
  List<BookModel> books = []; // List to store fetched books
  List<User> users = []; // List to store fetched users
  List<GroupModel> groups = []; // List to store fetched groups

  bool isLoading = false; // Flag to track loading state
  int currentPage = 1; // Track the current page of data being fetched

  Future<void> searchBooks(Function onDataFetched, query) async {
    if (isLoading) return; // Prevent concurrent requests
    isLoading = true; // Set loading state to true
    try {
      // Fetch books from the service
      List<BookModel> fetchedBooks =
          await _searchApiService.searchBooks(page: currentPage, query: query);
      books.addAll(fetchedBooks); // Add fetched books to the list
      currentPage++; // Increment page number for the next fetch
      onDataFetched(); // Notify the caller with updated books
    } catch (e) {
      print('Error fetching posts: $e'); // Print error if fetching fails
    } finally {
      isLoading = false; // Set loading state to false after fetching completes
    }
  }

  Future<void> searchUsers(Function onDataFetched, query) async {
    if (isLoading) return; // Prevent concurrent requests
    isLoading = true; // Set loading state to true
    try {
      // Fetch reviews from the service
      List<User> fetchedUsers =
          await _searchApiService.searchUsers(page: currentPage, query: query);
      users.addAll(fetchedUsers); // Add fetched reviews to the list
      currentPage++; // Increment page number for the next fetch
      onDataFetched(); // Notify the caller with updated reviews
    } catch (e) {
      print('Error fetching posts: $e'); // Print error if fetching fails
    } finally {
      isLoading = false; // Set loading state to false after fetching completes
    }
  }

  Future<void> searchGroups(Function onDataFetched, query) async {
    if (isLoading) return; // Prevent concurrent requests
    isLoading = true; // Set loading state to true
    try {
      // Fetch reviews from the service
      List<GroupModel> fetchedGroups =
          await _searchApiService.searchGroups(page: currentPage, query: query);
      groups.addAll(fetchedGroups); // Add fetched reviews to the list
      currentPage++; // Increment page number for the next fetch
      onDataFetched(); // Notify the caller with updated reviews
    } catch (e) {
      print('Error fetching posts: $e'); // Print error if fetching fails
    } finally {
      isLoading = false; // Set loading state to false after fetching completes
    }
  }
}
