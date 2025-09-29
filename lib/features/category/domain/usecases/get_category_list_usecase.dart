import 'package:store/core/error/failures.dart';
import 'package:store/features/category/data/models/category_model.dart';
import 'package:store/features/category/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoryListUseCase {
  final CategoryRepository categoryRepository;

  GetCategoryListUseCase({required this.categoryRepository});

  Future<Either<Failure, List<CategoryModel>>> call() async {
    return await categoryRepository.getCategoryList();
  }
}
