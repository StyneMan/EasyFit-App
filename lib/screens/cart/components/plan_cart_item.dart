import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:easyfit_app/model/mealplan/mealmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class PlanCartItem extends StatefulWidget {
  final String day;
  var data;
  PlanCartItem({
    Key? key,
    this.data,
    required this.day,
  }) : super(key: key);

  @override
  State<PlanCartItem> createState() => _PlanCartItemState();
}

class _PlanCartItemState extends State<PlanCartItem> {
  final _controller = Get.find<StateController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.14,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Constants.accentColor,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Center(
              child: Image.network(
                '${widget.data['image']}',
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  "assets/images/placeholder.png",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.21,
                ),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.21,
              ),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.48,
                        child: TextPoppins(
                      text: "${widget.data["name"]}",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    )),
                    Text(
                      '${widget.data['id']}',
                      style: const TextStyle(
                        color: Color(0xFFBEC3D5),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        '${Constants.nairaSign(context).currencySymbol}${Constants.formatMoney(widget.data["price"])}'),
                    InkWell(
                      onTap: () {
                        _deleteItem(widget.day);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: Constants.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _deleteItem(var day) {
    switch (day) {
      case "Monday":
        _controller.monCartList.value.remove(widget.data);
        break;
      case "Tuesday":
        _controller.tueCartList.value.remove(widget.data);
        break;
      case "Wednesday":
        _controller.wedCartList.value.remove(widget.data);
        break;
      case "Thursday":
        _controller.thuCartList.value.remove(widget.data);
        break;
      case "Friday":
        _controller.friCartList.value.remove(widget.data);
        break;
      case "Saturday":
        _controller.satCartList.value.remove(widget.data);
        break;
      case "Sunday":
        _controller.sunCartList.value.remove(widget.data);
        break;
      default:
    }
    // Plan.fromJson(_controller.planSetup).meals!.remove(widget.data);
  }
}
