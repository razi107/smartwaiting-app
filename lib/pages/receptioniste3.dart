import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Receptioniste3 extends StatefulWidget {
  const Receptioniste3({super.key});

  @override
  State<Receptioniste3> createState() => _Receptioniste3State();
}

class _Receptioniste3State extends State<Receptioniste3> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waiting Room'),
        ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final user_id = user['userId'];
                  final queue_position = user['queue1_Position'];
                  final ticket_number = user['ticket1_Number'];
                  return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("User ID: ${user_id.toString()}"),
                          Text("Ticket Number: ${ticket_number.toString()}"),
                          Text("Queue Position: ${queue_position.toString()}"),
                        ],
                      ));
                },
              ),
            ),
            // Align the button to the bottom-right corner
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.purple),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                      ),
                    ),
                    onPressed: fetchUsers,
                    child: Text(
                      "Patients",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  // Add your second button here
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.purple),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // Add onPressed logic here
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void fetchUsers() async {
    print('fetchUsers called');
    const url = 'http://192.168.2.165:8080/api/Queue1/vservice3';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json;
    });
    print('fetchUsers completed');
  }

  void moveToNext() async {
    final url = Uri.parse('http://192.168.2.165:8080/api/Queue1/next3');
    final response = await http.post(
      url,
    );

    if (response.statusCode == 200) {
      print('Success: ${response.body}');
    } else {
      print('Failed: ${response.statusCode}');
    }
  }
}
