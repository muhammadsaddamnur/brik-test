import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:store/core/error/failures.dart';
import 'package:store/features/category/data/models/category_model.dart';
import 'package:store/features/category/domain/repositories/category_repository.dart';
import 'package:store/features/category/domain/usecases/get_category_list_usecase.dart';
import 'package:store/features/category/domain/usecases/save_category_usecase.dart';
import 'package:store/features/category/domain/usecases/delete_category_usecase.dart';

import 'category_usecase_test.mocks.dart';

@GenerateMocks([CategoryRepository])
void main() {
  late GetCategoryListUseCase getCategoryListUseCase;
  late SaveCategoryUseCase saveCategoryUseCase;
  late DeleteCategoryUseCase deleteCategoryUseCase;
  late MockCategoryRepository mockRepository;

  setUp(() {
    mockRepository = MockCategoryRepository();
    getCategoryListUseCase = GetCategoryListUseCase(categoryRepository: mockRepository);
    saveCategoryUseCase = SaveCategoryUseCase(categoryRepository: mockRepository);
    deleteCategoryUseCase = DeleteCategoryUseCase(categoryRepository: mockRepository);
  });

  group('GetCategoryListUseCase', () {
    final tCategoryList = [CategoryModel(id: 1, categoryName: 'Category 1'), CategoryModel(id: 2, categoryName: 'Category 2')];

    test('should get category list from the repository', () async {
      // arrange
      when(mockRepository.getCategoryList()).thenAnswer((_) async => Right(tCategoryList));

      // act
      final result = await getCategoryListUseCase();

      // assert
      expect(result, Right(tCategoryList));
      verify(mockRepository.getCategoryList());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository returns failure', () async {
      // arrange
      final failure = ServerFailure(message: 'Server error');
      when(mockRepository.getCategoryList()).thenAnswer((_) async => Left(failure));

      // act
      final result = await getCategoryListUseCase();

      // assert
      expect(result, Left(failure));
      verify(mockRepository.getCategoryList());
      verifyNoMoreInteractions(mockRepository);
    });
  });

  group('SaveCategoryUseCase', () {
    final tCategoryModel = CategoryModel(id: 1, categoryName: 'Test Category');

    test('should save category to the repository', () async {
      // arrange
      when(mockRepository.saveCategory(categoryModel: tCategoryModel)).thenAnswer((_) async => const Right(true));

      // act
      final result = await saveCategoryUseCase(categoryModel: tCategoryModel);

      // assert
      expect(result, const Right(true));
      verify(mockRepository.saveCategory(categoryModel: tCategoryModel));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository returns failure', () async {
      // arrange
      final failure = ServerFailure(message: 'Server error');
      when(mockRepository.saveCategory(categoryModel: tCategoryModel)).thenAnswer((_) async => Left(failure));

      // act
      final result = await saveCategoryUseCase(categoryModel: tCategoryModel);

      // assert
      expect(result, Left(failure));
      verify(mockRepository.saveCategory(categoryModel: tCategoryModel));
      verifyNoMoreInteractions(mockRepository);
    });
  });

  group('DeleteCategoryUseCase', () {
    final tIndex = 1;

    test('should delete category from the repository', () async {
      // arrange
      when(mockRepository.deleteCategory(index: tIndex)).thenAnswer((_) async => const Right(true));

      // act
      final result = await deleteCategoryUseCase(index: tIndex);

      // assert
      expect(result, const Right(true));
      verify(mockRepository.deleteCategory(index: tIndex));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository returns failure', () async {
      // arrange
      final failure = ServerFailure(message: 'Server error');
      when(mockRepository.deleteCategory(index: tIndex)).thenAnswer((_) async => Left(failure));

      // act
      final result = await deleteCategoryUseCase(index: tIndex);

      // assert
      expect(result, Left(failure));
      verify(mockRepository.deleteCategory(index: tIndex));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
