// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductDetailModel {

 int? get id; int? get categoryId; String? get categoryName; String? get sku; String? get name; String? get description; int? get weight; int? get width; int? get length; int? get height; String? get image; int? get harga;
/// Create a copy of ProductDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailModelCopyWith<ProductDetailModel> get copyWith => _$ProductDetailModelCopyWithImpl<ProductDetailModel>(this as ProductDetailModel, _$identity);

  /// Serializes this ProductDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.width, width) || other.width == width)&&(identical(other.length, length) || other.length == length)&&(identical(other.height, height) || other.height == height)&&(identical(other.image, image) || other.image == image)&&(identical(other.harga, harga) || other.harga == harga));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,categoryName,sku,name,description,weight,width,length,height,image,harga);

@override
String toString() {
  return 'ProductDetailModel(id: $id, categoryId: $categoryId, categoryName: $categoryName, sku: $sku, name: $name, description: $description, weight: $weight, width: $width, length: $length, height: $height, image: $image, harga: $harga)';
}


}

/// @nodoc
abstract mixin class $ProductDetailModelCopyWith<$Res>  {
  factory $ProductDetailModelCopyWith(ProductDetailModel value, $Res Function(ProductDetailModel) _then) = _$ProductDetailModelCopyWithImpl;
@useResult
$Res call({
 int? id, int? categoryId, String? categoryName, String? sku, String? name, String? description, int? weight, int? width, int? length, int? height, String? image, int? harga
});




}
/// @nodoc
class _$ProductDetailModelCopyWithImpl<$Res>
    implements $ProductDetailModelCopyWith<$Res> {
  _$ProductDetailModelCopyWithImpl(this._self, this._then);

  final ProductDetailModel _self;
  final $Res Function(ProductDetailModel) _then;

/// Create a copy of ProductDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? categoryId = freezed,Object? categoryName = freezed,Object? sku = freezed,Object? name = freezed,Object? description = freezed,Object? weight = freezed,Object? width = freezed,Object? length = freezed,Object? height = freezed,Object? image = freezed,Object? harga = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,harga: freezed == harga ? _self.harga : harga // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductDetailModel].
extension ProductDetailModelPatterns on ProductDetailModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductDetailModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductDetailModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductDetailModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? categoryId,  String? categoryName,  String? sku,  String? name,  String? description,  int? weight,  int? width,  int? length,  int? height,  String? image,  int? harga)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductDetailModel() when $default != null:
return $default(_that.id,_that.categoryId,_that.categoryName,_that.sku,_that.name,_that.description,_that.weight,_that.width,_that.length,_that.height,_that.image,_that.harga);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? categoryId,  String? categoryName,  String? sku,  String? name,  String? description,  int? weight,  int? width,  int? length,  int? height,  String? image,  int? harga)  $default,) {final _that = this;
switch (_that) {
case _ProductDetailModel():
return $default(_that.id,_that.categoryId,_that.categoryName,_that.sku,_that.name,_that.description,_that.weight,_that.width,_that.length,_that.height,_that.image,_that.harga);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? categoryId,  String? categoryName,  String? sku,  String? name,  String? description,  int? weight,  int? width,  int? length,  int? height,  String? image,  int? harga)?  $default,) {final _that = this;
switch (_that) {
case _ProductDetailModel() when $default != null:
return $default(_that.id,_that.categoryId,_that.categoryName,_that.sku,_that.name,_that.description,_that.weight,_that.width,_that.length,_that.height,_that.image,_that.harga);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductDetailModel implements ProductDetailModel {
  const _ProductDetailModel({this.id, this.categoryId, this.categoryName, this.sku, this.name, this.description, this.weight, this.width, this.length, this.height, this.image, this.harga});
  factory _ProductDetailModel.fromJson(Map<String, dynamic> json) => _$ProductDetailModelFromJson(json);

@override final  int? id;
@override final  int? categoryId;
@override final  String? categoryName;
@override final  String? sku;
@override final  String? name;
@override final  String? description;
@override final  int? weight;
@override final  int? width;
@override final  int? length;
@override final  int? height;
@override final  String? image;
@override final  int? harga;

/// Create a copy of ProductDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDetailModelCopyWith<_ProductDetailModel> get copyWith => __$ProductDetailModelCopyWithImpl<_ProductDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.width, width) || other.width == width)&&(identical(other.length, length) || other.length == length)&&(identical(other.height, height) || other.height == height)&&(identical(other.image, image) || other.image == image)&&(identical(other.harga, harga) || other.harga == harga));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,categoryName,sku,name,description,weight,width,length,height,image,harga);

@override
String toString() {
  return 'ProductDetailModel(id: $id, categoryId: $categoryId, categoryName: $categoryName, sku: $sku, name: $name, description: $description, weight: $weight, width: $width, length: $length, height: $height, image: $image, harga: $harga)';
}


}

/// @nodoc
abstract mixin class _$ProductDetailModelCopyWith<$Res> implements $ProductDetailModelCopyWith<$Res> {
  factory _$ProductDetailModelCopyWith(_ProductDetailModel value, $Res Function(_ProductDetailModel) _then) = __$ProductDetailModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? categoryId, String? categoryName, String? sku, String? name, String? description, int? weight, int? width, int? length, int? height, String? image, int? harga
});




}
/// @nodoc
class __$ProductDetailModelCopyWithImpl<$Res>
    implements _$ProductDetailModelCopyWith<$Res> {
  __$ProductDetailModelCopyWithImpl(this._self, this._then);

  final _ProductDetailModel _self;
  final $Res Function(_ProductDetailModel) _then;

/// Create a copy of ProductDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? categoryId = freezed,Object? categoryName = freezed,Object? sku = freezed,Object? name = freezed,Object? description = freezed,Object? weight = freezed,Object? width = freezed,Object? length = freezed,Object? height = freezed,Object? image = freezed,Object? harga = freezed,}) {
  return _then(_ProductDetailModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,harga: freezed == harga ? _self.harga : harga // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
