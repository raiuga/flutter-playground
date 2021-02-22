import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/order_item.dart';
import '../models/cart_item.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://theshopappflutter.firebaseio.com/orders/$userId.json?auth=$authToken';

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<OrderItem> loadedOrders = [];

    if (extractedData == null) {
      return;
    }

    extractedData.forEach(
      (orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (product) => CartItem(
                    id: product['id'],
                    price: product['price'],
                    quantity: product['quantity'],
                    title: product['title'],
                  ),
                )
                .toList(),
          ),
        );
      },
    );
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://theshopappflutter.firebaseio.com/orders/$userId.json?auth=$authToken';
    try {
      final dateTime = DateTime.now();

      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'products': cartProducts
              .map((cartProduct) => {
                    'id': cartProduct.id,
                    'title': cartProduct.title,
                    'quantity': cartProduct.quantity,
                    'price': cartProduct.price,
                  })
              .toList(),
          'dateTime': dateTime.toIso8601String(),
        }),
      );

      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: dateTime,
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
