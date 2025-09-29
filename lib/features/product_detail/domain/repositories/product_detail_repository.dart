import 'package:dartz/dartz.dart';
import 'package:store/core/error/failures.dart';
import 'package:store/features/product_detail/data/models/product_detail_model.dart';

abstract class ProductDetailRepository {
  Future<Either<Failure, ProductDetailModel>> getProductDetail(String id);
}
