import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/model/menu/menumodel.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final MenuModel menu;
  const MenuCard({
    Key? key,
    required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        color: menu.color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              menu.image,
              width: MediaQuery.of(context).size.width * 0.275,
              fit: BoxFit.fill,
            ),
            TextPoppins(
              text: menu.title.toUpperCase(),
              fontSize: 14,
              align: TextAlign.center,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            menu.description.isEmpty
                ? const SizedBox()
                : TextPoppins(
                    text: menu.description,
                    color: Colors.black,
                    align: TextAlign.center,
                    fontSize: 12,
                  ),
          ],
        ),
      ),
    );
  }
}
