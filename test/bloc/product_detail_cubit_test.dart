import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:store/core/error/failures.dart';
import 'package:store/features/product_detail/data/models/product_detail_model.dart';
import 'package:store/features/product_detail/domain/usecases/get_product_detail_usecase.dart';
import 'package:store/features/product_detail/presentation/bloc/product_detail_cubit.dart';
import 'package:store/features/product_detail/presentation/bloc/product_detail_state.dart';

import 'product_detail_cubit_test.mocks.dart';

@GenerateMocks([GetProductDetailUseCase])
void main() {
  late ProductDetailCubit cubit;
  late MockGetProductDetailUseCase mockGetProductDetailUseCase;

  setUp(() {
    mockGetProductDetailUseCase = MockGetProductDetailUseCase();
    cubit = ProductDetailCubit(getProductDetailUseCase: mockGetProductDetailUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state should be ProductDetailInitialState', () {
    // assert
    expect(cubit.state, isA<ProductDetailInitialState>());
  });

  group('getProductDetail', () {
    final tProductId = '1';
    final tProductDetailModel = ProductDetailModel(
      id: 1,
      categoryId: 1,
      categoryName: 'Test Category',
      sku: 'SKU123',
      name: 'Test Product',
      description: 'Test Description',
      weight: 100,
      width: 10,
      length: 20,
      height: 5,
      image: 'test_image.jpg',
      harga: 10000,
    );

    test('should emit [Loading, Loaded] when data is gotten successfully', () async {
      // arrange
      when(mockGetProductDetailUseCase(tProductId)).thenAnswer((_) async => Right(tProductDetailModel));

      // assert later
      final expected = [ProductDetailLoadingState(), ProductDetailLoadedState(product: tProductDetailModel)];
      expectLater(cubit.stream, emitsInOrder(expected));

      // act
      await cubit.getProductDetail(tProductId);
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      // arrange
      // Ensure Flutter binding is initialized before invoking cubit methods
      TestWidgetsFlutterBinding.ensureInitialized();

      final failure = ServerFailure(message: 'Server error');
      when(mockGetProductDetailUseCase(tProductId)).thenAnswer((_) async => Left(failure));

      // assert later
      final expected = [ProductDetailLoadingState(), ProductDetailErrorState(message: failure.message)];
      expectLater(cubit.stream, emitsInOrder(expected));

      // act
      await cubit.getProductDetail(tProductId);
    });
  });
}
