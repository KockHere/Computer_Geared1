import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/AddressAPI.dart';
import 'package:shop_app/models/District.dart';
import 'package:shop_app/models/Province.dart';
import 'package:shop_app/models/Ward.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Thêm địa chỉ giao hàng",
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
                onChanged: (value) {},
                decoration: const InputDecoration(
                  labelText: "Tên người nhận",
                  hintText: "Nhập tên người nhận",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                decoration: const InputDecoration(
                  labelText: "Số điện thoại",
                  hintText: "Nhập số điện thoại",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
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
                  labelText: "Tỉnh/Thành phố",
                  hintText: "Chọn tỉnh/thành phố",
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
                  labelText: "Quận/Huyện",
                  hintText: "Chọn quận/huyện",
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
                  labelText: "Phường/Xã",
                  hintText: "Chọn phường/xã",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                decoration: const InputDecoration(
                  labelText: "Địa chỉ",
                  hintText: "Nhập địa chỉ",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Ghi chú",
                  hintText: "Nhập ghi chú",
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
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 8, 16, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: kPrimaryColor,
            ),
            child: const Text(
              "Thêm",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
