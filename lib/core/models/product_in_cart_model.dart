class ProductInCart {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;
  final String? description;
  ProductInCart({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    this.description, 

  });
}

class CartItem {
  final ProductInCart product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
