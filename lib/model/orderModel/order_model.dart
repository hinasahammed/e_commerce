class OrderModel {
  final int code;
  final String orderNo;
  final String status;
  final String dot;
  final List<String> products;
  final double total;
  final String expectedTot;
  final String adress;

  OrderModel({
    required this.code,
    required this.orderNo,
    required this.status,
    required this.dot,
    required this.products,
    required this.total,
    required this.expectedTot,
    required this.adress,
  });
}
