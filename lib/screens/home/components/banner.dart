import 'package:easyfit_app/components/text_components.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  final String _imgUrl =
      "https://images.unsplash.com/photo-1543353071-10c8ba85a904?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
        child: Stack(
          children: <Widget>[
            Image.network(
              _imgUrl,
              fit: BoxFit.cover,
              width: 1000.0,
              errorBuilder: (context, err, st) =>
                  Image.asset("assets/images/placeholder.png"),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 21.0,
                  horizontal: 20.0,
                ),
                child: TextPoppins(
                  text: "Meal of the week",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
