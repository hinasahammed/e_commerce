import 'package:e_commerce/res/components/constants/data/orders.dart';
import 'package:e_commerce/res/components/text/label_large_text.dart';
import 'package:e_commerce/res/utils/utils.dart';
import 'package:e_commerce/view/orders/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.animation?.addListener(() {
      final newIndex = _tabController.animation!.value.round();
      if (_currentIndex != newIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders"), elevation: 0),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            splashBorderRadius: BorderRadius.circular(15),
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelPadding: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(vertical: 12),
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _currentIndex == 0
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: LabelLargeText(
                    text: "Ongoing",
                    textColor: _currentIndex == 0
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface,
                    fontWeight: _currentIndex == 0
                        ? FontWeight.w500
                        : FontWeight.w400,
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _currentIndex == 1
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: LabelLargeText(
                    text: "Completed",
                    textColor: _currentIndex == 1
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface,
                    fontWeight: _currentIndex == 1
                        ? FontWeight.w500
                        : FontWeight.w400,
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _currentIndex == 2
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: LabelLargeText(
                    text: "Cancelled",
                    textColor: _currentIndex == 2
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface,
                    fontWeight: _currentIndex == 2
                        ? FontWeight.w500
                        : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.separated(
                    itemCount: groceryOngoingOrders.length,
                    padding: const EdgeInsets.only(bottom: 60),
                    separatorBuilder: (context, index) => const Gap(10),
                    itemBuilder: (context, index) {
                      final e = groceryOngoingOrders[index];
                      return OrderCard(
                        orderNo: e.orderNo,
                        dot: e.dot,
                        status: e.status,
                        total: Utils.formatIndianCurrency(e.total),
                        expectedTot: e.expectedTot,
                        address: e.adress,
                      );
                    },
                  ),
                  ListView.separated(
                    itemCount: groceryCompletedOrders.length,
                    padding: const EdgeInsets.only(bottom: 60),
                    separatorBuilder: (context, index) => const Gap(10),
                    itemBuilder: (context, index) {
                      final e = groceryCompletedOrders[index];
                      return OrderCard(
                        orderNo: e.orderNo,
                        dot: e.dot,
                        status: e.status,
                        total: Utils.formatIndianCurrency(e.total),
                        expectedTot: e.expectedTot,
                        address: e.adress,
                      );
                    },
                  ),
                  ListView.separated(
                    itemCount: groceryCancelledOrders.length,
                    padding: const EdgeInsets.only(bottom: 60),
                    separatorBuilder: (context, index) => const Gap(10),
                    itemBuilder: (context, index) {
                      final e = groceryCancelledOrders[index];
                      return OrderCard(
                        orderNo: e.orderNo,
                        dot: e.dot,
                        status: e.status,
                        total: Utils.formatIndianCurrency(e.total),
                        expectedTot: e.expectedTot,
                        address: e.adress,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
