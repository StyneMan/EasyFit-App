class Product {
  late String name;
  late String image;
  late String description;
  late int price;
  late List<String> ingredients;
  late String calories;
  late String proteins;
  late String carbs;
  late String fat;

  Product({
    required this.fat,
    required this.name,
    required this.image,
    required this.price,
    required this.carbs,
    required this.calories,
    required this.proteins,
    required this.ingredients,
    required this.description,
  });
}

List<Product> productList = [
  Product(
    name: "Sweet corn & beef protein",
    image: "assets/images/dsc1.png",
    price: 3500,
    ingredients: ["bulgur", "wheat", "broccoli", "beef"],
    carbs: "50g",
    calories: "420",
    fat: "13g",
    proteins: "30g",
    description:
        "What a lovely food to enjoy in such a time like this! Feel the vide ritanol. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis in metus mattis, convallis arcu nec, aliquam nulla. Nullam nisl nibh, sagittis ac congue vitae, sollicitudin eget diam. Donec ut nisl eu sem lobortis lobortis at sit amet sapien. Vestibulum et velit mattis magna commodo egestas tempor vitae arcu",
  ),
  Product(
    name: "Sweet corn & beef protein",
    image: "assets/images/dsc2.png",
    price: 4000,
    carbs: "50g",
    calories: "420",
    fat: "13g",
    proteins: "30g",
    ingredients: ["bulgur", "wheat", "beef"],
    description:
        "Cras massa est, ullamcorper et erat id, imperdiet feugiat metus. Morbi vel tortor efficitur quam pulvinar posuere vel ac eros. Cras condimentum massa suscipit, euismod arcu ac, vulputate arcu. Vestibulum dignissim nibh et tellus accumsan, eget mattis dolor faucibus. Suspendisse aliquam dolor sagittis, semper metus vel, ornare est.",
  ),
  Product(
    name: "Sweet corn & beef protein",
    image: "assets/images/food_item1.png",
    price: 35000,
    ingredients: ["bulgur", "wheat", "broccoli", "beef"],
    carbs: "50g",
    calories: "420",
    fat: "13g",
    proteins: "30g",
    description:
        "Vestibulum aliquam molestie sollicitudin. Sed scelerisque fringilla est vel gravida. Quisque nec nisl placerat, elementum mi sed, molestie quam. Donec eleifend orci ex, sed dignissim tortor tempus non. Morbi tempus vehicula libero, nec semper est elementum id. Praesent viverra a magna eget tincidunt. Sed sapien eros, volutpat ut urna efficitur, placerat sodales dolor.",
  ),
  Product(
    name: "Sweet corn & beef protein",
    image: "assets/images/dsc4.png",
    price: 5000,
    ingredients: ["bulgur", "wheat", "broccoli", "beef"],
    carbs: "50g",
    calories: "420",
    fat: "13g",
    proteins: "30g",
    description:
        "What a lovely food to enjoy in such a time like this! Feel the vide ritanol.",
  ),
  Product(
    name: "Sweet corn & beef protein",
    image: "assets/images/dsc1.png",
    price: 5000,
    ingredients: ["bulgur", "wheat", "broccoli", "beef"],
    carbs: "50g",
    calories: "420",
    fat: "13g",
    proteins: "30g",
    description:
        "Suspendisse placerat justo vel tincidunt elementum. Fusce non nisl nec arcu commodo tristique. Pellentesque est augue, dictum non ultrices et, viverra non ex. Curabitur volutpat placerat justo in sagittis. Integer at metus elementum, iaculis ligula semper, euismod ante. Nulla facilisi. Phasellus et felis at urna ultricies tempus. Proin sem nisl, pharetra ac porta ac, tincidunt non ligula.",
  ),
];
