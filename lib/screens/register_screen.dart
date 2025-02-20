import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_project/provider/register_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Future<void> createPost(String title, String body) async {
    final response = await http.post(
      Uri.parse('https://api.freeapi.app/api/v1/users/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "email": context.read<RegisterProvider>().email.text,
        "username": context.read<RegisterProvider>().name.text,
        // "phoneNumber": context.read<RegisterProvider>().phoneNumber.text,
        "password": context.read<RegisterProvider>().password.text,
        // "confirmPassword":
        // context.read<RegisterProvider>().confirmPassword.text,
        // "address": context.read<RegisterProvider>().address.text,
        "role": "ADMIN",
      }),
    );

    log(response.body.toString());

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      log(responseBody);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Post Created"),
              content:
                  Text("The Name of the Client is: ${responseBody['email']}"),
              actions: [
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New App"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: context.watch<RegisterProvider>().formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
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
                        if (value != context.read<RegisterProvider>().password)
                          return 'Password did not match!!';
                        return null;
                      },
                    ),
                    SizedBox(height: 5),

                    // * this elevated button use to check the validated form submission:
                    ElevatedButton(
                      onPressed: () {
                        if (context
                            .read<RegisterProvider>()
                            .formKey
                            .currentState!
                            .validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Sign-up successful!')),
                          );
                          createPost("API Call", 'Posting to API from Flutter');
                          // Additional submission logic here
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
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
