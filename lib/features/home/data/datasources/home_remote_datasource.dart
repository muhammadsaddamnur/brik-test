import 'package:dio/dio.dart';
import 'package:store/core/network/dio_client.dart';
import 'package:store/features/home/data/models/product_model.dart';

abstract class HomeRemoteDataSource {
  /// Save product
  Future<void> saveProduct({required Product product});

  /// Get product list
  Future<ProductModel> getProductList({required int page});

  /// Delete product
  Future<void> deleteProduct({required String id});

  /// Update product
  Future<void> updateProduct({required Product product});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient;

  HomeRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<void> saveProduct({required Product product}) async {
    try {
      final json = product.toJson();

      await dioClient.post('/products', data: json);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ProductModel> getProductList({required int page}) async {
    try {
      final response = await dioClient.get('/products', queryParameters: {'page': page, 'pageSize': 10});

      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteProduct({required String id}) async {
    try {
      await dioClient.delete('/products/$id');
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateProduct({required Product product}) async {
    try {
      await dioClient.put('/products/${product.id}', data: product.toJson());
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
