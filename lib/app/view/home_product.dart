import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management/app/controller/product_controller.dart';

class HomeProduct extends StatelessWidget {
  HomeProduct({super.key});

  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(child: Text('Header')),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () {
                Get.back();
                Get.toNamed('/setting');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/checkout');
            },
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return ListTile(
                    leading: Image.asset(product.image),
                    title: Text(product.name),
                    subtitle: Text('\$${product.price}'),
                    trailing: IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        controller.addToCart(product);
                      },
                    ),
                  );
                },
              );
            }),
          ),
          Divider(),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total: \$${controller.totalPrice}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }),
          ElevatedButton(
            onPressed: controller.checkout,
            child: Text('Go to Checkout'),
          ),
        ],
      ),
    );
  }
}
