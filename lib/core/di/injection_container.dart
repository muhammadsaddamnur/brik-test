import 'package:get_it/get_it.dart';
import 'package:secure_shared_preferences/secure_shared_preferences.dart';
import 'package:store/core/network/dio_client.dart';
import 'package:store/core/storage/local_storage.dart';
import 'package:store/features/category/data/datasources/category_local_data_source.dart';
import 'package:store/features/category/data/repositories/category_repository_impl.dart';
import 'package:store/features/category/domain/repositories/category_repository.dart';
import 'package:store/features/category/domain/usecases/delete_category_usecase.dart';
import 'package:store/features/category/domain/usecases/get_category_list_usecase.dart';
import 'package:store/features/category/domain/usecases/save_category_usecase.dart';
import 'package:store/features/category/presentation/bloc/category_cubit.dart';
import 'package:store/features/home/data/datasources/home_remote_datasource.dart';
import 'package:store/features/home/data/repositories/home_repository_impl.dart';
import 'package:store/features/home/domain/repositories/home_repository.dart';
import 'package:store/features/home/domain/usecases/delete_product_usecase.dart';
import 'package:store/features/home/domain/usecases/get_product_list_usecase.dart';
import 'package:store/features/home/domain/usecases/save_product_usecase.dart';
import 'package:store/features/home/domain/usecases/update_product_usecase.dart';
import 'package:store/features/home/presentation/bloc/home_cubit.dart';
import 'package:store/features/login/data/datasources/login_remote_datasource.dart';
import 'package:store/features/login/data/repositories/login_repository_impl.dart';
import 'package:store/features/login/domain/repositories/login_repository.dart';
import 'package:store/features/login/domain/usecases/login_usecase.dart';
import 'package:store/features/login/presentation/bloc/login_cubit.dart';
import 'package:store/features/product_detail/data/datasources/product_detail_remote_data_source.dart';
import 'package:store/features/product_detail/data/repositories/product_detail_repository_impl.dart';
import 'package:store/features/product_detail/domain/repositories/product_detail_repository.dart';
import 'package:store/features/product_detail/domain/usecases/get_product_detail_usecase.dart';
import 'package:store/features/product_detail/presentation/bloc/product_detail_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SecureSharedPref.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => LocalStorage());

  // Core
  sl.registerLazySingleton(() => DioClient(baseUrl: 'https://klontong.sdmnr.xyz/api'));

  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(dioClient: sl()));
  sl.registerLazySingleton<CategoryLocalDataSource>(() => CategoryLocalDataSourceImpl());
  sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(dioClient: sl()));
  sl.registerLazySingleton<ProductDetailRemoteDataSource>(() => ProductDetailRemoteDataSourceImpl(dioClient: sl()));

  // Repositories
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ProductDetailRepository>(() => ProductDetailRepositoryImpl(remoteDataSource: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetProductListUseCase(homeRepository: sl()));
  sl.registerLazySingleton(() => SaveProductUseCase(homeRepository: sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(homeRepository: sl()));
  sl.registerLazySingleton(() => UpdateProductUseCase(homeRepository: sl()));
  sl.registerLazySingleton(() => SaveCategoryUseCase(categoryRepository: sl()));
  sl.registerLazySingleton(() => GetCategoryListUseCase(categoryRepository: sl()));
  sl.registerLazySingleton(() => DeleteCategoryUseCase(categoryRepository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(loginRepository: sl()));
  sl.registerLazySingleton(() => GetProductDetailUseCase(repository: sl()));

  // Cubits
  sl.registerFactory(() => HomeCubit(getProductListUseCase: sl(), saveProductUseCase: sl(), deleteProductUseCase: sl(), updateProductUseCase: sl()));
  sl.registerFactory(() => CategoryCubit(saveCategoryUseCase: sl(), getCategoryListUseCase: sl(), deleteCategoryUseCase: sl()));
  sl.registerFactory(() => LoginCubit(loginUseCase: sl()));
  sl.registerFactory(() => ProductDetailCubit(getProductDetailUseCase: sl()));
}
