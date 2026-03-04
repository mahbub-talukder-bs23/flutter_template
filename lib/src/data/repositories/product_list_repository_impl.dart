import '../../core/base/failure.dart';
import '../../core/base/result.dart';
import '../../core/pagination/pagination_strategies.dart';
import '../../domain/entities/product_list/product_list_request_entity.dart';
import '../../domain/repositories/product_list_repository.dart';
import '../models/product_list_model.dart';
import '../services/network/rest_client.dart';

final class ProductListRepositoryImpl extends ProductListRepository {
  ProductListRepositoryImpl({
    required this.restClient,
    required this.paginationStrategy,
  });

  final RestClient restClient;
  final OffsetPaginationStrategy<ProductResponseEntity> paginationStrategy;

  final List<ProductResponseEntity> _productList = [];

  @override
  Future<Result<List<ProductResponseEntity>, Failure>> getProductList({
    required ProductListRequestEntity requestEntity,
  }) async {
    return asyncGuard(() async {
      final result = await restClient.getProductList(
        limit: paginationStrategy.limit,
        skip: paginationStrategy.getNextParam(requestEntity.reset),
      );

      final model = ProductListResponseModel.fromJson(result.data);

      paginationStrategy.updateNextParam(nextParam: model.offset);

      return paginationStrategy.getUpdatedItems(
        reset: requestEntity.reset,
        newItems: model.products,
        itemList: _productList,
      );
    });
  }
}
