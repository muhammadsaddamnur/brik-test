import 'package:store/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:store/features/home/domain/repositories/home_repository.dart';

class DeleteProductUseCase {
  final HomeRepository homeRepository;

  DeleteProductUseCase({required this.homeRepository});

  Future<Either<Failure, void>> call({required String id}) async {
    return await homeRepository.deleteProduct(id: id);
  }
}
