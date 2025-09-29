import 'package:flutter_test/flutter_test.dart';
import 'package:store/features/category/data/models/category_model.dart';
import 'package:store/features/category/presentation/bloc/category_state.dart';

void main() {
  group('CategoryState', () {
    test('CategoryInitialState props should be empty', () {
      const state = CategoryInitialState();
      expect(state.props, []);
    });

    test('CategoryLoadingState props should be empty', () {
      const state = CategoryLoadingState();
      expect(state.props, []);
    });

    test('CategoryLoadedState props should contain categoryList', () {
      final categoryList = [
        CategoryModel(categoryName: 'Category 1'),
        CategoryModel(categoryName: 'Category 2'),
      ];
      final state = CategoryLoadedState(categoryList: categoryList);
      expect(state.props, [categoryList]);
    });

    test('CategoryErrorState props should contain message', () {
      const message = 'Error message';
      const state = CategoryErrorState(message: message);
      expect(state.props, [message]);
    });

    test('CategoryLoadedState equality', () {
      final categoryList1 = [
        CategoryModel(categoryName: 'Category 1'),
      ];
      final state1 = CategoryLoadedState(categoryList: categoryList1);
      final state2 = CategoryLoadedState(categoryList: categoryList1);
      final state3 = CategoryLoadedState(categoryList: [
        CategoryModel(categoryName: 'Different'),
      ]);

      expect(state1, equals(state2));
      expect(state1, isNot(equals(state3)));
    });

    test('CategoryErrorState equality', () {
      const state1 = CategoryErrorState(message: 'Error');
      const state2 = CategoryErrorState(message: 'Error');
      const state3 = CategoryErrorState(message: 'Different error');

      expect(state1, equals(state2));
      expect(state1, isNot(equals(state3)));
    });
  });
}