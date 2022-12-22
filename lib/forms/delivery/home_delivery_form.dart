import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../helper/constants/constants.dart';
import '../../helper/preference/preference_manager.dart';
import '../../screens/payment/payment_method.dart';

class HomeDeliveryForm extends StatefulWidget {
  const HomeDeliveryForm({Key? key}) : super(key: key);

  @override
  State<HomeDeliveryForm> createState() => _HomeDeliveryFormState();
}

class _HomeDeliveryFormState extends State<HomeDeliveryForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  // final _controller = Get.find<StateManager>();
  PreferenceManager? _prefManager;
  String _countryCode = "+234";

  @override
  void initState() {
    super.initState();
    _prefManager = PreferenceManager(context);
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<CartNotifier>(context);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Name',
                hintText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              controller: _nameController,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Phone Number',
                filled: true,
                prefixIcon: CountryCodePicker(
                  alignLeft: false,
                  onChanged: (val) {
                    setState(() {
                      _countryCode = val as String;
                    });
                  },
                  flagWidth: 24,
                  initialSelection: 'NG',
                  favorite: ['+234', 'NG'],
                  showCountryOnly: false,
                  showFlag: false,
                  showOnlyCountryWhenClosed: false,
                ),
              ),
              maxLength: 11,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                if (!RegExp('^(?:[+0]234)?[0-9]{10}').hasMatch(value)) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
              keyboardType: TextInputType.phone,
              controller: _phoneController,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Address',
                hintText: 'Address',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide your address';
                }
                return null;
              },
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              controller: _addressController,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Note(Optional)',
              ),
              minLines: 3,
              maxLines: 5,
              controller: _notesController,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 21.0,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                ),
              ),
              child: TextButton(
                child: const Text(
                  'PROCEED TO PAYMENT',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // cart.setHasDelivery(true);
                    // cart.setDeliveryInfo({
                    //   "customerName": _nameController.text,
                    //   "phone": _phoneController.text.startsWith("0")
                    //       ? "$_countryCode${(_phoneController.text.substring(1, _phoneController.text.length))}"
                    //       : "$_countryCode${(_phoneController.text)}",
                    //   "address": _addressController.text,
                    //   "description": _notesController.text,
                    // });

                    pushNewScreen(
                      context,
                      screen: PaymentMethod(
                        manager: _prefManager!,
                      ),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  }
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Constants.accentColor,
                  backgroundColor: Constants.primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
          ],
        ),
      ),
    );
  }
}
