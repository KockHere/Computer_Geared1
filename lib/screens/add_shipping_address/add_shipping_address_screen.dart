import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/AddressAPI.dart';
import 'package:shop_app/controllers/ShippingAddressAPI.dart';
import 'package:shop_app/models/District.dart';
import 'package:shop_app/models/Province.dart';
import 'package:shop_app/models/ShippingAddress.dart';
import 'package:shop_app/models/Ward.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/show_dialog.dart';
import 'package:shop_app/variables.dart';

class AddShippingAddressScreen extends StatefulWidget {
  const AddShippingAddressScreen({super.key});

  @override
  State<AddShippingAddressScreen> createState() =>
      _AddShippingAddressScreenState();
}

class _AddShippingAddressScreenState extends State<AddShippingAddressScreen> {
  List<Province> listProvince = [];
  List<District> listDistrict = [];
  List<Ward> listWard = [];

  Province? selectedProvince;
  District? selectedDistrict;
  Ward? selectedWard;

  TextEditingController recipientName = TextEditingController();
  TextEditingController recipientPhone = TextEditingController();
  TextEditingController streetAddress = TextEditingController();

  @override
  void initState() {
    super.initState();
    AddressAPI.getListProvince().then((data) {
      listProvince = data;
      if (mounted) {
        setState(() {});
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
              "Add Shipping Address",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: recipientName,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      labelText: "Name",
                      hintText: "Enter",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: recipientPhone,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      hintText: "Enter",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<Province>(
                    menuMaxHeight: 500,
                    value: selectedProvince,
                    items: listProvince
                        .map<DropdownMenuItem<Province>>((Province province) {
                      return DropdownMenuItem<Province>(
                        value: province,
                        child: Text(province.provinceName ?? ""),
                      );
                    }).toList(),
                    onChanged: (province) {
                      selectedProvince = province;
                      selectedDistrict = null;
                      selectedWard = null;
                      listWard = [];
                      AddressAPI.getListDistrict(province!.provinceId ?? "")
                          .then((data) {
                        listDistrict = data;
                        if (mounted) {
                          setState(() {});
                        }
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: "Province/City",
                      hintText: "Select",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<District>(
                    menuMaxHeight: 500,
                    value: selectedDistrict,
                    items: listDistrict
                        .map<DropdownMenuItem<District>>((District district) {
                      return DropdownMenuItem<District>(
                        value: district,
                        child: Text(district.districtName ?? ""),
                      );
                    }).toList(),
                    onChanged: (district) {
                      selectedDistrict = district;
                      selectedWard = null;
                      AddressAPI.getListWard(district!.districtId ?? "")
                          .then((data) {
                        listWard = data;
                        if (mounted) {
                          setState(() {});
                        }
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: "District",
                      hintText: "Select",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<Ward>(
                    menuMaxHeight: 500,
                    value: selectedWard,
                    items: listWard.map<DropdownMenuItem<Ward>>((Ward ward) {
                      return DropdownMenuItem<Ward>(
                        value: ward,
                        child: Text(ward.wardName ?? ""),
                      );
                    }).toList(),
                    onChanged: (ward) {
                      selectedWard = ward;
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      labelText: "Ward",
                      hintText: "Select",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: streetAddress,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      labelText: "Street Address",
                      hintText: "Enter",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 90,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xfff6f6f6)),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () {
                if (recipientName.text != "" &&
                    recipientPhone.text != "" &&
                    selectedProvince != null &&
                    selectedDistrict != null &&
                    selectedWard != null &&
                    streetAddress.text != "") {
                  setState(() {
                    isLoading = true;
                  });
                  ShippingAddressAPI.createShippingAddress(
                    ShippingAddress(
                      recipientName: recipientName.text,
                      recipientPhone: recipientPhone.text,
                      city: selectedProvince!.provinceName ?? "",
                      district: selectedDistrict!.districtName ?? "",
                      ward: selectedWard!.wardName ?? "",
                      streetAddress: streetAddress.text,
                    ),
                  ).then((result) {
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                    if (result) {
                      Navigator.pop(context);
                    } else {
                      showDialogAddShippingAddressFail(context);
                    }
                  });
                } else {
                  showDialogFillfullField(context);
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
                child: const Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
        isLoading ? const LoadingScreen() : Container(),
      ],
    );
  }
}
