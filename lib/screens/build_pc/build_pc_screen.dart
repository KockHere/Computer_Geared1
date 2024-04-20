// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/AutoGenAPI.dart';
import 'package:shop_app/controllers/CartAPI.dart';
import 'package:shop_app/controllers/CategoryAPI.dart';
import 'package:shop_app/controllers/PCBuilderAPI.dart';
import 'package:shop_app/controllers/PCComponentAPI.dart';
import 'package:shop_app/models/CartItem.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/specifications/AutoGen.dart';
import 'package:shop_app/models/specifications/Case.dart';
import 'package:shop_app/models/specifications/CaseCooler.dart';
import 'package:shop_app/models/specifications/CpuCooler.dart';
import 'package:shop_app/models/specifications/Gpu.dart';
import 'package:shop_app/models/specifications/Monitor.dart';
import 'package:shop_app/models/specifications/Motherboard.dart';
import 'package:shop_app/models/specifications/Processor.dart';
import 'package:shop_app/models/specifications/Psu.dart';
import 'package:shop_app/models/specifications/Ram.dart';
import 'package:shop_app/models/specifications/Storage.dart';
import 'package:shop_app/models/specifications/UserPC.dart';
import 'package:shop_app/screens/build_pc/components/build_pc_cart.dart';
import 'package:shop_app/screens/build_pc/components/purpose_card.dart';
import 'package:shop_app/screens/choose_device/choose_device_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/show_dialog.dart';
import 'package:shop_app/variables.dart';

class BuildPCScreen extends StatefulWidget {
  BuildPCScreen({super.key, required this.userPC});

  UserPC userPC;
  @override
  State<BuildPCScreen> createState() => _BuildPCScreenState();
}

class _BuildPCScreenState extends State<BuildPCScreen> {
  List<Category> listCategory = [];
  List<Product> listSelectedProduct = [];
  double price = 0;

  int indexCategory = 0;
  List<Category> listIndexCategory = [];

  List<CartItem> listSelectedCartItem = [];
  int totalPage = 0;

  int selectedPrice = 20;

  AutoGen autoGen = AutoGen(preBuildId: "");

  int selectedPower = 0;
  int totalPower = 0;

  Psu psu = Psu(productId: "", power: 0);

  Gpu gpu = Gpu(productId: "", maxPowerConsumption: 0);
  Processor processor = Processor(productId: "", power: 0);

  List<String> selectedPurpose = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    CategoryAPI.getListCategory().then((categories) {
      listCategory = categories
          .where((element) => element.name!.toLowerCase().contains(RegExp(
              r'processor|motherboard|cooler cpu|case|gpu|psu|ram|storage|fan|monitor')))
          .toList();
      totalPage = (listCategory.length / 4).ceil();
      changeIndexCategory();
      if (widget.userPC.motherboardSpecification != null) {
        addListAutoGen(widget.userPC.motherboardSpecification!.toJson());
      }
      if (widget.userPC.processorSpecification != null) {
        addListAutoGen(widget.userPC.processorSpecification!.toJson());
      }
      if (widget.userPC.caseSpecification != null) {
        addListAutoGen(widget.userPC.caseSpecification!.toJson());
      }
      if (widget.userPC.gpuSpecification != null) {
        addListAutoGen(widget.userPC.gpuSpecification!.toJson());
      }
      if (widget.userPC.ramSpecification != null) {
        addListAutoGen(widget.userPC.ramSpecification!.toJson(),
            quantity: widget.userPC.ramQuantity);
      }
      if (widget.userPC.storageSpecification != null) {
        addListAutoGen(widget.userPC.storageSpecification!.toJson(),
            quantity: widget.userPC.storageQuantity);
      }
      if (widget.userPC.caseCoolerSpecification != null) {
        addListAutoGen(widget.userPC.caseCoolerSpecification!.toJson());
      }
      if (widget.userPC.monitorSpecification != null) {
        addListAutoGen(widget.userPC.monitorSpecification!.toJson());
      }

      if (widget.userPC.cpuCoolerSpecification != null) {
        addListAutoGen(widget.userPC.cpuCoolerSpecification!.toJson());
      }
      if (widget.userPC.psuSpecification != null) {
        addListAutoGen(widget.userPC.psuSpecification!.toJson());
      }
      updatePrice();
      updateTotalPower().then((value) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    });
  }

