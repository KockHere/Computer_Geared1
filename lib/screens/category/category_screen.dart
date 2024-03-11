import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/CategoryAPI.dart';
import 'package:shop_app/controllers/ProductAPI.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/products/products_screen.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/variables.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int selectedIndex = 0;

  List<Category> listAllCategory = [];
  List<Category> listParentCategory = [];
  List<Category> listChildCategory = [];

  List<Product> listAllProduct = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    CategoryAPI.getListAllCategory().then((categories) {
      listAllCategory = categories;
      listParentCategory = listAllCategory
          .where((category) =>
              category.parentId == "6f5acf44-4542-4c5c-be43-6a71b150f752")
          .toList();
      listChildCategory = listAllCategory
          .where((category) =>
              category.parentId == listParentCategory[selectedIndex].categoryId)
          .toList();
      if (listChildCategory.isEmpty && listParentCategory.isNotEmpty) {
        listChildCategory.add(listParentCategory[selectedIndex]);
      }
      ProductAPI.getListProduct().then((products) {
        listAllProduct = products;
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              listParentCategory.isNotEmpty
                  ? listParentCategory[selectedIndex].name!
                  : "Loại sản phẩm",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: const Color(0xfff6f6f6),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  listChildCategory.length,
                  (index) => CategoryCard(
                    icon: listChildCategory[index].image != ""
                        ? listChildCategory[index].image!
                        : "https://lh3.googleusercontent.com/2701fTP9z5BT0Jn40Jc6qiXij824-WxAM6wavqFHvf7tp5WLkpJwh7Kn6TsesgatH_avVdZMkVtu8qfpZ3jfkWDsIeXYKg-L=rw",
                    text: listChildCategory[index].name ?? "",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsScreen(
                            title: listChildCategory[index].name ?? "",
                            products: listAllProduct
                                .where((element) => element.categoryName!
                                    .toLowerCase()
                                    .contains(listChildCategory[index]
                                        .name!
                                        .toLowerCase()))
                                .toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  color: kPrimaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: const Text(
                    "Loại sản phẩm",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...List.generate(
                  listParentCategory.length,
                  (index) => ListTile(
                    title: Row(
                      children: [
                        SizedBox(
                          height: 56,
                          width: 56,
                          child: Image.network(
                            listParentCategory[index].image != ""
                                ? listParentCategory[index].image!
                                : "https://lh3.googleusercontent.com/2701fTP9z5BT0Jn40Jc6qiXij824-WxAM6wavqFHvf7tp5WLkpJwh7Kn6TsesgatH_avVdZMkVtu8qfpZ3jfkWDsIeXYKg-L=rw",
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "${listParentCategory[index].name}",
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    selected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        listChildCategory = listAllCategory
                            .where((category) =>
                                category.parentId ==
                                listParentCategory[selectedIndex].categoryId)
                            .toList();
                        if (listChildCategory.isEmpty) {
                          listChildCategory
                              .add(listParentCategory[selectedIndex]);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        isLoading ? const LoadingScreen() : Container(),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 80,
            child: Image.network(icon),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
