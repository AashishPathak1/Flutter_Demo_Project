import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController address = TextEditingController();

  RegisterProvider();
  void changeName({String? newName}) {
    if (newName != null) {
      name.text = newName;
      notifyListeners();
    }
  }

  // Dispose of controllers to free memory
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
