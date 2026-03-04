import '../../core/base/failure.dart';
import '../../core/base/result.dart';
import '../entities/product_list/product_list_request_entity.dart';
import '../repositories/product_list_repository.dart';

class ProductListUseCase {
  ProductListUseCase({required this.repository});

  final ProductListRepository repository;

  Future<Result<List<ProductResponseEntity>, Failure>> call({
    required bool reset,
  }) async {
    return repository.getProductList(
      requestEntity: ProductListRequestEntity(reset: reset),
    );
  }
}
