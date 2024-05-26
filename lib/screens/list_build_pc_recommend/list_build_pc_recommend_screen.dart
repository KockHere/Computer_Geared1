import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/PCBuilderAPI.dart';
import 'package:shop_app/models/specifications/UserPC.dart';
import 'package:shop_app/screens/build_pc_recommend/build_pc_recommend_screen.dart';
import 'package:shop_app/screens/list_build_pc_recommend/components/pc_build_card.dart';
import 'package:shop_app/screens/list_build_pc_recommend/components/purpose_card.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/variables.dart';

class ListBuildPcRecommendScreen extends StatefulWidget {
  const ListBuildPcRecommendScreen({super.key});

  @override
  State<ListBuildPcRecommendScreen> createState() =>
      _ListBuildPcRecommendScreenState();
}

class _ListBuildPcRecommendScreenState
    extends State<ListBuildPcRecommendScreen> {
  List<UserPC> listAllUserPc = [];
  List<UserPC> listUserPc = [];

  int selectedPrice = 20;

  List<String> selectedPurpose = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    PCBuilderAPI.getListUserPcRecommend().then((data) {
      listAllUserPc = data;
      listUserPc = data;
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  int updateTotalPrice(UserPC userPC) {
    int totalPrice = 0;
    if (userPC.motherboardSpecification != null) {
      totalPrice += int.parse(userPC.motherboardSpecification!.unitPrice!);
    }
    if (userPC.processorSpecification != null) {
      totalPrice += int.parse(userPC.processorSpecification!.unitPrice!);
    }
    if (userPC.caseSpecification != null) {
      totalPrice += int.parse(userPC.caseSpecification!.unitPrice!);
    }
    if (userPC.gpuSpecification != null) {
      totalPrice += int.parse(userPC.gpuSpecification!.unitPrice!);
    }
    if (userPC.ramSpecification != null) {
      totalPrice +=
          int.parse(userPC.ramSpecification!.unitPrice!) * userPC.ramQuantity!;
    }

    if (userPC.storageSpecification != null) {
      totalPrice += int.parse(userPC.storageSpecification!.unitPrice!) *
          userPC.storageQuantity!;
    }
    if (userPC.cpuCoolerSpecification != null) {
      totalPrice += int.parse(userPC.cpuCoolerSpecification!.unitPrice!);
    }
    if (userPC.caseCoolerSpecification != null) {
      totalPrice += int.parse(userPC.caseCoolerSpecification!.unitPrice!);
    }
    if (userPC.psuSpecification != null) {
      totalPrice += int.parse(userPC.psuSpecification!.unitPrice!);
    }
    if (userPC.monitorSpecification != null) {
      totalPrice += int.parse(userPC.monitorSpecification!.unitPrice!);
    }
    return totalPrice;
  }

  String updateDescription(UserPC userPC) {
    String description = "";
    if (userPC.motherboardSpecification != null) {
      description += userPC.motherboardSpecification!.name!;
    } else if (userPC.processorSpecification != null) {
      description += userPC.processorSpecification!.name!;
    } else if (userPC.caseSpecification != null) {
      description += userPC.caseSpecification!.name!;
    } else if (userPC.gpuSpecification != null) {
      description += userPC.gpuSpecification!.name!;
    } else if (userPC.ramSpecification != null) {
      description += userPC.ramSpecification!.name!;
    } else if (userPC.storageSpecification != null) {
      description += userPC.storageSpecification!.name!;
    } else if (userPC.cpuCoolerSpecification != null) {
      description += userPC.cpuCoolerSpecification!.name!;
    } else if (userPC.caseCoolerSpecification != null) {
      description += userPC.caseCoolerSpecification!.name!;
    } else if (userPC.psuSpecification != null) {
      description += userPC.psuSpecification!.name!;
    } else if (userPC.monitorSpecification != null) {
      description += userPC.monitorSpecification!.name!;
    } else {
      description += "Empty Build";
    }
    return description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "PC Build List Recommend",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      backgroundColor: const Color(0xfff6f6f6),
      body: Stack(
        children: [
          Stack(
            children: [
              SingleChildScrollView(
                child: listUserPc.isNotEmpty
                    ? Column(
                        children: [
                          const SizedBox(height: 80),
                          ...List.generate(
                            listUserPc.length,
                            (index) => PcBuildCard(
                              userPC: listUserPc[index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BuildPCRecommendScreen(
                                              userPC: listUserPc[index])),
                                ).then((result) {
                                  if (result != null && result == true) {
                                    Navigator.pop(context, result);
                                  }
                                });
                              },
                              totalPrice: updateTotalPrice(listUserPc[index]),
                              description: updateDescription(listUserPc[index]),
                              onTapSelect: () {
                                if (user.userId == "") {
                                  Navigator.pushNamed(
                                      context, SignInScreen.routeName);
                                } else {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  PCBuilderAPI.copyBuildPC(
                                          listUserPc[index].userPcBuildId ?? "")
                                      .then((data) {
                                    if (mounted) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                    Navigator.pop(context, data);
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    : const Center(child: Text("There is no PC Build")),
              ),
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: 0.5,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  title: Container(
                    margin: const EdgeInsets.only(left: 30),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text('Build PC Configuration'),
                  ),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Purpose"),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PurposeCard(
                                  isCheck: selectedPurpose.contains("GAMING"),
                                  purposeText: "GAMING",
                                  onTap: () {
                                    if (selectedPurpose.contains("GAMING")) {
                                      selectedPurpose.removeWhere(
                                          (element) => element == "GAMING");
                                    } else {
                                      selectedPurpose.add("GAMING");
                                    }
                                    setState(() {});
                                  },
                                ),
                                PurposeCard(
                                  isCheck: selectedPurpose.contains("OFFICE"),
                                  purposeText: "OFFICE",
                                  onTap: () {
                                    if (selectedPurpose.contains("OFFICE")) {
                                      selectedPurpose.removeWhere(
                                          (element) => element == "OFFICE");
                                    } else {
                                      selectedPurpose.add("OFFICE");
                                    }
                                    setState(() {});
                                  },
                                ),
                                PurposeCard(
                                  isCheck: selectedPurpose.contains("CUSTOM"),
                                  purposeText: "CUSTOM",
                                  onTap: () {
                                    if (selectedPurpose.contains("CUSTOM")) {
                                      selectedPurpose.removeWhere(
                                          (element) => element == "CUSTOM");
                                    } else {
                                      selectedPurpose.add("CUSTOM");
                                    }
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Text("Price Range"),
                          Center(
                            child: Text(
                              "${selectedPrice.toInt()},000,000đ",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Slider(
                            value: selectedPrice.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                selectedPrice = value.toInt();
                              });
                            },
                            min: 20,
                            max: 100,
                            divisions: 16,
                            activeColor: kPrimaryColor,
                            label: "${selectedPrice.toInt()},000,000đ",
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              if (selectedPurpose.isEmpty) {
                                listUserPc = listAllUserPc
                                    .where((element) =>
                                        element.totalPrice! <=
                                        (selectedPrice * 1000000))
                                    .toList();
                              } else {
                                listUserPc = listAllUserPc
                                    .where((element) =>
                                        selectedPurpose
                                            .contains(element.purposeName!) &&
                                        element.totalPrice! <=
                                            (selectedPrice * 1000000))
                                    .toList();
                              }
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(10, 8, 16, 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: kPrimaryColor,
                              ),
                              child: const Text(
                                "Filter",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          isLoading ? const LoadingScreen() : Container(),
        ],
      ),
    );
  }
}
