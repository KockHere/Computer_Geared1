import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/OrderStatusAPI.dart';
import 'package:shop_app/models/OrderStatus.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/variables.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  List<OrderStatus> listOrderStatus = [OrderStatus(statusDetails: "All")];

  OrderStatus? selectedOrderStatus;

  @override
  void initState() {
    super.initState();
    selectedOrderStatus = listOrderStatus[0];
    setState(() {
      isLoading = true;
    });
    OrderStatusAPI.getListOrderStatus().then((orderStatus) {
      listOrderStatus.addAll(orderStatus);
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
              "Đơn hàng",
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
                      const Text(
                        "Tổng đơn hàng: 3",
                        style: TextStyle(
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
                            setState(() {
                              selectedOrderStatus = value;
                            });
                          },
                          underline: Container(),
                          items: listOrderStatus.map<DropdownMenuItem<OrderStatus>>(
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
                  // if (orderStatus == "Hoàn thành") ...[
                  //   OrderCard(
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const OrderDetailScreen(orderStatus: "Hoàn thành")),
                  //       );
                  //     },
                  //     cartItem: demoCarts[0],
                  //     orderStatus: "Hoàn thành",
                  //   ),
                  // ] else if (orderStatus == "Hủy") ...[
                  //   OrderCard(
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const OrderDetailScreen(orderStatus: "Hủy")),
                  //       );
                  //     },
                  //     cartItem: demoCarts[1],
                  //     orderStatus: "Hủy",
                  //   ),
                  // ] else if (orderStatus == "Đang vận chuyển") ...[
                  //   OrderCard(
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const OrderDetailScreen(orderStatus: "Đang vận chuyển")),
                  //       );
                  //     },
                  //     cartItem: demoCarts[0],
                  //     orderStatus: "Đang vận chuyển",
                  //   ),
                  // ] else ...[
                  //   OrderCard(
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const OrderDetailScreen(orderStatus: "Hoàn thành")),
                  //       );
                  //     },
                  //     cartItem: demoCarts[0],
                  //     orderStatus: "Hoàn thành",
                  //   ),
                  //   OrderCard(
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const OrderDetailScreen(orderStatus: "Hủy")),
                  //       );
                  //     },
                  //     cartItem: demoCarts[1],
                  //     orderStatus: "Hủy",
                  //   ),
                  //   OrderCard(
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const OrderDetailScreen(orderStatus: "Đang vận chuyển")),
                  //       );
                  //     },
                  //     cartItem: demoCarts[0],
                  //     orderStatus: "Đang vận chuyển",
                  //   ),
                  // ],
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
