import 'package:store/core/error/failures.dart';
import 'package:store/features/category/data/models/category_model.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryModel>>> getCategoryList();
  Future<Either<Failure, void>> saveCategory({
    required CategoryModel categoryModel,
  });
  Future<Either<Failure, void>> deleteCategory({required int index});
}
