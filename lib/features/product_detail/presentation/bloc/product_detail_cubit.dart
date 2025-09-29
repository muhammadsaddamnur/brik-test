import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/features/product_detail/domain/usecases/get_product_detail_usecase.dart';
import 'package:store/features/product_detail/presentation/bloc/product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductDetailUseCase getProductDetailUseCase;

  ProductDetailCubit({required this.getProductDetailUseCase}) : super(ProductDetailInitialState());

  /// Get product detail
  Future<void> getProductDetail(String id) async {
    emit(ProductDetailLoadingState());
    final result = await getProductDetailUseCase(id);
    result.fold(
      (failure) {
        emit(ProductDetailErrorState(message: failure.message));
        Fluttertoast.showToast(msg: failure.message);
      },
      (data) {
        emit(ProductDetailLoadedState(product: data));
      },
    );
  }
}
