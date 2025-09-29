import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/core/di/injection_container.dart';
import 'package:store/core/utils/colors_util.dart';
import 'package:store/core/widgets/button_widget.dart';
import 'package:store/core/widgets/loading_widget.dart';
import 'package:store/core/widgets/textfield_widget.dart';
import 'package:store/features/category/data/models/category_model.dart';
import 'package:store/features/category/presentation/bloc/category_cubit.dart';
import 'package:store/features/category/presentation/bloc/category_state.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final categoryCubit = sl<CategoryCubit>();
  final categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoryCubit.getCategoryList();
    });
  }

  /// Save category to the database
  void saveCategory() {
    if (categoryController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please input category name');
      return;
    }

    categoryCubit.saveCategory(
      categoryModel: CategoryModel(
        categoryName: categoryController.text,
        id: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    categoryController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Category',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: BlocBuilder<CategoryCubit, CategoryState>(
              bloc: categoryCubit,
              builder: (context, state) {
                if (state is CategoryLoadingState) {
                  return const Center(child: LoadingWidget());
                } else if (state is CategoryLoadedState) {
                  if (state.categoryList.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Category Found',
                        style: TextStyle(color: ColorsUtil.grey),
                      ),
                    );
                  }

                  return CustomScrollView(
                    slivers: [
                      SliverList.builder(
                        itemCount: state.categoryList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              (state.categoryList[index].categoryName ??
                                  'Unknown'),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                size: 15,
                                color: ColorsUtil.red,
                              ),
                              onPressed: () {
                                categoryCubit.deleteCategory(index: index);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else if (state is CategoryErrorState) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('Unknown Error'));
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ButtonWidget(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextfieldWidget(
                              controller: categoryController,
                              hint: 'Category Name',
                            ),
                            const SizedBox(height: 20),
                            ButtonWidget(onPressed: saveCategory, text: 'Save'),
                          ],
                        ),
                      );
                    },
                  );
                },
                text: 'Add a Category',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
