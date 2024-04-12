import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

Future<void> showDialogRegisterSuccess(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Icon(Icons.check_circle_outline,
            size: 50, color: Colors.green),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Sign Up Successfully')],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Text("Confirm",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.w600)),
          ),
        ],
      );
    },
  );
}

Future<void> showDialogAddToCartSuccess(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Icon(Icons.check_circle_outline,
            size: 50, color: Colors.green),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Add To Cart Successfully!')],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Text("Confirm",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.w600)),
          ),
        ],
      );
    },
  );
}

Future<void> showDialogDeleteCartItemSuccess(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Icon(Icons.check_circle_outline,
            size: 50, color: Colors.green),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Delete Successfully')],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Text("Confirm",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.w600)),
          ),
        ],
      );
    },
  );
}

Future<void> showDialogAddNewPcSuccess(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Icon(Icons.check_circle_outline,
            size: 50, color: Colors.green),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('PC Build Save Successfully')],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Text("Confirm",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.w600)),
          ),
        ],
      );
    },
  );
}

Future<void> showDialogConfirmAddRam(
    BuildContext context, Function() onTap) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Thêm linh kiện ?'),
        content: const Text(
            'MotherBoard này có 4 khe RAM, Bạn có muốn thêm đủ RAM cho các khe Ram không?'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Text('Hủy',
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: onTap,
            child: const Text('Đồng ý',
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.w600)),
          ),
        ],
      );
    },
  );
}

Future<void> showDialogFillfullField(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Alert'),
        content: const Text('Please Fill All The Fields!'),
        actions: <Widget>[
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Text('Confirm',
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.w600)),
          ),
        ],
      );
    },
  );
}

Future<void> showDialogAddShippingAddressFail(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Icon(Icons.clear, size: 50, color: Colors.red),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Add New Shipping Address Failed!')],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Text("confirm",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.w600)),
          ),
        ],
      );
    },
  );
}

Future<void> showDialogAddOrderSuccess(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Icon(Icons.check_circle_outline,
            size: 50, color: Colors.green),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Checkout Sucessfully!')],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Text("Confirm",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.w600)),
          ),
        ],
      );
    },
  );
}
