// import 'package:exam/cartpage.dart';
// import 'package:exam/model.dart';
// import 'package:flutter/material.dart';

// // class Cart {
// //   List<Item> item = [
// //     Item(name: 'Item', price: 10.55),
// //     Item(name: 'item2', price: 20.22)
// //   ];
// // }

// // class Item {
// //   String name;
// //   double price;

// //   Item({required this.name, required this.price});
// //   double totalPrice = 0.0;
// //   for (var item in cartItems){
// //     totalPrice +=item.price;
// //   }
// // }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               vertical: 40,
//               horizontal: 20,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Exam',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const CartPage(),
//                       ),
//                     );
//                   },
//                   icon: const Icon(Icons.add_shopping_cart),
//                 ),
//                 Column(
//                   children: [Text(ProductModel.dummylist() as String)],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    quantity--;
  }
}

class Cart {
  List<CartItem> items = [];

  void addItem(Product product) {
    for (CartItem item in items) {
      if (item.product.name == product.name) {
        item.incrementQuantity();
        return;
      }
    }
    items.add(CartItem(product: product));
  }

  void removeItem(CartItem item) {
    items.remove(item);
  }
}

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  _ShoppingCartScreenState createState() {
    return _ShoppingCartScreenState();
  }
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final Cart cart = Cart();
  final List<Product> products = [
    Product(name: 'Product A', price: 10.0),
    Product(name: 'Product B', price: 20.0),
    Product(name: 'Product C', price: 30.0),
    Product(name: "jeans", price: 50.00),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price}'),
            trailing: ElevatedButton(
              onPressed: () {
                cart.addItem(product);
                setState(() {});
              },
              child: const Text('Add to Cart'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return CartScreen(cart: cart);
              },
            ),
          );
        },
        label: const Text('View Cart'),
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({super.key, required this.cart});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: widget.cart.items.isEmpty
          ? const Center(
              child: Text('Your cart is empty.'),
            )
          : ListView.builder(
              itemCount: widget.cart.items.length,
              itemBuilder: (BuildContext context, int index) {
                CartItem item = widget.cart.items[index];
                return ListTile(
                  title: Text(item.product.name),
                  subtitle: Text('\$${item.product.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          item.decrementQuantity();
                          setState(() {});
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(item.quantity.toString()),
                      IconButton(
                        onPressed: () {
                          item.incrementQuantity();
                          setState(() {});
                        },
                        icon: const Icon(Icons.add),
                      ),
                      IconButton(
                        onPressed: () {
                          widget.cart.removeItem(item);
                          setState(() {});
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
