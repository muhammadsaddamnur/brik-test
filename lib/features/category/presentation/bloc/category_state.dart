import 'package:equatable/equatable.dart';
import 'package:store/features/category/data/models/category_model.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitialState extends CategoryState {
  const CategoryInitialState();
}

class CategoryLoadingState extends CategoryState {
  const CategoryLoadingState();
}

class CategoryLoadedState extends CategoryState {
  const CategoryLoadedState({required this.categoryList});

  final List<CategoryModel> categoryList;

  @override
  List<Object?> get props => [categoryList];
}

class CategoryErrorState extends CategoryState {
  const CategoryErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
