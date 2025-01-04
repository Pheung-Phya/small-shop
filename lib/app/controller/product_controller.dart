import 'package:get/get.dart';
import 'package:state_management/app/model/product.dart';

class ProductController extends GetxController {
  var cart = <Product>[].obs;

  var products = <Product>[
    Product(name: 'Boostrong', price: 20.0, image: 'assets/boostrong.jpg'),
    Product(name: 'Carabao', price: 50.0, image: 'assets/carabao.jpg'),
    Product(name: 'Ganzberg', price: 15.0, image: 'assets/ganzberg.jpg'),
  ].obs;

  void addToCart(Product product) {
    cart.add(product);
  }

  void removeFromCart(Product product) {
    cart.remove(product);
  }

  double get totalPrice => cart.fold(0.0, (sum, item) => sum + item.price);

  void checkout() {
    if (cart.isEmpty) {
      Get.snackbar('Empty Cart', 'Your cart is empty, add some items first');
    } else {
      Get.toNamed('/checkout');
    }
  }
}
