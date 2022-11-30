import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:flutter/material.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({Key? key}) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();

  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextPoppins(text: "First name", fontSize: 14),
            TextFormField(
              controller: _fnameController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                filled: false,
                hintText: 'First name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextPoppins(text: "Last name", fontSize: 14),
            TextFormField(
              controller: _lnameController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Last name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextPoppins(text: "Email", fontSize: 14),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextPoppins(text: "Phone", fontSize: 14),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                filled: false,
                hintText: 'First name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextPoppins(text: "Address", fontSize: 14),
            TextFormField(
              controller: _addressController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Address',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            TextPoppins(text: "Landmark", fontSize: 14),
            TextFormField(
              controller: _landmarkController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Landmark',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a landmark';
                }
                return null;
              },
            ),
            TextPoppins(text: "Date of Birth", fontSize: 14),
            TextFormField(
              controller: _dobController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Landmark',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a landmark';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: Constants.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: TextPoppins(
                    text: "Save Profile",
                    fontSize: 16,
                    color: Constants.primaryColor,
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
