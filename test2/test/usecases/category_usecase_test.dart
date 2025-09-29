import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:store/core/error/failures.dart';
import 'package:store/features/category/data/models/category_model.dart';
import 'package:store/features/category/domain/repositories/category_repository.dart';
import 'package:store/features/category/domain/usecases/delete_category_usecase.dart';
import 'package:store/features/category/domain/usecases/get_category_list_usecase.dart';
import 'package:store/features/category/domain/usecases/save_category_usecase.dart';

@GenerateMocks([CategoryRepository])
import 'category_usecase_test.mocks.dart';

void main() {
  late MockCategoryRepository mockCategoryRepository;
  late GetCategoryListUseCase getCategoryListUseCase;
  late SaveCategoryUseCase saveCategoryUseCase;
  late DeleteCategoryUseCase deleteCategoryUseCase;

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    getCategoryListUseCase = GetCategoryListUseCase(
      categoryRepository: mockCategoryRepository,
    );
    saveCategoryUseCase = SaveCategoryUseCase(
      categoryRepository: mockCategoryRepository,
    );
    deleteCategoryUseCase = DeleteCategoryUseCase(
      categoryRepository: mockCategoryRepository,
    );
  });

  group('GetCategoryListUseCase', () {
    final categoryList = [
      CategoryModel(id: 1, categoryName: 'Category 1'),
      CategoryModel(id: 2, categoryName: 'Category 2'),
    ];

    test(
      'should get category list from the repository',
      () async {
        // arrange
        when(mockCategoryRepository.getCategoryList())
            .thenAnswer((_) async => Right(categoryList));

        // act
        final result = await getCategoryListUseCase();

        // assert
        expect(result, Right(categoryList));
        verify(mockCategoryRepository.getCategoryList());
        verifyNoMoreInteractions(mockCategoryRepository);
      },
    );

    test(
      'should return failure when repository fails',
      () async {
        // arrange
        final failure = ServerFailure(message: 'Server error');
        when(mockCategoryRepository.getCategoryList())
            .thenAnswer((_) async => Left(failure));

        // act
        final result = await getCategoryListUseCase();

        // assert
        expect(result, Left(failure));
        verify(mockCategoryRepository.getCategoryList());
        verifyNoMoreInteractions(mockCategoryRepository);
      },
    );
  });

  group('SaveCategoryUseCase', () {
    final categoryModel = CategoryModel(
      categoryName: 'New Category',
    );

    test(
      'should save category to the repository',
      () async {
        // arrange
        when(mockCategoryRepository.saveCategory(categoryModel: categoryModel))
            .thenAnswer((_) async => const Right(null));

        // act
        final result = await saveCategoryUseCase(categoryModel: categoryModel);

        // assert
        expect(result, const Right(null));
        verify(mockCategoryRepository.saveCategory(categoryModel: categoryModel));
        verifyNoMoreInteractions(mockCategoryRepository);
      },
    );

    test(
      'should return failure when repository fails',
      () async {
        // arrange
        final failure = ServerFailure(message: 'Server error');
        when(mockCategoryRepository.saveCategory(categoryModel: categoryModel))
            .thenAnswer((_) async => Left(failure));

        // act
        final result = await saveCategoryUseCase(categoryModel: categoryModel);

        // assert
        expect(result, Left(failure));
        verify(mockCategoryRepository.saveCategory(categoryModel: categoryModel));
        verifyNoMoreInteractions(mockCategoryRepository);
      },
    );
  });

  group('DeleteCategoryUseCase', () {
    const index = 1;

    test(
      'should delete category from the repository',
      () async {
        // arrange
        when(mockCategoryRepository.deleteCategory(index: index))
            .thenAnswer((_) async => const Right(null));

        // act
        final result = await deleteCategoryUseCase(index: index);

        // assert
        expect(result, const Right(null));
        verify(mockCategoryRepository.deleteCategory(index: index));
        verifyNoMoreInteractions(mockCategoryRepository);
      },
    );

    test(
      'should return failure when repository fails',
      () async {
        // arrange
        final failure = ServerFailure(message: 'Server error');
        when(mockCategoryRepository.deleteCategory(index: index))
            .thenAnswer((_) async => Left(failure));

        // act
        final result = await deleteCategoryUseCase(index: index);

        // assert
        expect(result, Left(failure));
        verify(mockCategoryRepository.deleteCategory(index: index));
        verifyNoMoreInteractions(mockCategoryRepository);
      },
    );
  });
}