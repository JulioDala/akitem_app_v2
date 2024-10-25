import 'package:flutter/material.dart';
import '../../../core/models/product_in_cart_model.dart';

class CartItem {
  final ProductInCart product;
  final int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  // Getters para facilitar o acesso aos dados do produto
  String get id => product.id;
  String get name => product.name;
  double get price => product.price;
  String get imageUrl => product.imageUrl;
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  List<CartItem> get itemsList => _items.values.toList();

  void addItem(ProductInCart product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(product: product),
      );
    }
    notifyListeners();
  }

  void updateQuantity(String productId, int newQuantity) {
    if (!_items.containsKey(productId)) return;
    
    if (newQuantity <= 0) {
      removeItem(productId);
    } else {
      _items.update(
        productId,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: newQuantity,
        ),
      );
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get itemCount => _items.length;

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }
}