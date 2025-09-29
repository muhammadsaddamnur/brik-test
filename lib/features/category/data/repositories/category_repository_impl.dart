import 'package:store/features/category/data/datasources/category_local_data_source.dart';
import 'package:store/features/category/data/models/category_model.dart';
import 'package:store/features/category/domain/repositories/category_repository.dart';
import 'package:store/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource localDataSource;

  CategoryRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategoryList() async {
    try {
      /// Get category list from remote data source
      final res = await localDataSource.getCategoryList;

      return Right(res);
    } on Exception catch (e) {
      return Left(DBFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveCategory({
    required CategoryModel categoryModel,
  }) async {
    try {
      /// Save category list to local data source
      await localDataSource.saveCategory(categoryModel: categoryModel);

      return Right(null);
    } on Exception catch (e) {
      return Left(DBFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory({required int index}) async {
    try {
      /// Delete category list to local data source
      await localDataSource.deleteCategory(index: index);

      return Right(null);
    } on Exception catch (e) {
      return Left(DBFailure(message: e.toString()));
    }
  }
}
