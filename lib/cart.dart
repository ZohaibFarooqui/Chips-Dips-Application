import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final Map<String, int> cartItems;
  final Map<String, double> prices;

  CartPage({required this.cartItems, required this.prices});

  double getTotal() {
    double total = 0.0;
    cartItems.forEach((product, quantity) {
      total += (quantity * (prices[product] ?? 0.0));
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ...cartItems.keys.map((product) => ListTile(
            title: Text('$product (Rs ${prices[product]})'),
            subtitle: Text('Quantity: ${cartItems[product]}'),
          )),
          SizedBox(height: 20),
          Text(
            'Total: Rs ${getTotal().toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
