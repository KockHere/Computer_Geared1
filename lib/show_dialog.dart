import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

Future<void> showDialogRegisterSuccess(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        content: const Column(
          children: [
            Icon(Icons.check_circle_outline, size: 50, color: Colors.green),
            SizedBox(height: 8),
            Text('Đăng ký thành công'),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
            child: const Text("Xác nhận"),
          ),
        ],
      );
    },
  );
}

Future<void> showDialogAddToCartSuccess(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        content: const Column(
          children: [
            Icon(Icons.check_circle_outline, size: 50, color: Colors.green),
            SizedBox(height: 8),
            Text('Thêm vào giỏ hàng thành công'),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Xác nhận"),
          ),
        ],
      );
    },
  );
}

Future<void> showDialogDeleteCartItemSuccess(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        content: const Column(
          children: [
            Icon(Icons.check_circle_outline, size: 50, color: Colors.green),
            SizedBox(height: 8),
            Text('Xóa sản phẩm thành công'),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Xác nhận"),
          ),
        ],
      );
    },
  );
}