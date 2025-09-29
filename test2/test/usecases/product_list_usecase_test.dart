import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:store/core/error/failures.dart';
import 'package:store/features/home/data/models/product_model.dart';
import 'package:store/features/home/domain/repositories/home_repository.dart';
import 'package:store/features/home/domain/usecases/get_product_list_usecase.dart';

@GenerateMocks([HomeRepository])
import 'product_list_usecase_test.mocks.dart';

void main() {
  late GetProductListUseCase usecase;
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = GetProductListUseCase(homeRepository: mockHomeRepository);
  });

  final productModel = ProductModel(products: [Product(id: 1, name: 'Product 1')]);

  test('should get product list from the repository', () async {
    // arrange
    when(mockHomeRepository.getProductList(page: anyNamed('page'))).thenAnswer((_) async => Right(productModel));

    // act
    final result = await usecase(page: 1);

    // assert
    expect(result, Right(productModel));
    verify(mockHomeRepository.getProductList(page: anyNamed('page')));
    verifyNoMoreInteractions(mockHomeRepository);
  });

  test('should return a failure when the repository call fails', () async {
    // arrange
    final failure = ServerFailure(message: 'Server error');
    when(mockHomeRepository.getProductList(page: anyNamed('page'))).thenAnswer((_) async => Left(failure));

    // act
    final result = await usecase(page: 1);

    // assert
    expect(result, Left(failure));
    verify(mockHomeRepository.getProductList(page: anyNamed('page')));
    verifyNoMoreInteractions(mockHomeRepository);
  });
}
