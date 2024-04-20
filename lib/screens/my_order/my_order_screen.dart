import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/OrderAPI.dart';
import 'package:shop_app/models/OrderStatus.dart';
import 'package:shop_app/models/Orders.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/screens/my_order/components/order_card.dart';
import 'package:shop_app/screens/order_detail/order_detail_screen.dart';
import 'package:shop_app/variables.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  List<Orders> listAllOrders = [];
  List<Orders> listOrders = [];
  List<OrderStatus> listOrderStatus = [OrderStatus(statusDetails: "All")];

  OrderStatus? selectedOrderStatus;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int limit = 10;

  @override
  void initState() {
    super.initState();
    selectedOrderStatus = listOrderStatus[0];
    setState(() {
      isLoading = true;
    });
    OrderAPI.getListOrderStatus().then((orderStatus) {
      listOrderStatus.addAll(orderStatus);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
    getListOrders();
  }

  void getListOrders() {
    OrderAPI.getListOrders(limit).then((orders) {
      listAllOrders = orders;
      listOrders = orders;
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xfff6f6f6),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              "Order List",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Order: ${listOrders.length}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<OrderStatus>(
                          value: selectedOrderStatus,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: const TextStyle(color: kPrimaryColor),
                          onChanged: (OrderStatus? value) {
                            if (value!.statusDetails == "All") {
                              listOrders = listAllOrders;
                            } else {
                              listOrders = listAllOrders
                                  .where((element) =>
                                      element.statusDetail ==
                                      value.statusDetails)
                                  .toList();
                            }
                            setState(() {
                              selectedOrderStatus = value;
                            });
                          },
                          underline: Container(),
                          items: listOrderStatus
                              .map<DropdownMenuItem<OrderStatus>>(
                                  (OrderStatus value) {
                            return DropdownMenuItem<OrderStatus>(
                              value: value,
                              child: Text(value.statusDetails ?? ""),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 164,
                    child: SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: () {
                        limit = 10;
                        getListOrders();
                        _refreshController.refreshCompleted();
                      },
                      onLoading: () {
                        limit += 10;
                        getListOrders();
                        _refreshController.loadComplete();
                      },
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          itemCount: listOrders.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => OrderCard(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderDetailScreen(
                                        orders: listOrders[index])),
                              );
                            },
                            orders: listOrders[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isLoading ? const LoadingScreen() : Container(),
      ],
    );
  }
}
