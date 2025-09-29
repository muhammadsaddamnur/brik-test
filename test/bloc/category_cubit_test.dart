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

import 'category_cubit_test.mocks.dart';

@GenerateMocks([GetCategoryListUseCase, SaveCategoryUseCase, DeleteCategoryUseCase])
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

  test('initial state should be CategoryInitialState', () {
    expect(categoryCubit.state, const CategoryInitialState());
  });

  group('getCategoryList', () {
    final tCategoryList = [CategoryModel(id: 1, categoryName: 'Category 1'), CategoryModel(id: 2, categoryName: 'Category 2')];

    test('should emit [CategoryLoadingState, CategoryLoadedState] when data is gotten successfully', () async {
      // arrange
      when(mockGetCategoryListUseCase()).thenAnswer((_) async => Right(tCategoryList));

      // assert later
      final expected = [const CategoryLoadingState(), CategoryLoadedState(categoryList: tCategoryList)];
      expectLater(categoryCubit.stream, emitsInOrder(expected));

      // act
      await categoryCubit.getCategoryList();
    });

    test('should emit [CategoryLoadingState] when getting data fails', () async {
      // arrange
      // Ensure Flutter binding is initialized before invoking cubit methods
      TestWidgetsFlutterBinding.ensureInitialized();

      when(mockGetCategoryListUseCase()).thenAnswer((_) async => Left(ServerFailure(message: 'Server error')));

      // assert later
      final expected = [const CategoryLoadingState()];
      expectLater(categoryCubit.stream, emitsInOrder(expected));

      // act
      await categoryCubit.getCategoryList();
    });
  });

  group('saveCategory', () {
    final tCategoryModel = CategoryModel(id: 1, categoryName: 'Test Category');

    test('should call saveCategoryUseCase and then getCategoryList', () async {
      // arrange
      // Ensure Flutter binding is initialized before invoking cubit methods
      TestWidgetsFlutterBinding.ensureInitialized();

      when(mockSaveCategoryUseCase(categoryModel: tCategoryModel)).thenAnswer((_) async => const Right(true));
      when(mockGetCategoryListUseCase()).thenAnswer((_) async => Right([tCategoryModel]));

      // act
      await categoryCubit.saveCategory(categoryModel: tCategoryModel);

      // assert
      verify(mockSaveCategoryUseCase(categoryModel: tCategoryModel));
      verify(mockGetCategoryListUseCase());
    });
  });

  group('deleteCategory', () {
    final tIndex = 1;
    final tCategoryModel = CategoryModel(id: 1, categoryName: 'Test Category');

    test('should call deleteCategoryUseCase and then getCategoryList', () async {
      TestWidgetsFlutterBinding.ensureInitialized();

      // arrange
      when(mockDeleteCategoryUseCase(index: tIndex)).thenAnswer((_) async => const Right(true));
      when(mockGetCategoryListUseCase()).thenAnswer((_) async => Right([tCategoryModel]));

      // act
      await categoryCubit.deleteCategory(index: tIndex);

      // assert
      verify(mockDeleteCategoryUseCase(index: tIndex));
      verify(mockGetCategoryListUseCase());
    });
  });
}
