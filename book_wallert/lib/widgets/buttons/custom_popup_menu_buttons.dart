import 'package:book_wallert/colors.dart';  // Importing a custom color palette.
import 'package:flutter/material.dart';     // Importing Flutter's material library for UI components.

/// A custom popup menu widget that displays a list of items.
/// 
/// This widget takes a list of strings (`items`) to display in the menu and a
/// list of callback functions (`onItemTap`) that are invoked when an item is selected.
/// The menu is triggered by an `Icon`, and when an item is tapped, the respective
/// function in `onItemTap` is called.
///
/// Example usage:
/// ```dart
/// CustomPopupMenuButtons(
///   items: ['Option 1', 'Option 2', 'Option 3'],
///   onItemTap: [() => print('Option 1 selected'), () => print('Option 2 selected')],
///   icon: Icon(Icons.more_vert),
/// );
/// ```
class CustomPopupMenuButtons extends StatelessWidget {
  /// A list of string items to display in the popup menu.
  final List<String> items;

  /// A list of functions to call when the corresponding item is selected.
  /// The function at index `i` will be called when the `i-th` item is selected.
  final List<Function> onItemTap;

  /// The icon that triggers the popup menu when tapped.
  final Icon icon;

  /// Creates a [CustomPopupMenuButtons] widget.
  /// 
  /// The [items], [onItemTap], and [icon] arguments must be provided.
  const CustomPopupMenuButtons({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // The PopupMenuButton widget is used to create the popup menu.
    return PopupMenuButton<String>(
      elevation: 10,  // Sets the elevation of the popup menu to give it depth.
      shadowColor: MyColors.bgColor,  // Custom shadow color for the popup menu.
      color: MyColors.nonSelectedItemColor,  // Custom background color for non-selected menu items.
      icon: icon,  // The icon that triggers the popup when tapped.
      
      // This function is called when an item in the menu is selected.
      onSelected: (String result) {
        int index = items.indexOf(result);  // Get the index of the selected item.
        
        // Ensure the selected index is valid and call the corresponding function.
        if (index >= 0 && index < onItemTap.length) {
          onItemTap[index]();  // Call the function at the selected index.
        }
      },
      
      // This function builds the list of items for the popup menu.
      itemBuilder: (BuildContext context) => items
          .map(
            // Map each string in the items list to a PopupMenuItem widget.
            (item) => PopupMenuItem<String>(
              value: item,  // The value returned when this item is selected.
              child: Text(item),  // Display the text of the item.
            ),
          )
          .toList(),
    );
  }
}
