import 'package:flutter/material.dart';
import 'package:new_project/register_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _fetchedData = [];
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      setState(() {
        _fetchedData = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
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
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Fixed Padding for Card
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
              ),
              // Login Card
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: email,
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
                        SizedBox(height: 20),
                        TextFormField(
                          controller: password,
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
                              return 'Please enter your feedback';
                            } else if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Login successful!')),
                              );
                              // Additional submission logic here
                            }
                          },
                          child: const Text('Login'),
                          // onPressed: () {},
                          // style: ElevatedButton.styleFrom(
                          //   backgroundColor: Colors.blueAccent,
                          //   padding: EdgeInsets.symmetric(
                          //     horizontal: 50,
                          //     vertical: 15,
                          //   ),
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          // ),
                          // child: Text(
                          //   "Login",
                          //   style: TextStyle(fontSize: 18, color: Colors.white),
                          // ),
                        ),
                        // ElevatedButton(
                        //   onPressed: fetchData,
                        //   child: const Text('Fetch Data'),
                        // ),
                        // const SizedBox(height: 20),
                        // Expanded(
                        //   child: ListView.builder(
                        //     itemCount: _fetchedData.length,
                        //     itemBuilder: (context, index) {
                        //       return ListTile(
                        //         title: Text(_fetchedData[index]['title']),
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Other login options
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: Text(
                  "------ or login with ------",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(height: 10),

              // Google Login Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(15),
                  backgroundColor: Colors.white,
                  elevation: 5,
                ),
                child: Icon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
