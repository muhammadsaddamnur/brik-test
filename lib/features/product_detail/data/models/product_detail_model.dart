import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'product_detail_model.freezed.dart';
part 'product_detail_model.g.dart';

ProductDetailModel productDetailModelFromJson(String str) => ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) => json.encode(data.toJson());

@freezed
abstract class ProductDetailModel with _$ProductDetailModel {
  const factory ProductDetailModel({
    int? id,
    int? categoryId,
    String? categoryName,
    String? sku,
    String? name,
    String? description,
    int? weight,
    int? width,
    int? length,
    int? height,
    String? image,
    int? harga,
  }) = _ProductDetailModel;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => _$ProductDetailModelFromJson(json);
}
