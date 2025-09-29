import 'package:dartz/dartz.dart';
import 'package:store/core/error/failures.dart';
import 'package:store/features/product_detail/data/models/product_detail_model.dart';
import 'package:store/features/product_detail/domain/repositories/product_detail_repository.dart';

class GetProductDetailUseCase {
  final ProductDetailRepository repository;

  GetProductDetailUseCase({required this.repository});

  Future<Either<Failure, ProductDetailModel>> call(String id) async {
    return await repository.getProductDetail(id);
  }
}
