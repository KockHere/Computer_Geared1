import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/CategoryAPI.dart';
import 'package:shop_app/controllers/ProductAPI.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/products/products_screen.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/variables.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int selectedIndex = -1;

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
      listChildCategory = listAllCategory.skip(2).take(5).toList();
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
            leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InitScreen(initIndex: 0),
                    ),
                  );
                },
                child: const Icon(Icons.arrow_back)),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              listParentCategory.isNotEmpty && selectedIndex > -1
                  ? listParentCategory[selectedIndex].name!
                  : "Product Category",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                  color: const Color(0xfff6f6f6),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: const BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                            left: selectedIndex == -1
                                ? const BorderSide(
                                    color: kPrimaryColor,
                                    width: 1,
                                  )
                                : BorderSide.none,
                          ),
                          color: selectedIndex == -1 ? Colors.white : null,
                        ),
                        child: ListTile(
                          title: const Text(
                            "PC Gear",
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                          onTap: () {
                            setState(() {
                              selectedIndex = -1;
                              listChildCategory =
                                  listAllCategory.take(5).toList();
                            });
                          },
                        ),
                      ),
                      ...List.generate(
                        listParentCategory.length,
                        (index) => Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: const BorderSide(
                                color: Colors.black,
                                width: 0.5,
                              ),
                              left: selectedIndex == index
                                  ? const BorderSide(
                                      color: kPrimaryColor,
                                      width: 1,
                                    )
                                  : BorderSide.none,
                            ),
                            color: selectedIndex == index ? Colors.white : null,
                          ),
                          child: ListTile(
                            title: Text(
                              "${listParentCategory[index].name}",
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                listChildCategory = listAllCategory
                                    .where((category) =>
                                        category.parentId ==
                                        listParentCategory[selectedIndex]
                                            .categoryId)
                                    .toList();
                                if (listChildCategory.isEmpty) {
                                  listChildCategory
                                      .add(listParentCategory[selectedIndex]);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: GridView.count(
                    childAspectRatio: 0.7,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ...List.generate(
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
                                  category: listChildCategory[index],
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
                      CategoryCard(
                        icon: "",
                        text: "All",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsScreen(
                                category: Category(
                                    name: "All PC Product", brandList: []),
                                products: listAllProduct,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
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
    super.key,
    required this.icon,
    required this.text,
    required this.press,
  });

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
            child: SizedBox(
              height: 100,
              child: icon.isEmpty
                  ? Container(
                      color: Colors.transparent,
                      alignment: Alignment.bottomCenter,
                      child: const Icon(Icons.more_horiz, color: kPrimaryColor),
                    )
                  : Image.network(
                      icon,
                      errorBuilder: (context, error, stackTrace) => Image.network(
                          "https://lh3.googleusercontent.com/icxPo1Rqyjc1XkfEpTq6NJx3p1mFclraPE3mp3uxCUDBoHXuhbq8WMGMiwE3L4czehocmdRCuSyBF9QOU4DQhz30eIjekvNm=rw"),
                    ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: icon.isEmpty ? const TextStyle(color: kPrimaryColor) : null,
          )
        ],
      ),
    );
  }
}
