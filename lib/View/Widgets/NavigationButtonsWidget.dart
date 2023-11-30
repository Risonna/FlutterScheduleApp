import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter_test_scheduler/State/Models/AuthorizationModel.dart';
import 'package:flutter_test_scheduler/View/Widgets/AdminPages/AdminsTeachersPage.dart';
import 'package:flutter_test_scheduler/View/Widgets/AdminPages/DataUpload.dart';
import 'package:flutter_test_scheduler/View/Widgets/AdminPages/ExcelUploadPage.dart';
import 'package:flutter_test_scheduler/View/Widgets/Authorization/Login.dart';
import 'package:provider/provider.dart';

import 'Authorization/Registration.dart';
import 'Schedules/ScheduleCabinets.dart';
import 'Schedules/ScheduleTeachers.dart';
import 'SelectEntityWidget.dart';

class NavigationButtonsWidget extends StatelessWidget {
  NavigationButtonsWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главное меню'),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: const NavigationDrawer(),
      body: Row(
        children: [
          Expanded(
            flex: 2, // Adjust the flex value as needed
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Main Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton('Расписание преподавателей', Colors.deepOrange, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ScheduleTeachersPage(),
                        ));
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton('Расписание аудиторий', Colors.deepOrange, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScheduleCabinetsPage(),
                        ));
                      }),
                    ],
                  ),

                  // Smaller Buttons
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton('Подсчёт', Colors.orange, null),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomButton('Когда будет пара?', Colors.orange, null),
                      CustomButton('Когда нет пар?', Colors.orange, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EntitySelectionWidget(),
                        ));
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onPressed;

  const CustomButton(this.text, this.color, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 50,
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color,
          minimumSize: const Size(200, 40),
        ),
        child: Text(text),
      ),
    );
  }
}


class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context)
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Material(
      color: Colors.green.shade300,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(
              top: 24 + MediaQuery
                  .of(context)
                  .padding
                  .top,
              bottom: 24
          ),
          child: const Column(
            children: [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: NetworkImage(
                      'https://c4.wallpaperflare.com/wallpaper/847/594/457/monogatari-series-oshino-shinobu-wallpaper-preview.jpg'
                  ),
                ),
              SizedBox(height: 12),
              Text(
                'Shinobu Oshino',
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
              Text(
                'Shinobu@gmail.com',
                style: TextStyle(fontSize: 16, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    final authorizationModel = Provider.of<AuthorizationModel>(context);
    if (authorizationModel.token == 'empty') {
      return Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Домой'),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => NavigationButtonsWidget())),
            ),
            ListTile(
              leading: const Icon(Icons.account_box),
              title: const Text('Войти'),
              onTap: () =>
              {
                Navigator.pop(context),
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage()))
              },
            ),
            ListTile(
              leading: const Icon(Icons.manage_accounts),
              title: const Text('Зарегистрироваться'),
              onTap: () =>
              {
                Navigator.pop(context),
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RegisterPage()))
              },
            ),
          ],
        ),
      );
    }
    else if(authorizationModel.role == 'admin'){
      return Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Домой'),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => NavigationButtonsWidget())),
            ),
            ListTile(
              leading: const Icon(Icons.no_accounts),
              title: const Text('Выйти'),
              onTap: () => authorizationModel.logoutUser(),
            ),
            const Divider(color: Colors.black54),
            ListTile(
              leading: const Icon(Icons.document_scanner),
              title: const Text('Загрузить эксель'),
              onTap: () =>
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ExcelUploadPage())),
            ),
            ListTile(
              leading: const Icon(Icons.dataset_linked_sharp),
              title: const Text('Изменение данных'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DataUpload())),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Проверка правильности расписания'),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => NavigationButtonsWidget())),
            ),
            ListTile(
              leading: const Icon(Icons.add_box_outlined),
              title: const Text('Выдать преподавателям роль'),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AdminsTeachersPage())),
            ),
          ],
        ),
      );
    }
    else{
      return Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Домой'),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => NavigationButtonsWidget())),
            ),
            ListTile(
              leading: const Icon(Icons.no_accounts),
              title: const Text('Выйти'),
              onTap: () => authorizationModel.logoutUser(),
            ),
          ],
        ),
      );
    }
    }
}