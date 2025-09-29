import 'package:store/features/home/data/datasources/home_remote_datasource.dart';
import 'package:store/features/home/data/models/product_model.dart';
import 'package:store/features/home/domain/repositories/home_repository.dart';
import 'package:store/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> saveProduct({required Product product}) async {
    try {
      /// Save product to remote data source
      await remoteDataSource.saveProduct(product: product);

      return Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProductList({required int page, String? search}) async {
    try {
      /// Get product list from remote data source
      final productModel = await remoteDataSource.getProductList(page: page, search: search);

      return Right(productModel);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct({required String id}) async {
    try {
      /// Delete product from remote data source
      await remoteDataSource.deleteProduct(id: id);

      return Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct({required Product product}) async {
    try {
      /// Update product in remote data source
      await remoteDataSource.updateProduct(product: product);

      return Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
