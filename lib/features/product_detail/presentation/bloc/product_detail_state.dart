import 'package:equatable/equatable.dart';
import 'package:store/features/product_detail/data/models/product_detail_model.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object?> get props => [];
}

class ProductDetailInitialState extends ProductDetailState {}

class ProductDetailLoadingState extends ProductDetailState {}

class ProductDetailLoadedState extends ProductDetailState {
  final ProductDetailModel product;

  const ProductDetailLoadedState({required this.product});

  @override
  List<Object?> get props => [product];
}

class ProductDetailErrorState extends ProductDetailState {
  final String message;

  const ProductDetailErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
