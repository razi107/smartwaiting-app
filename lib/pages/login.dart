import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp2/Pages/home_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

Future<void> login(String name, String password, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse('http://192.168.1.114:8080/api/Receptionniste/login'),
      body: jsonEncode(
        {
          "receptionnistename": name,
          "receptionniste_mdp": password,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print('Login successful');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home_page()),
      );
    } else {
      print('Login failed');
    }
  } catch (e) {
    print(e.toString());
  }
}

class _LoginState extends State<Login> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color.fromARGB(255, 234, 238, 240), // Add your desired background color here
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 55,
                    ),
                    Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 33,
                        fontFamily: "myfont",
                        color: const Color.fromARGB(255, 24, 51, 65),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Image.asset(
                      "assets/images/smart-waiting.png",
                      width: 288,
                    ),
                    SizedBox(
                      height: 75,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[30],
                        borderRadius: BorderRadius.circular(66),
                      ),
                      width: 266,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: const Color.fromARGB(255, 24, 51, 65),
                          ),
                          hintText: "name :",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[30],
                        borderRadius: BorderRadius.circular(66),
                      ),
                      width: 266,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: passwordController,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            color: const Color.fromARGB(255, 24, 51, 65),
                            icon: Icon(
                              hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          icon: Icon(
                            Icons.lock,
                            color: const Color.fromARGB(255, 24, 51, 65),
                            size: 19,
                          ),
                          hintText: "Password :",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        login(
                          nameController.text.toString(),
                          passwordController.text.toString(),
                          context,
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 24, 51, 65),
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 106, vertical: 10),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27),
                          ),
                        ),
                      ),
                      child: Text(
                        "login",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: 111,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/login_bottom.png",
                  width: 111,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
