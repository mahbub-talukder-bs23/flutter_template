import '../../core/base/failure.dart';
import '../../core/base/repository.dart';
import '../../core/base/result.dart';
import '../entities/product_list/product_list_request_entity.dart';

abstract base class ProductListRepository extends Repository {
  Future<Result<List<ProductResponseEntity>, Failure>> getProductList({
    required ProductListRequestEntity requestEntity,
  });
}
