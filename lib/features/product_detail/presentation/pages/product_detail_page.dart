import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/di/injection_container.dart';
import 'package:store/core/utils/colors_util.dart';
import 'package:store/core/utils/currency_util.dart';
import 'package:store/core/widgets/loading_widget.dart';
import 'package:store/features/product_detail/presentation/bloc/product_detail_cubit.dart';
import 'package:store/features/product_detail/presentation/bloc/product_detail_state.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late ProductDetailCubit productDetailCubit;

  @override
  void initState() {
    super.initState();
    productDetailCubit = sl<ProductDetailCubit>();
    productDetailCubit.getProductDetail(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk'), backgroundColor: ColorsUtil.yellow),
      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        bloc: productDetailCubit,
        builder: (context, state) {
          if (state is ProductDetailLoadingState) {
            return const Center(child: LoadingWidget());
          } else if (state is ProductDetailLoadedState) {
            final product = state.product;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.image != null && product.image!.isNotEmpty)
                    Center(
                      child: Image.network(
                        product.image!,

                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(height: 200, width: double.infinity, color: Colors.grey[300], child: const Icon(Icons.image_not_supported, size: 50));
                        },
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(product.name ?? 'Nama Produk Tidak Tersedia', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Kategori: ${product.categoryName ?? 'Tidak Tersedia'}', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  Text(
                    'Harga: ${CurrencyUtil.formatCurrency(product.harga ?? 0)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(height: 16),
                  const Text('Deskripsi:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(product.description ?? 'Deskripsi tidak tersedia', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),
                  const Text('Spesifikasi:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildSpecificationItem('SKU', product.sku),
                  _buildSpecificationItem('Berat', '${product.weight ?? '-'} gram'),
                  _buildSpecificationItem('Dimensi', '${product.length ?? '-'} x ${product.width ?? '-'} x ${product.height ?? '-'} cm'),
                ],
              ),
            );
          } else if (state is ProductDetailErrorState) {
            return Center(
              child: Text('Error: ${state.message}', style: const TextStyle(color: ColorsUtil.grey)),
            );
          }
          return const Center(child: Text('Silakan pilih produk'));
        },
      ),
    );
  }

  Widget _buildSpecificationItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(child: Text(value ?? 'Tidak tersedia')),
        ],
      ),
    );
  }
}
