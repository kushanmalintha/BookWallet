import 'package:book_wallert/colors.dart'; // Importing custom color palette.
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart'; // Importing Flutter's material library for UI components.

/// A custom popup menu widget that displays a list of items when an icon is tapped.
///
/// This widget takes a list of strings (`items`) to display in the menu and a
/// list of callback functions (`onItemTap`) to invoke when an item is selected.
/// An optional `onOpened` callback can be provided to asynchronously determine
/// if the menu should be displayed. The popup menu will appear at the tap position
/// and is triggered by an icon.
///
/// While waiting for the `onOpened` function to complete, a loading animation will be shown.
///
/// Example usage:
/// ```dart
/// CustomPopupMenuButtonsDynamic(
///   items: ['Item 1', 'Item 2', 'Item 3'],
///   onItemTap: [() => print('Item 1'), () => print('Item 2'), () => print('Item 3')],
///   icon: Icon(Icons.more_vert),
///   onOpened: (items) async {
///     // Perform some async work before showing the menu
///     return true;
///   },
/// );
/// ```
class CustomPopupMenuButtonsDynamic extends StatefulWidget {
  /// A list of text labels to display in the popup menu.
  final List<String> items;

  /// A list of callback functions that correspond to each item in the menu.
  /// The function at index `i` will be called when the `i-th` item is selected.
  final List<Function> onItemTap;

  /// The icon to display that will trigger the popup menu when tapped.
  final Icon icon;

  /// A callback that is called when the icon is tapped.
  /// It takes the list of `items` and returns a `Future<bool?>`. If the future
  /// returns `true`, the menu will be shown.
  final Future<bool?> Function(List<String>)? onOpened;

  /// Creates a [CustomPopupMenuButtonsDynamic] widget.
  ///
  /// The [items], [onItemTap], and [icon] arguments must be provided.
  /// The [onOpened] callback is optional.
  const CustomPopupMenuButtonsDynamic({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.icon,
    this.onOpened,
  });

  @override
  State<CustomPopupMenuButtonsDynamic> createState() =>
      _CustomPopupMenuButtonsDynamicState();
}

class _CustomPopupMenuButtonsDynamicState
    extends State<CustomPopupMenuButtonsDynamic> {
  bool _isLoading = false; // State variable to manage loading state.

  /// Shows the popup menu at the tapped position.
  ///
  /// If [widget.onOpened] is provided, it is called before showing the menu.
  /// The menu will only be displayed if `onOpened` returns `true`.
  /// While waiting for the async response, a loading animation is shown.
  Future<void> _showMenu(BuildContext context, TapDownDetails details) async {
    if (widget.onOpened != null) {
      setState(() {
        _isLoading =
            true; // Show loading indicator while async operation is in progress.
      });

      // Call the onOpened function to check if the menu should be shown.
      bool? shouldShowMenu = await widget.onOpened!(widget.items);

      setState(() {
        _isLoading =
            false; // Hide loading indicator once async operation is complete.
      });

      if (shouldShowMenu == true) {
        // Calculate the position where the menu should be displayed.
        final position = RelativeRect.fromLTRB(
          details.globalPosition.dx, // X position of the tap.
          details.globalPosition.dy - 140, // Y position adjusted upwards.
          details.globalPosition.dx, // Right boundary.
          details.globalPosition.dy, // Bottom boundary.
        );

        // Show the popup menu at the specified position.
        showMenu(
          color: MyColors
              .nonSelectedItemColor, // Custom color for the menu background.
          context: context,
          position: position, // Set the menu position based on the tap.
          items: widget.items
              .asMap()
              .entries
              .map(
                // Convert each item into a PopupMenuItem, with the index as the value.
                (entry) => PopupMenuItem<int>(
                  value: entry.key, // The value is the index of the item.
                  child:
                      Text(entry.value), // Display the text of the menu item.
                ),
              )
              .toList(),
        ).then((selectedIndex) {
          // When an item is selected, call the corresponding function from onItemTap.
          if (selectedIndex != null &&
              selectedIndex < widget.onItemTap.length) {
            widget.onItemTap[
                selectedIndex](); // Invoke the function for the selected item.
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          // The GestureDetector listens for tap events and provides tap details.
          onTapDown: (TapDownDetails details) =>
              _showMenu(context, details), // Handle tap to show the menu.
          child: IconButton(
            icon: widget.icon, // Display the provided icon.
            onPressed:
                null, // onPressed is not needed as tap is handled by GestureDetector.
          ),
        ),
        // If _isLoading is true, show a CircularProgressIndicator.
        if (_isLoading)
          Positioned(
            child: buildProgressIndicator(), // Loading animation.
          ),
      ],
    );
  }
}
