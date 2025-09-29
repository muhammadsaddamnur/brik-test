// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    _ProductModel(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'products': instance.products,
      'totalCount': instance.totalCount,
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'pageSize': instance.pageSize,
    };

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: (json['id'] as num?)?.toInt(),
  categoryId: (json['categoryId'] as num?)?.toInt(),
  categoryName: json['categoryName'] as String?,
  sku: json['sku'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  weight: (json['weight'] as num?)?.toInt(),
  width: (json['width'] as num?)?.toInt(),
  length: (json['length'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
  image: json['image'] as String?,
  harga: (json['harga'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'categoryId': instance.categoryId,
  'categoryName': instance.categoryName,
  'sku': instance.sku,
  'name': instance.name,
  'description': instance.description,
  'weight': instance.weight,
  'width': instance.width,
  'length': instance.length,
  'height': instance.height,
  'image': instance.image,
  'harga': instance.harga,
};
