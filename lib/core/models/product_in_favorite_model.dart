class ProductInFavorite {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;

  ProductInFavorite({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}

class FavoriteItem {
  final ProductInFavorite product;
  int quantity;

  FavoriteItem({required this.product, this.quantity = 1});
}
