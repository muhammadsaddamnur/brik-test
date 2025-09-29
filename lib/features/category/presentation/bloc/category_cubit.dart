import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/features/category/data/models/category_model.dart';
import 'package:store/features/category/domain/usecases/delete_category_usecase.dart';
import 'package:store/features/category/domain/usecases/get_category_list_usecase.dart';
import 'package:store/features/category/domain/usecases/save_category_usecase.dart';
import 'package:store/features/category/presentation/bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final SaveCategoryUseCase saveCategoryUseCase;
  final GetCategoryListUseCase getCategoryListUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  CategoryCubit({required this.saveCategoryUseCase, required this.getCategoryListUseCase, required this.deleteCategoryUseCase}) : super(const CategoryInitialState());

  /// Save category
  Future<void> saveCategory({required CategoryModel categoryModel}) async {
    emit(const CategoryLoadingState());
    final result = await saveCategoryUseCase(categoryModel: categoryModel);
    result.fold((failure) => Fluttertoast.showToast(msg: failure.message), (success) => Fluttertoast.showToast(msg: 'Successfully Saved'));

    getCategoryList();
  }

  /// Delete category
  Future<void> deleteCategory({required int index}) async {
    emit(const CategoryLoadingState());
    final result = await deleteCategoryUseCase(index: index);
    result.fold((failure) => Fluttertoast.showToast(msg: failure.message), (success) => Fluttertoast.showToast(msg: 'Successfully Deleted'));

    getCategoryList();
  }

  /// Get category list
  Future<void> getCategoryList() async {
    emit(const CategoryLoadingState());
    final result = await getCategoryListUseCase();
    result.fold((failure) => Fluttertoast.showToast(msg: failure.message), (success) => emit(CategoryLoadedState(categoryList: success)));
  }
}
