import 'package:flutter/material.dart';

// Global function variable
Function(Widget)? changeHomeScreenGlobal;
Function(Widget)? changeGroupsScreenGlobal;
Function(Widget)? changeBooksScreenGlobal;
Function(Widget)? changeProfileScreenGlobal;

// Function to set the global function
void setGlobalFunction(Function(Widget) func, int index) {
  switch (index) {
    case 1:
      changeHomeScreenGlobal = func;
    case 2:
      changeGroupsScreenGlobal = func;
    case 3:
      changeBooksScreenGlobal = func;
    case 4:
      changeProfileScreenGlobal = func;
  }
}
