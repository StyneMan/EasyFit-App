import 'package:flutter/material.dart';

import '../../../components/text_components.dart';

class MenuCard extends StatelessWidget {
  var data;
  MenuCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        color: data['color'],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              data['image'],
              width: MediaQuery.of(context).size.width * 0.275,
              fit: BoxFit.fill,
            ),
            TextPoppins(
              text: data['name'].toUpperCase(),
              fontSize: 14,
              align: TextAlign.center,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            // menu.description.isEmpty
            //     ? const SizedBox()
            //     : TextPoppins(
            //         text: menu.description,
            //         color: Colors.black,
            //         align: TextAlign.center,
            //         fontSize: 12,
            //       ),
          ],
        ),
      ),
    );
  }
}
