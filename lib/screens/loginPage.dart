import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/publications.dart';
import 'package:healtzone_v0/screens/widgets/myCustomButton.dart';

class LoginPage extends StatelessWidget {
  static String routeName = "LoginPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Sayfası", style: TextStyle(fontSize: 22)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                child: Text(
                  "Hoş geldiniz, "
                  "lütfen giriş yapmak istediğiniz yöntemi seçiniz",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            SizedBox(height: 30.0),
            MyCustomButton(
              text: 'Email İle Giriş',
              backgroundColor: Colors.blue,
              onPressed: () {
                // Giriş yap butonuna tıklandığında yapılacak işlemler buraya yazılır.
              },
              svgPath: 'assets/icons/email.svg',
              textColor: Colors.white,
            ),
            SizedBox(height: 20.0),
            MyCustomButton(
              text: 'Google İle Giriş',
              backgroundColor: Colors.white,
              onPressed: () {
                // Kayıt ol butonuna tıklandığında yapılacak işlemler buraya yazılır.
              },
              svgPath: 'assets/icons/google.svg',
              textColor: Colors.black,
            ),
            SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                // "Üyeliğiniz yok mu? Kayıt olmak için lütfen tıklayın..." metni tıklandığında yapılacak işlemler buraya yazılır.
                Navigator.pushNamed(context, PublicationsScreen.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Email ile kayıt olmak için tıklayın...",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
