import 'package:dartz/dartz.dart';
import 'package:store/core/error/exceptions.dart';
import 'package:store/core/error/failures.dart';
import 'package:store/features/product_detail/data/datasources/product_detail_remote_data_source.dart';
import 'package:store/features/product_detail/data/models/product_detail_model.dart';
import 'package:store/features/product_detail/domain/repositories/product_detail_repository.dart';

class ProductDetailRepositoryImpl implements ProductDetailRepository {
  final ProductDetailRemoteDataSource remoteDataSource;

  ProductDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProductDetailModel>> getProductDetail(String id) async {
    try {
      final result = await remoteDataSource.getProductDetail(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
