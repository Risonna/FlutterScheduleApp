import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_scheduler/State/Models/AuthorizationModel.dart';
import 'package:flutter_test_scheduler/State/Models/WebSocketModel.dart';
import 'package:provider/provider.dart';

import '../../../State/Models/AdminsTeachersModel.dart';


class AdminsTeachersPage extends StatelessWidget {
  const AdminsTeachersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Изменение администраторов-преподавателей'),
          backgroundColor: Colors.orangeAccent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _AddUserForm(),
                const SizedBox(height: 20),
                _UserTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddUserForm extends StatelessWidget {
  final adminTeacherUsernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authorizationModel = Provider.of<AuthorizationModel>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Добавьте имя пользователя',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: adminTeacherUsernameController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Введите имя пользователя',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              final teacherName = adminTeacherUsernameController.text.trim().replaceAll('"', '');
              Provider.of<AdminsTeachersModel>(context, listen: false).addAdminTeacher(teacherName, authorizationModel.token);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.orangeAccent,
            ),
            child: const Text('Добавить'),
          ),

        ],
      ),
    );
  }
}

class _UserTable extends StatefulWidget {
  @override
  _UserTableState createState() => _UserTableState();
}

class _UserTableState extends State<_UserTable> {

  @override
  void initState() {
    super.initState();
    final adminsTeachersModel = Provider.of<AdminsTeachersModel>(context, listen: false);
    final webSocketProvider = Provider.of<WebSocketModel>(context, listen: false);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (adminsTeachersModel.adminsTeachers.isEmpty) {
        adminsTeachersModel.fetchAdminsTeachers();
      }
      webSocketProvider.connect(context);
    });
  }


  @override
  void dispose() {
    Provider.of<WebSocketModel>(context, listen: false).disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminsTeachersModel = Provider.of<AdminsTeachersModel>(context);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Список пользователей',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          DataTable(
            columns: const [
              DataColumn(label: Text('Имя пользователя', style: TextStyle(color: Colors.white))),
              DataColumn(label: Text('Действия', style: TextStyle(color: Colors.white))),
            ],
            rows: adminsTeachersModel.adminsTeachers.map((user) {
              return DataRow(
                cells: [
                  DataCell(Text(user, style: TextStyle(color: Colors.white))),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          adminsTeachersModel.deleteAdminTeacher(user, Provider.of<AuthorizationModel>(context, listen: false).token);
                        },
                      ),
                    ],
                  )),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}




