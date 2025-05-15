/*
  Project: Pet Supplies E-commerce UI
  Niche: Pet Store - "Pawfect Picks"
  Flutter Version: Latest stable
  Assets required: Placeholders for product images in assets/images/
*/

import 'package:flutter/material.dart';

void main() {
  runApp(PawfectPicksApp());
}

class PawfectPicksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pawfect Picks',
      theme: ThemeData(primarySwatch: Colors.orange, fontFamily: 'Poppins'),
      home: SplashScreen(),
    );
  }
}

// Splash Screen
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProductListingScreen()),
      );
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png', height: 100),
            SizedBox(height: 20),
            Text(
              'Pawfect Picks',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Product Listing Screen
class ProductListingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Organic Dog Treats',
      'price': 12.99,
      'image': 'images/dog_treats.jpg',
      'description': 'Tasty organic treats made with real chicken.',
    },
    {
      'name': 'Cat Scratching Post',
      'price': 35.00,
      'image': 'images/cat_post.webp',
      'description':
          'Sturdy and stylish scratching post for cats of all sizes.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pawfect Picks")),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: product),
                  ),
                ),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(product['image'], height: 100),
                  SizedBox(height: 10),
                  Text(
                    product['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("\$${product['price']}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Product Detail Screen
class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['name'])),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(product['image'], height: 200)),
            SizedBox(height: 20),
            Text(
              product['name'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(product['description']),
            SizedBox(height: 10),
            Text(
              "Price: \$${product['price']}",
              style: TextStyle(fontSize: 18),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Mock add to cart
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: Text("Add to Cart"),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
            ),
          ],
        ),
      ),
    );
  }
}

// Cart Screen
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Column(
        children: [
          ListTile(
            leading: Image.asset('images/dog_treats.jpg', height: 50),
            title: Text("Organic Dog Treats"),
            subtitle: Text("Quantity: 1"),
            trailing: Text("\$12.99"),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: TextStyle(fontSize: 18)),
                    Text("\$12.99", style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(),
                        ),
                      ),
                  child: Text("Proceed to Checkout"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Checkout Screen
class CheckoutScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              TextFormField(decoration: InputDecoration(labelText: 'Address')),
              TextFormField(decoration: InputDecoration(labelText: 'City')),
              TextFormField(decoration: InputDecoration(labelText: 'ZIP Code')),
              DropdownButtonFormField(
                items:
                    ['Credit Card', 'PayPal']
                        .map(
                          (method) => DropdownMenuItem(
                            child: Text(method),
                            value: method,
                          ),
                        )
                        .toList(),
                onChanged: (value) {},
                decoration: InputDecoration(labelText: 'Payment Method'),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderConfirmedScreen(),
                    ),
                  );
                },
                child: Text("Place Order"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Order Confirmation Screen
class OrderConfirmedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Confirmed")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text(
              "Thank you for your purchase!",
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
