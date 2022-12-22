import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:easyfit_app/screens/menu/menu_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shimmer/shimmer.dart';

import 'menu_card.dart';

class ListComponent extends StatefulWidget {
  final PreferenceManager manager;
  const ListComponent({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  State<ListComponent> createState() => _ListComponentState();
}

class _ListComponentState extends State<ListComponent> {
  final _searchController = TextEditingController();
  final _controller = Get.find<StateController>();

  var _filtered = [];

  @override
  void initState() {
    super.initState();
    if (_controller.menus.value.isNotEmpty) {
      setState(() {
        _filtered = _controller.menus.value;
      });
    }
  }

  _onChanged(String val) {
    if (_searchController.text.isNotEmpty) {
      var filt = _controller.menus.value.where(
        (element) => element['name'].toLowerCase().contains(
              val.toLowerCase(),
            ),
      );
      setState(() {
        _filtered = filt.toList();
      });
    } else {
      setState(() {
        _filtered = _controller.menus.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 18) / 2.5;
    final double itemWidth = size.width / 2;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                gapPadding: 2.0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                gapPadding: 1.0,
              ),
              prefixIcon: Icon(CupertinoIcons.search),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                gapPadding: 1.0,
              ),
              filled: false,
              hintText: 'Search meals',
            ),
            keyboardType: TextInputType.name,
            controller: _searchController,
            onChanged: (val) {
              _onChanged(val);
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          _controller.menus.value.isEmpty
              ? Shimmer.fromColors(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: (itemHeight / itemHeight),
                    ),
                    itemBuilder: (context, index) => Card(
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        height: 210,
                        width: MediaQuery.of(context).size.width * 0.42,
                      ),
                    ),
                  ),
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: (itemHeight / itemHeight),
                  ),
                  itemBuilder: (context, index) => TextButton(
                    onPressed: () {
                      pushNewScreen(
                        context,
                        screen: MenuDetails(
                          title: _filtered[index]['name'],
                          manager: widget.manager,
                        ),
                      );
                    },
                    child: MenuCard(
                      data: _filtered[index],
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0.0),
                    ),
                  ),
                  itemCount: _filtered.length,
                ),
          const SizedBox(
            height: 24.0,
          ),
        ],
      ),
    );
  }
}
