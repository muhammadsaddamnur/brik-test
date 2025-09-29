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
import 'home_cubit_additional_test.mocks.dart';

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

  test('initial state should be HomeState', () {
    expect(homeCubit.state, isA<HomeState>());
  });

  group('getProductList', () {
    test('should emit [HomeLoadingState, HomeProductsLoadedState] when data is gotten successfully', () async {
      // arrange
      when(mockGetProductListUseCase(page: anyNamed('page'))).thenAnswer((_) async => Right(ProductModel(products: [Product(id: 1, name: 'Product 1')])));

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

    test('should emit HomeProductsLoadedState with correct productList', () async {
      // arrange
      when(mockGetProductListUseCase(page: anyNamed('page'))).thenAnswer((_) async => Right(ProductModel(products: [Product(id: 1, name: 'Product 1')])));

      // act
      await homeCubit.getProductList();

      // assert
      expect(homeCubit.state, isA<HomeState>());
      final loadedState = homeCubit.state;
      expect(loadedState.productModel, equals(ProductModel(products: [Product(id: 1, name: 'Product 1')])));
    });
  });
}
