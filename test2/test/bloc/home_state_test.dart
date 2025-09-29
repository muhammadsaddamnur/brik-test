import 'package:flutter_test/flutter_test.dart';
import 'package:store/features/home/data/models/product_model.dart';
import 'package:store/features/home/presentation/bloc/home_state.dart';

void main() {
  final productModel = ProductModel(products: [Product(id: 1, name: 'Product 1')]);

  group('HomeState', () {
    group('HomeInitialState', () {
      test('supports value equality', () {
        expect(const HomeState(), equals(const HomeState()));
      });

      test('props are empty', () {
        expect(const HomeState().props, equals([]));
      });
    });

    group('HomeLoadingState', () {
      test('supports value equality', () {
        expect(const HomeState(), equals(const HomeState()));
      });

      test('props are empty', () {
        expect(const HomeState().props, equals([]));
      });
    });

    group('HomeLoadedState', () {
      test('supports value equality', () {
        expect(HomeState(productModel: productModel), equals(HomeState(productModel: productModel)));
      });

      test('props contains productModel', () {
        expect(HomeState(productModel: productModel).props, equals([productModel]));
      });

      test('different productModel leads to different state', () {
        expect(HomeState(productModel: productModel), isNot(equals(HomeState(productModel: productModel))));
      });
    });

    group('HomeLoadedState with GenerationModel', () {
      test('supports value equality', () {
        expect(HomeState(productModel: productModel), equals(HomeState(productModel: productModel)));
      });

      test('props contains productModel', () {
        expect(HomeState(productModel: productModel).props, equals([productModel]));
      });

      test('different productModel leads to different state', () {
        expect(HomeState(productModel: productModel), isNot(equals(HomeState(productModel: productModel))));
      });
    });

    group('HomeErrorState', () {
      test('supports value equality', () {
        expect(const HomeState(error: 'error'), equals(const HomeState(error: 'error')));
      });

      test('props contains error', () {
        expect(const HomeState(error: 'error').props, equals(['error']));
      });

      test('different error leads to different state', () {
        expect(const HomeState(error: 'error1'), isNot(equals(const HomeState(error: 'error2'))));
      });
    });
  });
}
