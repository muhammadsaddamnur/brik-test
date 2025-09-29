import 'package:store/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:store/features/home/data/models/product_model.dart';
import 'package:store/features/home/domain/repositories/home_repository.dart';

class UpdateProductUseCase {
  final HomeRepository homeRepository;

  UpdateProductUseCase({required this.homeRepository});

  Future<Either<Failure, void>> call({required Product product}) async {
    return await homeRepository.updateProduct(product: product);
  }
}
