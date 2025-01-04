import 'package:get/get.dart';
import 'package:state_management/app/model/product.dart';

class ShopController extends GetxController {
  var cart = <Product>[].obs;

  var products = <Product>[
    Product(name: 'T-shirt', price: 20.0, image: 'assets/tshirt.png'),
    Product(name: 'Shoes', price: 50.0, image: 'assets/shoes.png'),
    Product(name: 'Hat', price: 15.0, image: 'assets/hat.png'),
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
    } else {}
  }
}
