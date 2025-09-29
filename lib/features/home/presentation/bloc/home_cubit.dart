import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/features/home/data/models/product_model.dart';
import 'package:store/features/home/domain/usecases/delete_product_usecase.dart';
import 'package:store/features/home/domain/usecases/get_product_list_usecase.dart';
import 'package:store/features/home/domain/usecases/save_product_usecase.dart';
import 'package:store/features/home/domain/usecases/update_product_usecase.dart';
import 'package:store/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductListUseCase getProductListUseCase;
  final SaveProductUseCase saveProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  int page = 1;

  HomeCubit({required this.getProductListUseCase, required this.saveProductUseCase, required this.deleteProductUseCase, required this.updateProductUseCase}) : super(const HomeState());

  /// Get product list
  Future<void> getProductList({bool isRefresh = false, String? search}) async {
    if (isRefresh) {
      page = 1;
      emit(HomeState(productModel: null, isLoading: true, hasReachedMax: false, error: null));
    }
    if (state.hasReachedMax) {
      return;
    }

    emit(HomeState(productModel: state.productModel, isLoading: true));

    final result = await getProductListUseCase(page: page, search: search);

    result.fold((failure) => emit(HomeState(error: failure.message)), (productModel) {
      if (productModel.products == null) {
        emit(HomeState(productModel: state.productModel, hasReachedMax: true, isLoading: false));
        return;
      }

      page = page + 1;

      emit(HomeState(productModel: ProductModel(products: [...state.productModel?.products ?? [], ...productModel.products ?? []]), hasReachedMax: false, isLoading: false));
    });
  }

  /// Save product
  Future<void> saveProduct({required Product product}) async {
    final result = await saveProductUseCase(product: product);
    result.fold((failure) => Fluttertoast.showToast(msg: failure.message), (success) => Fluttertoast.showToast(msg: 'Successfully Saved'));

    getProductList(isRefresh: true);
  }

  /// Delete product
  Future<void> deleteProduct({required String id}) async {
    final result = await deleteProductUseCase(id: id);
    result.fold((failure) => Fluttertoast.showToast(msg: failure.message), (success) => Fluttertoast.showToast(msg: 'Successfully Deleted'));

    getProductList(isRefresh: true);
  }

  /// Update product
  Future<void> updateProduct({required Product product}) async {
    final result = await updateProductUseCase(product: product);
    result.fold((failure) => Fluttertoast.showToast(msg: failure.message), (success) => Fluttertoast.showToast(msg: 'Successfully Updated'));

    getProductList(isRefresh: true);
  }
}
