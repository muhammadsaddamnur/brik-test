import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/core/di/injection_container.dart';
import 'package:store/core/storage/local_storage.dart';
import 'package:store/core/utils/colors_util.dart';
import 'package:store/core/utils/currency_util.dart';
import 'package:store/core/widgets/button_widget.dart';
import 'package:store/core/widgets/loading_widget.dart';
import 'package:store/core/widgets/textfield_widget.dart';
import 'package:store/features/category/presentation/bloc/category_cubit.dart';
import 'package:store/features/category/presentation/bloc/category_state.dart';
import 'package:store/features/category/presentation/pages/category_page.dart';
import 'package:store/features/home/data/models/product_model.dart';
import 'package:store/features/home/presentation/bloc/home_cubit.dart';
import 'package:store/features/home/presentation/bloc/home_state.dart';
import 'package:store/features/login/presentation/pages/login_page.dart';
import 'package:store/features/product_detail/presentation/pages/product_detail_page.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeCubit = sl<HomeCubit>();
  final nameController = TextEditingController();
  var category = '';
  final priceController = TextEditingController();
  final weightController = TextEditingController();
  final widthController = TextEditingController();
  final lengthController = TextEditingController();
  final heightController = TextEditingController();
  final descController = TextEditingController();

  cleanControllers() {
    nameController.clear();
    category = '';
    priceController.clear();
    weightController.clear();
    widthController.clear();
    lengthController.clear();
    heightController.clear();
    descController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PRODUCTS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        actions: [
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await sl<LocalStorage>().clearUser();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: BlocBuilder<HomeCubit, HomeState>(
              bloc: homeCubit,
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    SliverInfiniteList(
                      itemCount: state.productModel?.products?.length ?? 0,
                      onFetchData: () {
                        homeCubit.getProductList();
                      },
                      isLoading: state.isLoading,
                      errorBuilder: (context) {
                        return Center(
                          child: Text(state.error.toString(), style: TextStyle(color: ColorsUtil.grey)),
                        );
                      },
                      loadingBuilder: (context) {
                        return Center(child: LoadingWidget());
                      },
                      emptyBuilder: (context) {
                        return const Center(
                          child: Text('Products is empty', style: TextStyle(color: ColorsUtil.grey)),
                        );
                      },
                      itemBuilder: (context, index) {
                        final product = state.productModel?.products?[index];

                        return ListTile(
                          leading: Image.network(state.productModel?.products?[index].image ?? 'https://via.placeholder.com/150', width: 50, height: 50),
                          title: Row(
                            children: [
                              Flexible(child: Text((state.productModel?.products?[index].name ?? 'Unknown').toUpperCase())),
                              SizedBox(width: 5),
                              Container(
                                decoration: BoxDecoration(color: ColorsUtil.yellow, borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text((product?.categoryName ?? 'Unknown'), style: TextStyle(fontSize: 10)),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(CurrencyUtil.formatCurrency(product?.harga ?? 0)),
                          onTap: () {
                            // Navigate to product detail page
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(productId: product?.id?.toString() ?? '')));
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                iconSize: 15,
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  cleanControllers();

                                  // Navigate to edit item page
                                  nameController.text = product?.name ?? '';

                                  category = product?.categoryName ?? '';

                                  priceController.text = product?.harga?.toString() ?? '';
                                  weightController.text = product?.weight?.toString() ?? '';
                                  widthController.text = product?.width?.toString() ?? '';
                                  lengthController.text = product?.length?.toString() ?? '';
                                  heightController.text = product?.height?.toString() ?? '';
                                  descController.text = product?.description ?? '';

                                  saveOrUpdateProduct(isSave: false, id: product?.id);
                                },
                              ),
                              IconButton(
                                iconSize: 15,
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  homeCubit.deleteProduct(id: (product?.id ?? 0).toString());
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    if (state.hasReachedMax && state.productModel != null) ...[
                      const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 16.0),
                            child: Text('No more data', style: TextStyle(color: ColorsUtil.grey)),
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ButtonWidget(onPressed: saveOrUpdateProduct, text: 'Add a Item'),
            ),
          ),
        ],
      ),
    );
  }

  void saveOrUpdateProduct({bool isSave = true, int? id}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        String? localItemImageUrl;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  Center(child: Text('Add a Item', style: Theme.of(context).textTheme.titleMedium)),
                  const SizedBox(height: 20),
                  TextfieldWidget(controller: nameController, hint: 'Name'),
                  const SizedBox(height: 20),

                  /// create category combobox widget with shared preference data
                  BlocBuilder<CategoryCubit, CategoryState>(
                    bloc: sl<CategoryCubit>()..getCategoryList(),
                    builder: (context, state) {
                      if (state is CategoryLoadedState) {
                        if (state.categoryList.isEmpty) {
                          if (category.isNotEmpty) {
                            return TextfieldWidget(hint: category, readOnly: true);
                          }
                          return ButtonWidget(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryPage()));
                            },
                            text: 'Add a Category',
                          );
                        }

                        category = category.isNotEmpty ? category : state.categoryList.first.categoryName ?? '';

                        return DropdownButtonFormField<String>(
                          initialValue: category.isNotEmpty ? category : state.categoryList.first.categoryName,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          items: state.categoryList.map((category) {
                            return DropdownMenuItem<String>(value: category.categoryName, child: Text(category.categoryName ?? ''));
                          }).toList(),
                          onChanged: (value) {
                            category = value ?? '';
                          },
                        );
                      } else if (state is CategoryErrorState) {
                        return Center(child: Text(state.message));
                      }
                      return SizedBox();
                    },
                  ),
                  const SizedBox(height: 20),
                  TextfieldWidget(controller: descController, hint: 'Desc', maxLines: 3),
                  const SizedBox(height: 20),
                  TextfieldWidget(controller: weightController, hint: 'Weight', keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  TextfieldWidget(controller: widthController, hint: 'Width', keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  TextfieldWidget(controller: lengthController, hint: 'Length', keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  TextfieldWidget(controller: heightController, hint: 'Height', keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  TextfieldWidget(controller: priceController, hint: 'Price', keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      final imageUrl = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (imageUrl != null) {
                        // Update both the local state and parent state
                        setModalState(() {
                          localItemImageUrl = 'https://cdn.paintpro.co.id/category-images/dk-max-interior.png';
                        });
                        localItemImageUrl = localItemImageUrl;
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                      child: localItemImageUrl != null ? Image.network(localItemImageUrl!) : const Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ButtonWidget(
                    onPressed: () async {
                      if (isSave) {
                        final sku = Random().nextInt(100);
                        await homeCubit.saveProduct(
                          product: Product(
                            name: nameController.text,
                            weight: int.parse(weightController.text),
                            width: int.parse(widthController.text),
                            length: int.parse(lengthController.text),
                            height: int.parse(heightController.text),
                            harga: int.parse(priceController.text),
                            categoryId: 1,
                            categoryName: category,
                            description: descController.text,
                            sku: '$sku',
                            image: 'https://cdn.paintpro.co.id/category-images/dk-max-interior.png',
                          ),
                        );
                      } else {
                        await homeCubit.updateProduct(
                          product: Product(
                            name: nameController.text,
                            weight: int.parse(weightController.text),
                            width: int.parse(widthController.text),
                            length: int.parse(lengthController.text),
                            height: int.parse(heightController.text),
                            harga: int.parse(priceController.text),
                            categoryId: 1,
                            categoryName: category,
                            id: id,
                            description: descController.text,
                            image: 'https://cdn.paintpro.co.id/category-images/dk-max-interior.png',
                          ),
                        );
                      }
                      cleanControllers();

                      Navigator.pop(context);
                    },
                    text: isSave ? 'Save' : 'Update',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
