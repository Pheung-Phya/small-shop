import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management/app/controller/product_controller.dart';

class CheckoutProduct extends StatelessWidget {
  final controller = Get.find<ProductController>();
  final RxSet<int> selectedProducts = <int>{}.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.cart.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 100,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your cart is empty!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Start adding products to your cart.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed('/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                  ),
                  child: const Text(
                    'Go Back to Shop',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Cart:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.cart.length,
                  itemBuilder: (context, index) {
                    final product = controller.cart[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                product.image,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.teal[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'x ${product.quantity} = \$${(product.price * product.quantity).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle,
                                          color: Colors.red),
                                      onPressed: () {
                                        if (product.quantity > 1) {
                                          controller.decreaseQuantity(product);
                                        }
                                      },
                                    ),
                                    Text(
                                      product.quantity.toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle,
                                          color: Colors.green),
                                      onPressed: () {
                                        controller.addToCart(product);
                                      },
                                    ),
                                  ],
                                ),
                                Obx(() {
                                  return Checkbox(
                                    value: selectedProducts.contains(index),
                                    onChanged: (isSelected) {
                                      if (isSelected == true) {
                                        selectedProducts.add(index);
                                      } else {
                                        selectedProducts.remove(index);
                                      }
                                    },
                                  );
                                }),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red[400],
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(
                                        context, product);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              Obx(() {
                final selectedTotal = selectedProducts.fold<double>(
                  0.0,
                  (sum, index) =>
                      sum +
                      (controller.cart[index].price *
                          controller.cart[index].quantity),
                );
                return Text(
                  'Selected Total: \$${selectedTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (selectedProducts.isEmpty) {
                    Get.snackbar('No Products Selected',
                        'Please select products to checkout.');
                    return;
                  }

                  List<int> selectedList = selectedProducts.toList();
                  selectedList.sort((a, b) => b.compareTo(a));

                  for (var index in selectedList) {
                    controller.cart.removeAt(index);
                  }

                  selectedProducts.clear();
                  Get.snackbar('Payment', 'You paid with cash! Thank you!');
                  Get.offAllNamed('/card');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: const Text(
                  'Pay for Selected Products',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, dynamic product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                controller.removeFromCart(product);
                Get.back();
                Get.snackbar('Deleted', 'Product has been removed from cart.');
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
