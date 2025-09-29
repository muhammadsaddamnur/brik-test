import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:store/core/error/failures.dart';
import 'package:store/features/home/data/models/product_model.dart';
import 'package:store/features/home/domain/repositories/home_repository.dart';
import 'package:store/features/home/domain/usecases/get_product_list_usecase.dart';

import 'home_usecase_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late GetProductListUseCase getProductListUseCase;
  late MockHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeRepository();
    getProductListUseCase = GetProductListUseCase(homeRepository: mockRepository);
  });

  group('GetProductListUseCase', () {
    final tPage = 1;
    final tProductModel = ProductModel(
      products: [
        Product(id: 1, name: 'Product 1', harga: 100),
        Product(id: 2, name: 'Product 2', harga: 200),
      ],
    );

    test('should get product list from the repository', () async {
      // arrange
      when(mockRepository.getProductList(page: tPage)).thenAnswer((_) async => Right(tProductModel));

      // act
      final result = await getProductListUseCase(page: tPage);

      // assert
      expect(result, Right(tProductModel));
      verify(mockRepository.getProductList(page: tPage));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository returns failure', () async {
      // arrange
      final failure = ServerFailure(message: 'Server error');
      when(mockRepository.getProductList(page: tPage)).thenAnswer((_) async => Left(failure));

      // act
      final result = await getProductListUseCase(page: tPage);

      // assert
      expect(result, Left(failure));
      verify(mockRepository.getProductList(page: tPage));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
