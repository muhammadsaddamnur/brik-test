import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:store/core/error/failures.dart';
import 'package:store/features/category/data/models/category_model.dart';
import 'package:store/features/category/domain/usecases/delete_category_usecase.dart';
import 'package:store/features/category/domain/usecases/get_category_list_usecase.dart';
import 'package:store/features/category/domain/usecases/save_category_usecase.dart';
import 'package:store/features/category/presentation/bloc/category_cubit.dart';
import 'package:store/features/category/presentation/bloc/category_state.dart';

@GenerateMocks([GetCategoryListUseCase, SaveCategoryUseCase, DeleteCategoryUseCase])
import 'category_cubit_test.mocks.dart';

void main() {
  late CategoryCubit categoryCubit;
  late MockGetCategoryListUseCase mockGetCategoryListUseCase;
  late MockSaveCategoryUseCase mockSaveCategoryUseCase;
  late MockDeleteCategoryUseCase mockDeleteCategoryUseCase;

  setUp(() {
    mockGetCategoryListUseCase = MockGetCategoryListUseCase();
    mockSaveCategoryUseCase = MockSaveCategoryUseCase();
    mockDeleteCategoryUseCase = MockDeleteCategoryUseCase();
    categoryCubit = CategoryCubit(getCategoryListUseCase: mockGetCategoryListUseCase, saveCategoryUseCase: mockSaveCategoryUseCase, deleteCategoryUseCase: mockDeleteCategoryUseCase);
  });

  tearDown(() {
    categoryCubit.close();
  });

  test('initial state should be CategoryInitialState', () {
    expect(categoryCubit.state, isA<CategoryInitialState>());
  });

  group('getCategoryList', () {
    final categoryList = [CategoryModel(categoryName: 'Category 1'), CategoryModel(categoryName: 'Category 2')];

    test('should emit [CategoryLoadingState, CategoryLoadedState] when data is gotten successfully', () async {
      // arrange
      when(mockGetCategoryListUseCase()).thenAnswer((_) async => Right(categoryList));

      // assert later
      final expected = [isA<CategoryLoadingState>(), isA<CategoryLoadedState>()];
      expectLater(categoryCubit.stream, emitsInOrder(expected));

      // act
      await categoryCubit.getCategoryList();
    });

    test('should emit [CategoryLoadingState, CategoryErrorState] when getting data fails', () async {
      // arrange
      final failure = ServerFailure(message: 'Server error');
      when(mockGetCategoryListUseCase()).thenAnswer((_) async => Left(failure));

      // assert later
      final expected = [isA<CategoryLoadingState>(), isA<CategoryErrorState>()];
      expectLater(categoryCubit.stream, emitsInOrder(expected));

      // act
      await categoryCubit.getCategoryList();
    });
  });

  group('saveCategory', () {
    final category = CategoryModel(categoryName: 'New Category');

    test('should call saveCategoryUseCase', () async {
      // arrange
      when(mockSaveCategoryUseCase(categoryModel: any)).thenAnswer((_) async => const Right(null));

      // act
      await categoryCubit.saveCategory(categoryModel: category);

      // assert
      verify(mockSaveCategoryUseCase(categoryModel: category));
    });
  });

  group('deleteCategory', () {
    const index = 1;

    test('should call deleteCategoryUseCase', () async {
      // arrange
      when(mockDeleteCategoryUseCase(index: index)).thenAnswer((_) async => const Right(null));

      // act
      await categoryCubit.deleteCategory(index: index);

      // assert
      verify(mockDeleteCategoryUseCase(index: index));
    });
  });
}
