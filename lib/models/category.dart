import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  // String iconPath;
  Color boxColor;
  CategoryModel({
    required this.name,
    // required this.iconPath,
    required this.boxColor,
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];
    categories.add(CategoryModel(
        name: 'General',
        // iconPath: 'icons/pancake.svg',
        boxColor: Color.fromARGB(255, 161, 199, 224)));
    categories.add(CategoryModel(
        name: 'Science',
        // iconPath: 'icons/pancake.svg',
        boxColor: Color.fromARGB(255, 161, 199, 224)));
    categories.add(CategoryModel(
        name: 'Technology',
        // iconPath: 'icons/salad.svg',
        boxColor: Color.fromARGB(255, 127, 214, 134)));
    categories.add(CategoryModel(
        name: 'Sports',
        // iconPath: 'icons/cake.svg',
        boxColor: Color.fromARGB(255, 224, 162, 206)));
    categories.add(CategoryModel(
        name: 'Health',
        // iconPath: 'icons/smoothie.svg',
        boxColor: Color.fromARGB(255, 212, 236, 105)));
    categories.add(CategoryModel(
        name: 'Business',
        // iconPath: 'icons/pancake.svg',
        boxColor: Color.fromARGB(255, 161, 199, 224)));
    categories.add(CategoryModel(
        name: 'Entertainment',
        // iconPath: 'icons/pancake.svg',
        boxColor: Color.fromARGB(255, 161, 199, 224)));

    return categories;
  }
}
