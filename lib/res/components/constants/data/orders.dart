import 'package:e_commerce/model/orderModel/order_model.dart';
import 'package:e_commerce/res/components/constants/data/orders_product.dart';

List<OrderModel> groceryOngoingOrders = [
  OrderModel(
    code: 1,
    orderNo: "ORD-2024-001",
    status: "0", // Pending
    dot: "Jan 15, 2024 • 10:30 AM",
    products: groceryOrdersProduct,
    total: 150.00,
    expectedTot: "Processing...",
    adress: "123 Main Street, Apt 4B, New York, NY 10001",
  ),
  OrderModel(
    code: 2,
    orderNo: "ORD-2024-002",
    status: "1", // Confirmed
    dot: "Feb 20, 2024 • 03:45 PM",
    products: groceryOrdersProduct,
    total: 245.75,
    expectedTot: "Arriving by Feb 22",
    adress: "456 Elm Street, San Francisco, CA 94107",
  ),
  OrderModel(
    code: 3,
    orderNo: "ORD-2024-003",
    status: "2", // Out for Delivery
    dot: "Mar 5, 2024 • 09:00 AM",
    products: groceryOrdersProduct,
    total: 99.99,
    expectedTot: "Out for Delivery",
    adress: "789 Oak Avenue, Los Angeles, CA 90001",
  ),
];

List<OrderModel> groceryCompletedOrders = [
  OrderModel(
    code: 4,
    orderNo: "ORD-2024-004",
    status: "3", // Delivered
    dot: "Apr 10, 2024 • 12:15 PM",
    products: groceryOrdersProduct,
    total: 189.50,
    expectedTot: "Delivered",
    adress: "321 Maple Lane, Austin, TX 73301",
  ),
  OrderModel(
    code: 5,
    orderNo: "ORD-2024-005",
    status: "3", // Delivered
    dot: "May 22, 2024 • 05:40 PM",
    products: groceryOrdersProduct,
    total: 212.00,
    expectedTot: "Delivered",
    adress: "654 Pine Street, Seattle, WA 98101",
  ),
];

List<OrderModel> groceryCancelledOrders = [
  OrderModel(
    code: 7,
    orderNo: "ORD-2024-007",
    status: "4", // Cancelled
    dot: "Jul 15, 2024 • 11:00 AM",
    products: groceryOrdersProduct,
    total: 132.40,
    expectedTot: "Cancelled",
    adress: "222 Birch Road, Chicago, IL 60601",
  ),
];