  void updatePrice() {
    price = 0;
    for (CartItem cartItem in listSelectedCartItem) {
      price += double.parse(cartItem.unitPrice!.replaceAll(",", "")) *
          cartItem.quantity!;
    }
  }

  Future<void> updateTotalPower() async {
    bool isGpu = true;
    bool isProccessor = true;
    bool isPsu = true;
    for (Product p in listSelectedProduct) {
      if (p.categoryName!.toLowerCase() == "gpu") {
        isGpu = false;
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          gpu = Gpu.fromJson(data);
        }
      }
      if (p.categoryName!.toLowerCase() == "processor") {
        isProccessor = false;
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          processor = Processor.fromJson(data);
        }
      }
      if (p.categoryName!.toLowerCase() == "psu") {
        isPsu = false;
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          psu = Psu.fromJson(data);
        }
      }
    }
    if (isGpu) {
      gpu = Gpu(productId: "", maxPowerConsumption: 0);
    }
    if (isProccessor) {
      processor = Processor(productId: "", power: 0);
    }
    if (isPsu) {
      psu = Psu(productId: "", power: 0);
    }
    selectedPower = psu.power!;
    totalPower = gpu.maxPowerConsumption! + processor.power!;
  }

  void changeIndexCategory() {
    listIndexCategory = listCategory.skip(indexCategory * 4).take(4).toList();
    if (mounted) {
      setState(() {});
    }
  }

  void autoGenPc() {
    setState(() {
      isLoading = true;
    });
    if (autoGen.preBuildId != "") {
      removeListAutoGen("processor");
      removeListAutoGen("motherboard");
      removeListAutoGen("case");
      removeListAutoGen("gpu");
      removeListAutoGen("ram");
      removeListAutoGen("storage");
    }
    AutoGenAPI.getListProductAutoGen(selectedPurpose, selectedPrice * 1000000)
        .then((data) {
      autoGen = data;
      listSelectedProduct.removeWhere((element) => element.categoryName!
          .toLowerCase()
          .contains(RegExp(r'processor|motherboard|case|gpu|ram|storage')));
      listSelectedCartItem.removeWhere((element) => element.categoryName!
          .toLowerCase()
          .contains(RegExp(r'processor|motherboard|case|gpu|ram|storage')));
      addListAutoGen(autoGen.motherboardSpecification!.toJson());
      addListAutoGen(autoGen.processorSpecification!.toJson());
      addListAutoGen(autoGen.caseSpecification!.toJson());
      addListAutoGen(autoGen.gpuSpecification!.toJson());
      addListAutoGen(autoGen.ramSpecification!.toJson());
      addListAutoGen(autoGen.storageSpecification!.toJson());
      updatePrice();
      updateTotalPower().then((value) {
        if (mounted) {
          setState(() {
            isChange = true;
            isLoading = false;
          });
        }
      });
    });
  }

  void addListAutoGen(Map<String, dynamic> json, {int? quantity}) {
    Product p = Product.fromJson(json);
    if (quantity != null) {
      p.quantityCart = quantity;
    }
    listSelectedProduct.add(p);
    listSelectedCartItem.add(CartItem(
      quantity: quantity ?? 1,
      productId: p.productId,
      unitPrice: p.unitPrice,
      images: p.imageLinks,
      productName: p.name,
      categoryName: p.categoryName,
    ));
  }

  void removeListAutoGen(String category) {
    listSelectedProduct.removeWhere(
      (element) => element.categoryName!.toLowerCase() == category,
    );
    listSelectedCartItem.removeWhere(
      (element) => element.categoryName!.toLowerCase() == category,
    );
  }

  Future<void> saveUserPC() async {
    setState(() {
      isLoading = true;
    });
    bool isProccessor = true;
    bool isMotherboard = true;
    bool isCpuCooler = true;
    bool isCase = true;
    bool isGpu = true;
    bool isPsu = true;
    bool isRam = true;
    bool isStorage = true;
    bool isCaseCooler = true;
    bool isMonitor = true;
    UserPC newUserPc = widget.userPC;
    Product ramProduct = Product();
    Product storageProduct = Product();
    for (Product p in listSelectedProduct) {
      if (p.categoryName!.toLowerCase() == "processor") {
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          Processor newProcessor = Processor.fromJson(data);
          newUserPc.processorId = newProcessor.productId;
          isProccessor = false;
        }
      }
      if (p.categoryName!.toLowerCase() == "motherboard") {
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          Motherboard newMotherboard = Motherboard.fromJson(data);
          newUserPc.motherboardId = newMotherboard.productId;
          isMotherboard = false;
        }
      }
      if (p.categoryName!.toLowerCase() == "cooler cpu") {
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          CpuCooler newCpuCooler = CpuCooler.fromJson(data);
          newUserPc.cpuCoolerId = newCpuCooler.productId;
          isCpuCooler = false;
        }
      }
      if (p.categoryName!.toLowerCase() == "case") {
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          Case newCase = Case.fromJson(data);
          newUserPc.caseId = newCase.productId;
          isCase = false;
        }
      }
      if (p.categoryName!.toLowerCase() == "gpu") {
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          Gpu newGpu = Gpu.fromJson(data);
          newUserPc.gpuId = newGpu.productId;
          isGpu = false;
        }
      }
      if (p.categoryName!.toLowerCase() == "psu") {
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          Psu newPsu = Psu.fromJson(data);
          newUserPc.psuId = newPsu.productId;
          isPsu = false;
        }
      }
      if (p.categoryName!.toLowerCase() == "ram") {
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          ramProduct = p;
          Ram newRam = Ram.fromJson(data);
          newUserPc.ramId = newRam.productId;
          isRam = false;
        }
      }
      if (p.categoryName!.toLowerCase() == "storage") {
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          storageProduct = p;
          Storage newStorage = Storage.fromJson(data);
          newUserPc.storageId = newStorage.productId;
          isStorage = false;
        }
      }
      if (p.categoryName!.toLowerCase() == "fan") {
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          CaseCooler newCaseCooler = CaseCooler.fromJson(data);
          newUserPc.caseCoolerId = newCaseCooler.productId;
          isCaseCooler = false;
        }
      }
      if (p.categoryName!.toLowerCase() == "monitor") {
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          Monitor newMonitor = Monitor.fromJson(data);
          newUserPc.monitorId = newMonitor.productId;
          isMonitor = false;
        }
      }
    }
    if (isProccessor) {
      newUserPc.processorId = null;
    }
    if (isMotherboard) {
      newUserPc.motherboardId = null;
    }
    if (isCpuCooler) {
      newUserPc.cpuCoolerId = null;
    }
    if (isCase) {
      newUserPc.caseId = null;
    }
    if (isGpu) {
      newUserPc.gpuId = null;
    }
    if (isPsu) {
      newUserPc.psuId = null;
    }
    if (isRam) {
      newUserPc.ramId = null;
    } else {
      newUserPc.ramQuantity = ramProduct.quantityCart ?? 1;
    }
    if (isStorage) {
      newUserPc.storageId = null;
    } else {
      newUserPc.storageQuantity = storageProduct.quantityCart ?? 1;
    }
    if (isCaseCooler) {
      newUserPc.caseCoolerId = null;
    }
    if (isMonitor) {
      newUserPc.monitorId = null;
    }
    PCBuilderAPI.addNewPC(newUserPc).then((result) {
      if (result) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
          showDialogAddNewPcSuccess(context).then((value) {
            isChange = false;
          });
        }
      }
    });
  }

  bool isChange = false;
  Future<void> _showDialogSave() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save ?'),
          content: const Text('Do you want to save this build ?'),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Text('No',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                saveUserPC().then((value) {
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Yes',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }

  bool checkRequiredPart() {
    bool motherboardExist = false;
    bool processorExist = false;
    bool psuExist = false;
    bool ramExist = false;
    bool storageExist = false;
    bool caseExist = false;
    bool gpuExist = false;
    bool coolerCpuExist = false;
    bool fanExist = false;
    for (CartItem element in listSelectedCartItem) {
      if (element.categoryName!.toLowerCase().contains("motherboard")) {
        motherboardExist = true;
      }
      if (element.categoryName!.toLowerCase().contains("processor")) {
        processorExist = true;
      }
      if (element.categoryName!.toLowerCase().contains("psu")) {
        psuExist = true;
      }
      if (element.categoryName!.toLowerCase().contains("ram")) {
        ramExist = true;
      }
      if (element.categoryName!.toLowerCase().contains("storage")) {
        storageExist = true;
      }
      if (element.categoryName!.toLowerCase().contains("case")) {
        caseExist = true;
      }
      if (element.categoryName!.toLowerCase().contains("gpu")) {
        gpuExist = true;
      }
      if (element.categoryName!.toLowerCase().contains("cooler cpu")) {
        coolerCpuExist = true;
      }
      if (element.categoryName!.toLowerCase().contains("fan")) {
        fanExist = true;
      }
    }
    return motherboardExist &&
        processorExist &&
        psuExist &&
        ramExist &&
        storageExist &&
        caseExist &&
        gpuExist &&
        coolerCpuExist &&
        fanExist;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                if (indexCategory == 0) {
                  if (isChange) {
                    _showDialogSave().then((value) => Navigator.pop(context));
                  } else {
                    Navigator.pop(context);
                  }
                } else {
                  indexCategory = indexCategory - 1;
                  changeIndexCategory();
                }
                setState(() {
                  isLoading = false;
                });
              },
              child: const Icon(Icons.arrow_back),
            ),
            title: Text(
              "Build PC Configuration",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            actions: [
              GestureDetector(
                onTap: saveUserPC,
                child: Container(
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.transparent,
                  child: const Icon(
                    Icons.save,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  color: const Color(0xfff6f6f6),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      ...List.generate(
                        listIndexCategory.length,
                        (index) => BuildPCCard(
                          category: listIndexCategory[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChooseDeviceScreen(
                                  category: listIndexCategory[index],
                                  listSelectedProduct: listSelectedProduct,
                                  estimatePower: totalPower,
                                ),
                              ),
                            ).then((product) {
                              if (product != null) {
                                isChange = true;
                                setState(() {
                                  isLoading = true;
                                });
                                Product selectedProduct = product;
                                listSelectedProduct.add(selectedProduct);
                                listSelectedCartItem.add(CartItem(
                                  quantity: selectedProduct.quantityCart ?? 1,
                                  productId: selectedProduct.productId,
                                  unitPrice: selectedProduct.unitPrice,
                                  images: selectedProduct.imageLinks,
                                  productName: selectedProduct.name,
                                  categoryName: selectedProduct.categoryName,
                                ));
                                updatePrice();
                                updateTotalPower().then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (mounted) {}
                                });
                              }
                            });
                          },
                          onTapEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChooseDeviceScreen(
                                  category: listIndexCategory[index],
                                  listSelectedProduct: listSelectedProduct,
                                  estimatePower: totalPower,
                                ),
                              ),
                            ).then((product) {
                              if (product != null) {
                                isChange = true;
                                setState(() {
                                  isLoading = true;
                                });
                                Product oldProduct =
                                    listSelectedProduct.firstWhere(
                                  (element) => element.categoryName!
                                      .toLowerCase()
                                      .contains(listIndexCategory[index]
                                          .name!
                                          .toLowerCase()),
                                );
                                listSelectedCartItem.removeWhere((element) =>
                                    element.productId == oldProduct.productId);
                                listSelectedProduct.removeWhere(
                                  (element) => element == oldProduct,
                                );
                                Product selectedProduct = product;
                                listSelectedProduct.add(selectedProduct);
                                listSelectedCartItem.add(CartItem(
                                  quantity: selectedProduct.quantityCart ?? 1,
                                  productId: selectedProduct.productId,
                                  unitPrice: selectedProduct.unitPrice,
                                  images: selectedProduct.imageLinks,
                                  productName: selectedProduct.name,
                                  categoryName: selectedProduct.categoryName,
                                ));
                                updatePrice();
                                updateTotalPower().then((value) {
                                  if (mounted) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                });
                              }
                            });
                          },
                          onTapDelete: () {
                            isChange = true;
                            setState(() {
                              isLoading = true;
                            });
                            Product oldProduct = listSelectedProduct.firstWhere(
                              (element) => element.categoryName!
                                  .toLowerCase()
                                  .contains(listIndexCategory[index]
                                      .name!
                                      .toLowerCase()),
                            );
                            listSelectedProduct.removeWhere(
                              (element) => element == oldProduct,
                            );
                            listSelectedCartItem.removeWhere(
                              (element) =>
                                  element.productId == oldProduct.productId,
                            );
                            updatePrice();
                            updateTotalPower().then((value) {
                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            });
                          },
                          cartItem: listSelectedCartItem.firstWhere(
                              (element) => element.categoryName!
                                  .toLowerCase()
                                  .contains(listIndexCategory[index]
                                      .name!
                                      .toLowerCase()),
                              orElse: () => CartItem(productId: "")),
                          onTapPlus: (productId) {
                            listSelectedCartItem.map((element) {
                              if (element.productId == productId) {
                                element.quantity = element.quantity! + 1;
                              }
                            }).toList();
                            updatePrice();
                            updateTotalPower().then((value) {
                              if (mounted) {
                                setState(() {});
                              }
                            });
                          },
                          onTapMinus: (productId) {
                            listSelectedCartItem.map((element) {
                              if (element.productId == productId &&
                                  element.quantity! > 1) {
                                element.quantity = element.quantity! - 1;
                              }
                            }).toList();
                            updatePrice();
                            updateTotalPower().then((value) {
                              if (mounted) {
                                setState(() {});
                              }
                            });
                          },
                          onTapProduct: () {
                            Navigator.pushNamed(
                              context,
                              DetailsScreen.routeName,
                              arguments: {
                                "product": listSelectedProduct.firstWhere(
                                    (element) => element.categoryName!
                                        .toLowerCase()
                                        .contains(listIndexCategory[index]
                                            .name!
                                            .toLowerCase())),
                                "isBuildPC": true,
                                "isView": true,
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
                    child: const Text('Auto-Build PC Configuration'),
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
                            onTap: autoGenPc,
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(10, 8, 16, 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: kPrimaryColor,
                              ),
                              child: const Text(
                                "Generate",
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
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Consumed Watt:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${totalPower}W",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: totalPower < selectedPower
                                ? Colors.green
                                : totalPower < selectedPower + 50
                                    ? Colors.orange
                                    : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Current PSU's Watt:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${selectedPower}W",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    if (indexCategory == totalPage - 1) ...[
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${formatCurrency(price).replaceAll(".", ",")}đ",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ] else ...[
                      const SizedBox(height: 10),
                    ],
                    GestureDetector(
                      onTap: () {
                        if (indexCategory == totalPage - 1) {
                          if (listSelectedCartItem.isNotEmpty) {
                            if (checkRequiredPart()) {
                              saveUserPC().then((value) {
                                CartAPI.addCartItemBuildPc(
                                        widget.userPC.userPcBuildId ?? "")
                                    .then((value) {
                                  CartAPI.getUserCart().then((value) {
                                    if (mounted) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      showDialogAddToCartSuccess(context)
                                          .then((value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const InitScreen(initIndex: 0),
                                          ),
                                        );
                                      });
                                    }
                                  });
                                });
                              });
                            } else {
                              showDialogRequiredPart(context);
                            }
                          }
                        } else {
                          indexCategory++;
                          changeIndexCategory();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(10, 8, 16, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: kPrimaryColor,
                        ),
                        child: Text(
                          indexCategory == totalPage - 1
                              ? "Add To Cart"
                              : "Continue",
                          style: const TextStyle(
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
        isLoading ? const LoadingScreen() : Container(),
      ],
    );
  }
}
