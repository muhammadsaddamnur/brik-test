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

import 'home_cubit_test.mocks.dart';

@GenerateMocks([GetProductListUseCase, SaveProductUseCase, DeleteProductUseCase, UpdateProductUseCase])
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

  test('initial state should be correct', () {
    expect(homeCubit.state, const HomeState());
  });

  group('getProductList', () {
    final tProductModel = ProductModel(
      products: [
        Product(id: 1, name: 'Product 1', harga: 100),
        Product(id: 2, name: 'Product 2', harga: 200),
      ],
    );

    test('should emit loading and then loaded state when data is gotten successfully', () async {
      // arrange
      when(mockGetProductListUseCase(page: 1)).thenAnswer((_) async => Right(tProductModel));

      // act
      await homeCubit.getProductList();

      // assert
      verify(mockGetProductListUseCase(page: 1));
      expect(homeCubit.state.isLoading, false);
      expect(homeCubit.state.productModel?.products?.length, 2);
    });

    test('should emit error state when getting data fails', () async {
      // arrange
      final failure = ServerFailure(message: 'Server error');
      when(mockGetProductListUseCase(page: 1)).thenAnswer((_) async => Left(failure));

      // act
      await homeCubit.getProductList();

      // assert
      verify(mockGetProductListUseCase(page: 1));
      expect(homeCubit.state.error, 'Server error');
    });
  });
}
