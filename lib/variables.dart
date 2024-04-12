import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

String urlApi = "https://pc-gear-capstone-backup.onrender.com/api/";
String urlApiAddress = "https://vapi.vnappmob.com/api/";

bool isLoading = false;
final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

User user = User(userId: "");
// Cart userCart = Cart(cartId: "", productList: [], productTotal: "0");
List<Cart> listUserCart = [];
