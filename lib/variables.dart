import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/User.dart';

String urlApi = "https://pc-geared-capstone-com.onrender.com/api/";
String urlApiAddress = "https://vapi.vnappmob.com/api/";

bool isLoading = false;

User user = User(userId: "");
Cart userCart = Cart(cartId: "");