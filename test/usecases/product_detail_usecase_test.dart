import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:store/core/error/failures.dart';
import 'package:store/features/product_detail/data/models/product_detail_model.dart';
import 'package:store/features/product_detail/domain/repositories/product_detail_repository.dart';
import 'package:store/features/product_detail/domain/usecases/get_product_detail_usecase.dart';

import 'product_detail_usecase_test.mocks.dart';

@GenerateMocks([ProductDetailRepository])
void main() {
  late GetProductDetailUseCase usecase;
  late MockProductDetailRepository mockRepository;

  setUp(() {
    mockRepository = MockProductDetailRepository();
    usecase = GetProductDetailUseCase(repository: mockRepository);
  });

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

  test('should get product detail from the repository', () async {
    // arrange
    when(mockRepository.getProductDetail(tProductId))
        .thenAnswer((_) async => Right(tProductDetailModel));

    // act
    final result = await usecase(tProductId);

    // assert
    expect(result, Right(tProductDetailModel));
    verify(mockRepository.getProductDetail(tProductId));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return server failure when repository returns failure', () async {
    // arrange
    final failure = ServerFailure(message: 'Server error');
    when(mockRepository.getProductDetail(tProductId))
        .thenAnswer((_) async => Left(failure));

    // act
    final result = await usecase(tProductId);

    // assert
    expect(result, Left(failure));
    verify(mockRepository.getProductDetail(tProductId));
    verifyNoMoreInteractions(mockRepository);
  });
}