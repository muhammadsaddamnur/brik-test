import 'package:store/core/error/exceptions.dart';
import 'package:store/core/network/dio_client.dart';
import 'package:store/features/product_detail/data/models/product_detail_model.dart';

abstract class ProductDetailRemoteDataSource {
  /// Get product detail from remote data source
  Future<ProductDetailModel> getProductDetail(String id);
}

class ProductDetailRemoteDataSourceImpl implements ProductDetailRemoteDataSource {
  final DioClient dioClient;

  ProductDetailRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<ProductDetailModel> getProductDetail(String id) async {
    try {
      final response = await dioClient.get('/products/$id');
      return ProductDetailModel.fromJson(response.data);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
