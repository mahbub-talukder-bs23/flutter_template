import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../domain/entities/product_list/product_list_request_entity.dart';

part 'product_list_provider.g.dart';

@riverpod
class ProductList extends _$ProductList {
  @override
  FutureOr<List<ProductResponseEntity>> build() async {
    final result = await ref.read(productListUseCaseProvider).call(reset: true);
    return result.when(
      success: (value) => value!,
      error: (failure) => throw failure,
    );
  }

  Future<void> loadMoreProduct({bool reset = false}) async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    final result = await ref
        .read(productListUseCaseProvider)
        .call(reset: reset);

    state = result.when(
      success: (value) => AsyncValue.data(value!),
      error: (failure) => AsyncValue.error(failure, StackTrace.current),
    );
  }
}
