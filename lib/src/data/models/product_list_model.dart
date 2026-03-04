import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entities/product_list/product_list_request_entity.dart';

part 'product_list_model.mapper.dart';

@MappableClass(generateMethods: GenerateMethods.decode)
class ProductListResponseModel extends ProductListResponseEntity
    with ProductListResponseModelMappable {
  ProductListResponseModel({
    required List<ProductResponseModel> products,
    @MappableField(key: 'skip') required super.offset,
    required super.total,
  }) : super(products: products);

  static const fromJson = ProductListResponseModelMapper.fromJson;
}

@MappableClass(generateMethods: GenerateMethods.decode)
class ProductResponseModel extends ProductResponseEntity
    with ProductResponseModelMappable {
  ProductResponseModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.thumbnail,
    required super.category,
    required super.rating,
    required super.discountPercentage,
  });

  static const fromJson = ProductResponseModelMapper.fromJson;
}
