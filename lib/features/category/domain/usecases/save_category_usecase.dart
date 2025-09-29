import 'package:store/core/error/failures.dart';
import 'package:store/features/category/data/models/category_model.dart';
import 'package:store/features/category/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class SaveCategoryUseCase {
  final CategoryRepository categoryRepository;

  SaveCategoryUseCase({required this.categoryRepository});

  Future<Either<Failure, void>> call({
    required CategoryModel categoryModel,
  }) async {
    return await categoryRepository.saveCategory(categoryModel: categoryModel);
  }
}
