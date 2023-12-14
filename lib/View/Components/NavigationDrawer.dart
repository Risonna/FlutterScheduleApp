import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../State/Models/AuthorizationModel.dart';
import '../Widgets/AdminPages/AdminsTeachersPage.dart';
import '../Widgets/AdminPages/CorrectnessCheckingPage.dart';
import '../Widgets/AdminPages/DataUpload.dart';
import '../Widgets/AdminPages/ExcelUploadPage.dart';
import '../Widgets/Authorization/Login.dart';
import '../Widgets/Authorization/Registration.dart';
import '../Widgets/NavigationButtonsWidget.dart';

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
    final authorizationModel = Provider.of<AuthorizationModel>(context);
    if(authorizationModel.token != 'empty') {
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
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 52,
                  backgroundImage: NetworkImage(
                      'https://m.media-amazon.com/images/M/MV5BOTBhZDA5NjYtOTZhNy00OTE5LTljZjktMDM0NTRhZjU0MDE1XkEyXkFqcGdeQXVyMTE0MzQwMjgz._V1_.jpg'
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  authorizationModel.username,
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                Text(
                  authorizationModel.role,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      );
    }
    else{
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
                      'https://cdn0.iconfinder.com/data/icons/pixel-perfect-at-24px-volume-6/24/2131-512.png'
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Неавторизованный пользователь',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
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
                    builder: (context) => ScheduleCorrectnessWidget())),
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