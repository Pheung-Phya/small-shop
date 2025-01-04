import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management/app/controller/product_controller.dart';

class CheckoutProduct extends StatelessWidget {
  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Cart:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: controller.cart.length,
                itemBuilder: (context, index) {
                  final product = controller.cart[index];
                  return ListTile(
                    leading: Image.asset(product.image),
                    title: Text(product.name),
                    subtitle: Text('\$${product.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () {
                        controller.removeFromCart(product);
                      },
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Obx(() {
              return Text(
                'Total: \$${controller.totalPrice}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.snackbar('Payment', 'You paid with cash! Thank you!');
                controller.cart.clear(); // Clear cart after checkout
                Get.offNamed('/card'); // Navigate to confirmation screen
              },
              child: const Text('Pay with Cash'),
            ),
          ],
        ),
      ),
    );
  }
}
