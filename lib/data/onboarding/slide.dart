class Slides {
  late String title;
  late String desc;
  late String author;
  late String image;

  Slides({
    required this.title,
    required this.desc,
    required this.author,
    required this.image,
  });
}

List<Slides> onboardingSlides = [
  Slides(
    image: "assets/images/onboarding.png",
    title: "Maintain a healthy lifestyle.",
    desc: "The greatest wealth is health.",
    author: "– Vigil",
  ),
  Slides(
    image: "assets/images/onboarding.png",
    title: "You are what you eat.",
    desc: "The groundwork for all happiness is good health.",
    author: "– Leigh Hunt",
  ),
  Slides(
    image: "assets/images/onboarding.png",
    title: "Happiness lies, first of all, in health.",
    desc: "Prevention is better than cure.",
    author: "– Desiderius Erasmus",
  ),
];
