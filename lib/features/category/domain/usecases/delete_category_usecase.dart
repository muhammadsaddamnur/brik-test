import 'package:store/core/error/failures.dart';
import 'package:store/features/category/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteCategoryUseCase {
  final CategoryRepository categoryRepository;

  DeleteCategoryUseCase({required this.categoryRepository});

  Future<Either<Failure, void>> call({required int index}) async {
    return await categoryRepository.deleteCategory(index: index);
  }
}
