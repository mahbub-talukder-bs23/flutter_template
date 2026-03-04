class ProductListRequestEntity {
  ProductListRequestEntity({this.reset = false});

  bool reset;
}

class ProductListResponseEntity {
  ProductListResponseEntity({
    required this.products,
    this.offset = 0,
    required this.total,
  });

  final List<ProductResponseEntity> products;
  final int offset;
  final int total;
}

class ProductResponseEntity {
  ProductResponseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.category,
    required this.rating,
    required this.discountPercentage,
  });

  final int id;
  final String title;
  final String description;
  final num price;
  final String thumbnail;
  final String category;
  final num rating;
  final num discountPercentage;

  String getDiscountPrice() {
    return (price - (price * discountPercentage / 100)).toStringAsFixed(2);
  }
}
