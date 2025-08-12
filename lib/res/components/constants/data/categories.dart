import 'package:e_commerce/model/categoriesModel/categories_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<CategoriesModel> groceryCategories = [
  CategoriesModel(code: 1, icon: FontAwesomeIcons.apple, title: "Fruits"),
  CategoriesModel(code: 2, icon: FontAwesomeIcons.carrot, title: "Vegetables"),
  CategoriesModel(
    code: 3,
    icon: FontAwesomeIcons.wineBottle,
    title: "Beverages",
  ),
  CategoriesModel(code: 4, icon: FontAwesomeIcons.breadSlice, title: "Bakery"),
  CategoriesModel(code: 5, icon: FontAwesomeIcons.cheese, title: "Dairy"),
  CategoriesModel(code: 6, icon: FontAwesomeIcons.drumstickBite, title: "Meat"),
  CategoriesModel(code: 7, icon: FontAwesomeIcons.fish, title: "Seafood"),
  CategoriesModel(code: 8, icon: FontAwesomeIcons.cookieBite, title: "Snacks"),
  CategoriesModel(code: 9, icon: FontAwesomeIcons.box, title: "Grains"),
  CategoriesModel(code: 10, icon: FontAwesomeIcons.soap, title: "Household"),
];
