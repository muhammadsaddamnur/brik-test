import 'package:store/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:store/features/home/data/models/product_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, void>> saveProduct({required Product product});
  Future<Either<Failure, ProductModel>> getProductList({required int page});
  Future<Either<Failure, void>> deleteProduct({required String id});
  Future<Either<Failure, void>> updateProduct({required Product product});
}
