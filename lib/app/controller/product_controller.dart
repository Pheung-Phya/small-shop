import 'package:get/get.dart';
import 'package:state_management/app/model/product.dart';

class ProductController extends GetxController {
  var cart = <Product>[].obs;

  var products = <Product>[
    Product(
        id: '1', name: 'Boostrong', price: 20.0, image: 'assets/boostrong.jpg'),
    Product(id: '2', name: 'Carabao', price: 50.0, image: 'assets/carabao.jpg'),
    Product(
        id: '3', name: 'Ganzberg', price: 15.0, image: 'assets/ganzberg.jpg'),
  ].obs;

  void addToCart(Product product) {
    final index = cart.indexWhere((item) => item.id == product.id);

    if (index != -1) {
      cart[index].quantity++;
    } else {
      cart.add(Product(
        id: product.id,
        name: product.name,
        price: product.price,
        image: product.image,
        quantity: 1,
      ));
    }

    cart.refresh();
  }

  void removeFromCart(Product product) {
    cart.removeWhere((item) => item.id == product.id);
    cart.refresh();
  }

  double get totalPrice =>
      cart.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  void checkout() {
    if (cart.isEmpty) {
      Get.snackbar('Empty Cart', 'Your cart is empty, add some items first');
    } else {
      Get.toNamed('/checkout');
    }
  }

  void decreaseQuantity(Product product) {
    final index = cart.indexWhere((item) => item.id == product.id);
    if (index != -1 && cart[index].quantity > 1) {
      cart[index].quantity--;
    }
    cart.refresh();
  }
}
