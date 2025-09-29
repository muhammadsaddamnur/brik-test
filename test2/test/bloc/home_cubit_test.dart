import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:store/core/error/failures.dart';
import 'package:store/features/home/data/models/product_model.dart';
import 'package:store/features/home/domain/usecases/delete_product_usecase.dart';
import 'package:store/features/home/domain/usecases/get_product_list_usecase.dart';
import 'package:store/features/home/domain/usecases/save_product_usecase.dart';
import 'package:store/features/home/domain/usecases/update_product_usecase.dart';
import 'package:store/features/home/presentation/bloc/home_cubit.dart';
import 'package:store/features/home/presentation/bloc/home_state.dart';

@GenerateMocks([GetProductListUseCase, SaveProductUseCase, DeleteProductUseCase, UpdateProductUseCase])
import 'home_cubit_test.mocks.dart';

void main() {
  late HomeCubit homeCubit;
  late MockGetProductListUseCase mockGetProductListUseCase;
  late MockSaveProductUseCase mockSaveProductUseCase;
  late MockDeleteProductUseCase mockDeleteProductUseCase;
  late MockUpdateProductUseCase mockUpdateProductUseCase;

  setUp(() {
    mockGetProductListUseCase = MockGetProductListUseCase();
    mockSaveProductUseCase = MockSaveProductUseCase();
    mockDeleteProductUseCase = MockDeleteProductUseCase();
    mockUpdateProductUseCase = MockUpdateProductUseCase();
    homeCubit = HomeCubit(
      getProductListUseCase: mockGetProductListUseCase,
      saveProductUseCase: mockSaveProductUseCase,
      deleteProductUseCase: mockDeleteProductUseCase,
      updateProductUseCase: mockUpdateProductUseCase,
    );
  });

  tearDown(() {
    homeCubit.close();
  });

  test('initial state should be HomeInitialState', () {
    // assert
    expect(homeCubit.state, isA<HomeState>());
  });

  group('getProductList', () {
    final productModel = ProductModel(products: [Product(id: 1, name: 'Product 1')]);

    test('should emit [HomeLoadingState, HomeLoadedState] when data is gotten successfully', () async {
      // arrange
      when(mockGetProductListUseCase(page: anyNamed('page'))).thenAnswer((_) async => Right(productModel));

      // assert later
      final expected = [isA<HomeState>(), isA<HomeState>()];
      expectLater(homeCubit.stream, emitsInOrder(expected));

      // act
      await homeCubit.getProductList();
    });

    test('should emit [HomeLoadingState, HomeErrorState] when getting data fails', () async {
      // arrange
      final failure = ServerFailure(message: 'Server error');
      when(mockGetProductListUseCase(page: anyNamed('page'))).thenAnswer((_) async => Left(failure));

      // assert later
      final expected = [isA<HomeState>(), isA<HomeState>()];
      expectLater(homeCubit.stream, emitsInOrder(expected));

      // act
      await homeCubit.getProductList();
    });

    test('should emit HomeLoadedState with correct generationModel', () async {
      // arrange
      when(mockGetProductListUseCase(page: anyNamed('page'))).thenAnswer((_) async => Right(productModel));

      // act
      await homeCubit.getProductList();

      // assert
      expect(homeCubit.state, isA<HomeState>());
      final loadedState = homeCubit.state;
      expect(loadedState.productModel, equals(productModel));
    });

    test('should emit HomeErrorState with correct error message', () async {
      // arrange
      final failure = ServerFailure(message: 'Server error');
      when(mockGetProductListUseCase(page: anyNamed('page'))).thenAnswer((_) async => Left(failure));

      // act
      await homeCubit.getProductList();

      // assert
      expect(homeCubit.state, isA<HomeState>());
      final errorState = homeCubit.state;
      expect(errorState.error, equals(failure.message));
    });
  });
}
