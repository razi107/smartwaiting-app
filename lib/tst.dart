import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Receptioniste1 extends StatefulWidget {
  const Receptioniste1({super.key});

  @override
  State<Receptioniste1> createState() => _Receptioniste1State();
}

class _Receptioniste1State extends State<Receptioniste1> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des receptionistes'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final receptionnisteId = user['receptionnisteId'];
                  final receptionnistename = user['receptionnistename'];
                  final role = user['role'];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("receptionniste ID: ${receptionnisteId.toString()}"),
                        Text("receptionniste name: ${receptionnistename.toString()}"),
                        Text("role: ${role.toString()}"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteReceptionist(receptionnisteId),
                    ),
                  );
                },
              ),
            ),
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
                      "Refresh",
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
    const url = 'http://192.168.2.165:8080/api/Receptionniste';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json;
    });
    print('fetchUsers completed');
  }

  void deleteReceptionist(int id) async {
    final url = Uri.parse('http://192.168.2.165:8080/api/Receptionniste/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Success: ${response.body}');
      setState(() {
        users.removeWhere((user) => user['receptionnisteId'] == id);
      });
    } else {
      print('Failed: ${response.statusCode}');
    }
  }
}
