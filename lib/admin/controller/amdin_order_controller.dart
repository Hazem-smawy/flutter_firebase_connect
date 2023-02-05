import 'package:flutter_fire_base/admin/model/order_model.dart';
import 'package:flutter_fire_base/admin/services/database_service.dart';
import 'package:get/state_manager.dart';

class OrderController extends GetxController {
  final DatabaseService database = DatabaseService();
  var todaysOrder = <Order>[].obs;
  var lastWeekOrder = <Order>[].obs;
  var lastMonthOrder = <Order>[].obs;
  var allOrders = <Order>[].obs;
  Map<dynamic, List> orders = {};
  var orderState = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    todaysOrder.bindStream(database.getTodayOrders());
    lastWeekOrder.bindStream(database.getLastWeekOrders());
    lastMonthOrder.bindStream(database.getLastMonthOrders());
    allOrders.bindStream(database.getOrders());

    orderState.value = 'قيد الانتضار';

    super.onInit();
  }

  var order = Order(
    id: 5,
    customerId: 'قاسم السماوي',
    orderNote: 'this order is the best put some problem in it is ..',
    orderOn: DateTime.now().subtract(const Duration(hours: 1)),
    currencyId: 1,
    subtotal: 300,
    amountDescount: 500,
    totalAbount: 700,
    orderDetails: const [
      OrderDetails(
        id: 1,
        productId: 2,
        itemQuantity: 3,
        price: 400,
        note: 'note',
      ),
      OrderDetails(
        id: 2,
        productId: 3,
        itemQuantity: 2,
        price: 500,
        note: 'note 2',
      ),
      OrderDetails(
        id: 3,
        productId: 4,
        itemQuantity: 5,
        price: 200,
        note: 'note 3',
      ),
    ],
  );

  Future<void> addOrder() async {
    database.addOrder(order);
  }

  Future<void> updateOrder(
      Order order, int section, int index, int value) async {
    if (section == 0) {
      order.status = value;
      todaysOrder[index] = order;
    } else if (section == 1) {
      order.status = value;
      lastWeekOrder[index] = order;
    } else {
      order.status = value;
      lastMonthOrder[index] = order;
    }

    database.updateOrder(order, 'status', value);
  }
}
