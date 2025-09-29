import 'package:equatable/equatable.dart';
import 'package:store/features/home/data/models/product_model.dart';

class HomeState extends Equatable {
  const HomeState({this.productModel, this.isLoading = false, this.error, this.hasReachedMax = false});

  final ProductModel? productModel;
  final bool isLoading;
  final Object? error;
  final bool hasReachedMax;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [productModel, isLoading, error, hasReachedMax];
}
