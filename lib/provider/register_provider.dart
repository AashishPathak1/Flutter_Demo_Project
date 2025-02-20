import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController address = TextEditingController();

  RegisterProvider();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    phoneNumber.dispose();
    confirmPassword.dispose();
    address.dispose();
    super.dispose();
  }
}
