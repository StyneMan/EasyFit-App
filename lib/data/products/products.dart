class Product {
  late String name;
  late String image;
  late String description;
  late int price;

  Product(
      {required this.name,
      required this.image,
      required this.price,
      required this.description});
}

List<Product> productList = [
  Product(
    name: "Sweet corn & beef protein",
    image: "assets/images/food_item1.png",
    price: 5000,
    description:
        "What a lovely food to enjoy in such a time like this! Feel the vide ritanol.",
  ),
  Product(
    name: "Sweet corn & beef protein",
    image: "assets/images/food_item1.png",
    price: 5000,
    description:
        "What a lovely food to enjoy in such a time like this! Feel the vide ritanol.",
  ),
  Product(
    name: "Sweet corn & beef protein",
    image: "assets/images/food_item3.png",
    price: 5000,
    description:
        "What a lovely food to enjoy in such a time like this! Feel the vide ritanol.",
  ),
  Product(
    name: "Sweet corn & beef protein",
    image: "assets/images/food_item1.png",
    price: 5000,
    description:
        "What a lovely food to enjoy in such a time like this! Feel the vide ritanol.",
  ),
  Product(
    name: "Sweet corn & beef protein",
    image: "assets/images/food_item3.png",
    price: 5000,
    description:
        "What a lovely food to enjoy in such a time like this! Feel the vide ritanol.",
  ),
];
