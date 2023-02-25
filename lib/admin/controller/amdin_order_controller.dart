import 'package:flutter_fire_base/admin/controller/product_controller.dart';
import 'package:flutter_fire_base/admin/model/order_model.dart';
import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/admin/services/database_service.dart';
import 'package:get/state_manager.dart';

class OrderController extends GetxController {
  final DatabaseService database = DatabaseService();
  ProductsController productsController = ProductsController();
  var todaysOrder = <Order>[].obs;
  var lastWeekOrder = <Order>[].obs;
  var lastMonthOrder = <Order>[].obs;

  var todaysOrderCompleted = <OrderCompleted>[].obs;
  var lastWeekOrderCompleted = <OrderCompleted>[].obs;
  var lastMonthOrderCompleted = <OrderCompleted>[].obs;
  var allOrders = <Order>[].obs;
  var showNewProductAddToOrder = false.obs;

  Map<dynamic, List> orders = {};
  var orderDetails = <OrderDetails>[].obs;
  var productsOrder = <Product>[].obs;
  var orderState = ''.obs;
  var quantity = 1.obs;
  var isLoading = false.obs;
  Order? lastOrderForUser;
  var favoriteProducts = <Order>[].obs;

  var completedOrdersForUser = <OrderCompleted>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    todaysOrder.bindStream(database.getTodayOrders());
    lastWeekOrder.bindStream(database.getLastWeekOrders());
    lastMonthOrder.bindStream(database.getLastMonthOrders());
    allOrders.bindStream(database.getOrders());

    todaysOrderCompleted.bindStream(database.getTodayOrdersCompleted());
    lastWeekOrderCompleted.bindStream(database.getLastWeekOrdersCompleted());
    lastMonthOrderCompleted.bindStream(database.getLastMonthOrdersCompleted());

    orderState.value = 'قيد الانتضار';

    //  orderController.todaysOrderCompleted.value =
    // orderController.todaysOrderCompleted.reversed.toList();

    super.onInit();
  }

  Future<void> getCompletedOrdersForUser(String userId) async {
    completedOrdersForUser
        .bindStream(database.getOrdersCompletedForUser(userId));
  }

  Future<void> getUserFavoriteProducts(String userId) async {
    favoriteProducts.bindStream(database.getFavorite(userId));
  }

  Future<void> addOrder(Order order) async {
    database.addOrder(order);
  }

  Future<Order?> getLastOrder() async {
    await database.getLastOrder();
    return null;
  }

  double getTotal() {
    double total = 0;
    var to = orderDetails.map((element) => element.price).toList();
    print(to);
    total = to.reduce((value, element) => value + element);
    return total;
  }

  Future<void> updateQuantity(
      OrderDetails orderDetail, int index, int value, Product product) async {
    orderDetail.itemQuantity = orderDetail.itemQuantity + value;

    if (value >= 2) orderDetail.itemQuantity = value;
    orderDetail.price = double.parse(product.price) * orderDetail.itemQuantity;
    orderDetails[index] = orderDetail;

    // print(getTotal().toString());
  }

  Future<void> deleteOrder(OrderDetails orderDetail, int index) async {
    orderDetails.removeWhere(
      (item) => item.productId == orderDetail.productId,
    );
  }

  Future<void> deleteFavorite(String id, String userId, int index) async {
    favoriteProducts.removeAt(index);
    await database.deleteFavorite(id, userId);
  }

  double getQuantityPrice(String price) {
    return double.parse(price) * quantity.value;
  }

  Future<void> updateOrder(
      OrderCompleted orderCompleted, int section, int index, int value) async {
    if (section == 0) {
      orderCompleted.order.status = value;
      todaysOrderCompleted[index] = orderCompleted;
    } else if (section == 1) {
      orderCompleted.order.status = value;
      lastWeekOrderCompleted[index] = orderCompleted;
    } else {
      orderCompleted.order.status = value;
      lastMonthOrderCompleted[index] = orderCompleted;
    }

    database.updateOrderCompleted(orderCompleted, 'order.status', value);
  }
}
