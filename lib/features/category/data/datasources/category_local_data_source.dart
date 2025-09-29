import 'dart:convert';

import 'package:store/features/category/data/models/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CategoryLocalDataSource {
  /// Save category to the local storage
  Future<void> saveCategory({required CategoryModel categoryModel});

  /// Delete category from the local storage
  Future<void> deleteCategory({required int index});

  /// Get category list from the local storage
  Future<List<CategoryModel>> get getCategoryList;
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  @override
  Future<void> saveCategory({required CategoryModel categoryModel}) async {
    final prefs = await SharedPreferences.getInstance();

    var prevData = prefs.getStringList('category_list') ?? [];
    prevData.add(jsonEncode(categoryModel.toJson()));

    await prefs.setStringList('category_list', prevData);
  }

  @override
  Future<void> deleteCategory({required int index}) async {
    final prefs = await SharedPreferences.getInstance();

    var prevData = prefs.getStringList('category_list') ?? [];
    prevData.removeAt(index);

    await prefs.setStringList('category_list', prevData);
  }

  Future<List<CategoryModel>> get getCategoryList async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('category_list');

    if (data != null) {
      return data.map((e) => CategoryModel.fromJson(jsonDecode(e))).toList();
    }

    return [];
  }
}
