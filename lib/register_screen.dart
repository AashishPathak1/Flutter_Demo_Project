import 'dart:developer';

import 'package:flutter/material.dart';
// import 'login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:new_project/provider/register_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  Future<void> createPost(String title, String body) async {
    final response = await http.post(
      Uri.parse('https://api.freeapi.app/api/v1/users/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "email": "user.email233366@domain.com",
        "password": "test33@123",
        "role": "ADMIN",
        "username": "doejohn4454666"
      }),
    );

    log(response.body.toString());

    if (response.statusCode == 201) {
      // If the server returns a 201 CREATED response, then the post was successfully created.
      final responseBody = jsonDecode(response.body);
      log(responseBody);
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text("Post Created"),
      //       content: Text("The Name of the Client is: ${responseBody['name']}"),
      //       actions: [
      //         ElevatedButton(
      //           child: Text("OK"),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //       ],
      //     );
    }
    // );
    else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create post');
    }
  }

  // void _submit() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New App"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          // Text("Enter Your Personal Details:"),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 5),
                    TextFormField(
                      controller: context.watch<RegisterProvider>().name,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.blueAccent,
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Enter Your Name",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: context.watch<RegisterProvider>().email,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.blueAccent,
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Enter your Email",
                      ),
                      validator: (value) {
                        if (value == null ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Enter a valid email!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: context.watch<RegisterProvider>().phoneNumber,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.blueAccent,
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Enter your phone number",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Phone Number';
                        } else if (value.length < 10) {
                          return 'Phone number must be at least 10 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      // controller: RegisterProvider().address,
                      controller: context.watch<RegisterProvider>().address,

                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Colors.blueAccent,
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Enter your address",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the empty field!!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      // controller: RegisterProvider().password,
                      controller: context.watch<RegisterProvider>().password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.blueAccent,
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Enter your Password",
                      ),
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid password!!';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      // controller: RegisterProvider().confirmPassword,
                      controller:
                          context.watch<RegisterProvider>().confirmPassword,

                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.blueAccent,
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Confirm Password",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter the valid password!!';
                        // if (value != RegisterProvider().password.text)
                        //   return 'Password did not match!!';
                        return null;
                      },
                    ),
                    SizedBox(height: 5),

                    // * this elevated button use to check the validated form submission:
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Sign-up successful!')),
                          );
                          createPost('Flutter', 'Posting to API from Flutter');
                          // Additional submission logic here
                        }
                      },
                      child: const Text('Sign Up'),
                    ),

                    // * this elevated button's functionality is not decided yet:
                    // ElevatedButton(
                    //   onPressed: () {
                    //     // _submit();
                    //     // Navigator.push(
                    //     //   context,
                    //     //   MaterialPageRoute(builder: (context) => MyHomePage()),
                    //     // );
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.blueAccent,
                    //     padding: EdgeInsets.symmetric(
                    //       horizontal: 50,
                    //       vertical: 15,
                    //     ),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),
                    //   child: Text(
                    //     "Sign up",
                    //     style: TextStyle(fontSize: 18, color: Colors.white),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
