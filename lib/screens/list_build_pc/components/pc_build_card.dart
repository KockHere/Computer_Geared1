import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/specifications/UserPC.dart';
import 'package:shop_app/screens/list_build_pc/components/pc_build_image.dart';

class PcBuildCard extends StatelessWidget {
  const PcBuildCard({
    super.key,
    required this.userPC,
    required this.onTap,
    required this.totalPrice,
    required this.description,
    required this.onTapDelete,
  });

  final UserPC userPC;
  final Function() onTap;
  final int totalPrice;
  final String description;
  final Function() onTapDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userPC.profileName ?? "",
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: onTapDelete,
                  child: const Icon(Icons.clear),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (userPC.motherboardSpecification != null) ...[
                  PCBuildImage(
                      image: userPC.motherboardSpecification!.imageLinks),
                ],
                if (userPC.processorSpecification != null) ...[
                  PCBuildImage(
                      image: userPC.processorSpecification!.imageLinks),
                ],
                if (userPC.caseSpecification != null) ...[
                  PCBuildImage(image: userPC.caseSpecification!.imageLinks),
                ],
                if (userPC.gpuSpecification != null) ...[
                  PCBuildImage(image: userPC.gpuSpecification!.imageLinks),
                ],
                if (userPC.ramSpecification != null) ...[
                  PCBuildImage(image: userPC.ramSpecification!.imageLinks),
                ],
                if (userPC.storageSpecification != null) ...[
                  PCBuildImage(image: userPC.storageSpecification!.imageLinks),
                ],
                if (userPC.cpuCoolerSpecification != null) ...[
                  PCBuildImage(
                      image: userPC.cpuCoolerSpecification!.imageLinks),
                ],
                if (userPC.caseCoolerSpecification != null) ...[
                  PCBuildImage(
                      image: userPC.caseCoolerSpecification!.imageLinks),
                ],
                if (userPC.psuSpecification != null) ...[
                  PCBuildImage(image: userPC.psuSpecification!.imageLinks),
                ],
                if (userPC.monitorSpecification != null) ...[
                  PCBuildImage(image: userPC.monitorSpecification!.imageLinks),
                ],
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${formatCurrency(totalPrice.toDouble()).replaceAll(".", ",")}đ",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
