import 'package:store/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:store/features/home/data/models/product_model.dart';
import 'package:store/features/home/domain/repositories/home_repository.dart';

class GetProductListUseCase {
  final HomeRepository homeRepository;

  GetProductListUseCase({required this.homeRepository});

  Future<Either<Failure, ProductModel>> call({required int page, String? search}) async {
    return await homeRepository.getProductList(page: page, search: search);
  }
}
