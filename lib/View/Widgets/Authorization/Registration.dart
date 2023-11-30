import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../State/Models/AuthorizationModel.dart';
import '../../../blogic/domain/entities/User.dart';
import '../../Components/MyButton.dart';
import '../../Components/MyTextField.dart';
import '../NavigationButtonsWidget.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  // sign user up method
// sign user up method
  void signUserUp(BuildContext context) {
    var user = User(username: usernameController.text, password: passwordController.text);
    user.passwordConfirm = passwordConfirmationController.text;
    user.email = '@abobus';

    Provider.of<AuthorizationModel>(context, listen: false).registerUser(user)
        .then((_) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => NavigationButtonsWidget(),
        ));
    })
        .catchError((error) {
      print('Error during registration: $error');
      // Handle error cases here
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Страница регистрации'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.lock,
                  color: Colors.deepOrangeAccent,
                  size: 100,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Здравствуйте! \nС нетерпением ждём вашего участия!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Имя пользователя',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Пароль',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // password confirm textfield
                MyTextField(
                  controller: passwordConfirmationController,
                  hintText: 'Повтор пароля',
                  obscureText: true,
                ),


                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  onTap: () => signUserUp(context),
                  text: 'Зарегистрироваться',
                ),

                const SizedBox(height: 50),


                // not a member? register no
              ],
            ),
          ),
        ),
      ),
    );
  }
}