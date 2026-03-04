import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/product_list/product_list_request_entity.dart';
import '../riverpod/product_list_provider.dart';
import '../widgets/product_card.dart';

part '../widgets/product_list_builder.dart';
part '../widgets/search_bar.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});

  @override
  ConsumerState<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  static const _debounce = Duration(milliseconds: 400);
  static const _categories = [
    'All',
    'beauty',
    'fragrances',
    'furniture',
    'groceries',
    'home-decoration',
    'kitchen-accessories',
  ];

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);

    ref.listenManual(productListProvider, (_, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 300) {
      ref.read(productListProvider.notifier).loadMoreProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productListProvider);

    return Column(
      children: [
        const SizedBox(height: 8),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => ref.refresh(productListProvider.future),
            child: state.when(
              skipLoadingOnReload: true,
              data: (products) => _ProductListBuilder(
                scrollController: _scrollController,
                products: products,
                state: state,
              ),
              error: (_, _) {
                return const Center(child: Text('Something went wrong'));
              },
              loading: () => Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
