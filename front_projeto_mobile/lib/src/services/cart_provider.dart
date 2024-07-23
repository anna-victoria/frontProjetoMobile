import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> item, int quantity) {
    final existingItemIndex = _cartItems.indexWhere((i) => i['titulo'] == item['titulo']);
    if (existingItemIndex >= 0) {
      _cartItems[existingItemIndex]['quantidade'] += quantity;
    } else {
      _cartItems.add({...item, 'quantidade': quantity});
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
