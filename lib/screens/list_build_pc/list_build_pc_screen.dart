import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/PCBuilderAPI.dart';
import 'package:shop_app/models/specifications/UserPC.dart';
import 'package:shop_app/screens/build_pc/build_pc_screen.dart';
import 'package:shop_app/screens/list_build_pc/components/pc_build_card.dart';
import 'package:shop_app/screens/list_build_pc_recommend/list_build_pc_recommend_screen.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/variables.dart';

class ListBuildPcScreen extends StatefulWidget {
  const ListBuildPcScreen({super.key});

  @override
  State<ListBuildPcScreen> createState() => _ListBuildPcScreenState();
}

class _ListBuildPcScreenState extends State<ListBuildPcScreen> {
  TextEditingController pcName = TextEditingController();
  List<UserPC> listUserPc = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    PCBuilderAPI.getListUserPc().then((data) {
      listUserPc = data;
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Future<void> _showDialogAddPC() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New PC Build'),
          content: TextField(
            controller: pcName,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: "Enter PC Build Name",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                createNewPcBuild();
              },
              child: const Text('Add',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }

  void createNewPcBuild() {
    setState(() {
      isLoading = true;
    });
    PCBuilderAPI.addNewPC(UserPC(profileName: pcName.text)).then((result) {
      if (result) {
        PCBuilderAPI.getListUserPc().then((data) {
          listUserPc = data;
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        });
      }
    });
  }

  Future<void> _showDialogUpdateNamePC(UserPC userPc) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update PC Build'),
          content: TextFormField(
            initialValue: userPc.profileName,
            onChanged: (value) {
              userPc.profileName = value;
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: "Enter PC Build Name",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                updateNewPcBuild(userPc);
              },
              child: const Text('Update',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }

  void updateNewPcBuild(UserPC userPcUpdate) {
    setState(() {
      isLoading = true;
    });
    PCBuilderAPI.addNewPC(userPcUpdate).then((result) {
      if (result) {
        PCBuilderAPI.getListUserPc().then((data) {
          listUserPc = data;
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
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
        leading: Container(),
        title: Text(
          "PC Build List",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListBuildPcRecommendScreen()),
              ).then((result) {
                if (result != null && result == true) {
                  setState(() {
                    isLoading = true;
                  });
                  PCBuilderAPI.getListUserPc().then((data) {
                    listUserPc = data;
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  });
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.only(right: 20),
              color: Colors.transparent,
              child: const Text(
                "Recommend",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xfff6f6f6),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 20),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: listUserPc.isNotEmpty
                      ? Column(
                          children: [
                            ...List.generate(
                              listUserPc.length,
                              (index) => PcBuildCard(
                                userPC: listUserPc[index],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BuildPCScreen(
                                            userPC: listUserPc[index])),
                                  ).then((value) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    PCBuilderAPI.getListUserPc().then((data) {
                                      listUserPc = data;
                                      if (mounted) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    });
                                  });
                                },
                                totalPrice: updateTotalPrice(listUserPc[index]),
                                description:
                                    updateDescription(listUserPc[index]),
                                onTapUpdate: () {
                                  _showDialogUpdateNamePC(listUserPc[index]);
                                },
                                onTapDelete: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  PCBuilderAPI.deleteBuildPC(
                                          listUserPc[index].userPcBuildId ?? "")
                                      .then((data) {
                                    PCBuilderAPI.getListUserPc().then((data) {
                                      listUserPc = data;
                                      if (mounted) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    });
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      : const Center(child: Text("There is no PC Build")),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      if (user.userId == "") {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      } else {
                        _showDialogAddPC();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: kPrimaryColor),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading ? const LoadingScreen() : Container(),
        ],
      ),
    );
  }
}
