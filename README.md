# BookWallet

## Overview

BookWallet is an app designed to help book enthusiasts manage their reading materials, track reviews, and connect with other readers. Below, we'll break down the project structure and explain each section.

## Project Structure

### `lib` Folder

#### Buttons

- `custom_button.dart`: A green, round button with a white outline.

- `selection_bar.dart`: A button bar where you can copy code (without editing existing code) from `books_screen_body.dart` and customize names and screens.

#### `cards` Folder
-  This folder contains display cards
- `review.dart`: A card for displaying book reviews.

#### `screens` Folder

The `screens` folder contains different pages of the app:

- `main_screen`

  - `books_screen`: Files related to the books page.
    - `books_screen_body.dart`: contains books screen body with button panel and book window
    - `book_list_view.dart`: contains the scrolling view for books

  - `groups_screen`: Files related to the groups page.
    - `groups_screen_body.dart`: code for group body

  - `home_screen`: Files related to the home page.
    - `home_screen_body.dart`: scrollable home screen body.

  - `profile_screen`: Files related to the user profile page.

- `main_screen_frame.dart`: Creates the main screen frame with a bottom navigation bar. It dynamically changes the top app bar based on the active page.

- `top_panel.dart`: Implements the top app bar, displaying the current page name.

### `colors.dart`

- Defines custom colors for use within the `lib` files. To use these colors, refer to them as `MyColors.colorName`.

### `main.dart`

- The main entry point for the app.

## `diagrams` Folder

The `diagrams` folder contains various diagrams, including class diagrams, entity-relationship diagrams (EER), and relational diagrams. Feel free to upload any new diagrams to this folder.

## `images` Folder

The `images` folder holds all the necessary images. Make sure to rename new images appropriately if you add any.
