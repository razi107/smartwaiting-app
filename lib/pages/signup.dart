import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({Key? key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool hidePassword = true;
  String name = '';
  String password = '';
  String role = '1';

  Future<void> signup(String name, String password, String role) async {
    var url = Uri.parse('http://192.168.1.114:8080/api/Receptionniste/Signup');
    var response = await http.post(url,
        body: jsonEncode({
          "Receptionnistename": name,
          "Receptionniste_mdp": password,
          "role": "1",
        }),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      showSuccessDialog();
      print('Inscription réussie!');
    } else {
      showFailureDialog();
      print('Échec de l\'inscription.');
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Inscription réussie"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void showFailureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Échec de l'\ inscription"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Ajouter un receptioniste",
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: "myfont",
                          color: Colors.grey[800]),
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    SvgPicture.asset(
                      "assets/icons/signup.svg",
                      height: 222,
                    ),
                    SizedBox(
                      height: 27,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[30],
                        borderRadius: BorderRadius.circular(66),
                      ),
                      width: 266,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: const Color.fromARGB(255, 24, 51, 65),
                            ),
                            hintText: "Name :",
                            border: InputBorder.none),
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[20],
                        borderRadius: BorderRadius.circular(66),
                      ),
                      width: 266,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButton(
                        value: role,
                        onChanged: (String? newvalue) {
                          setState(() {
                            role = newvalue!;
                          });
                        },
                        items: const [
                          DropdownMenuItem(value: '1', child: Text('role: 1')),
                          DropdownMenuItem(value: '2', child: Text('role: 2')),
                          DropdownMenuItem(value: '3', child: Text('role: 3')),
                        ],
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
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: const Color.fromARGB(255, 24, 51, 65),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            icon: Icon(
                              Icons.lock,
                              color: const Color.fromARGB(255, 24, 51, 65),
                              size: 19,
                            ),
                            hintText: "Password :",
                            border: InputBorder.none),
                        onChanged: (value) {
                          // Mettre à jour la valeur du mot de passe
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Appeler la fonction signup avec les valeurs actuelles du nom et du mot de passe
                        signup(name, password, role);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color.fromARGB(255, 24, 51, 65)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 89, vertical: 10)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27))),
                      ),
                      child: Text(
                        "Valider",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 33,
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
