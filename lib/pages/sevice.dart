import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Service extends StatefulWidget {
  const Service({super.key});

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des services'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final service_Name = user['service_Name'];
                  final service_Id = user['service_Id'];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("service name: ${service_Name.toString()}"),
                        Text("service id: ${service_Id.toString()}"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteService(service_Id),
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
                      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 24, 51, 65)),
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
    const url = 'http://192.168.2.168:8080/api/service';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json;
    });
    print('fetchUsers completed');
  }

  void deleteService(int id) async {
    final url = Uri.parse('http://192.168.2.168:8080/api/service/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Success: ${response.body}');
      setState(() {
        users.removeWhere((user) => user['service_Id'] == id);
      });
    } else {
      print('Failed: ${response.statusCode}');
    }
  }
}
