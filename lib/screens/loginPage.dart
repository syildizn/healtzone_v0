import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/emailLoginPage.dart';
import 'package:healtzone_v0/screens/publications.dart';
import 'package:healtzone_v0/screens/widgets/myCustomButton.dart';
import 'package:healtzone_v0/services/authentication.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static String routeName = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isLoading = false; // tuşa ilk tıklamadan sonra firebaseden yanıt gelene kadar tekrar tıklanmasın diye

  //aşağıdaki fonksiyon anonim giriş işlemini yapıyor
  Future<void> _signInAnonymously() async {
    setState(() {
      isLoading = true;
    });

    final user =
    await Provider.of<Authentication>(context, listen: false).signInAnonymously();
    setState(() {
      isLoading = false;
    });

    print(user?.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Giriş Sayfası",
            style: TextStyle(fontSize: 22),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await Provider.of<Authentication>(context, listen: false)
                      .signOut();
                  print("Çıkış Yapıldı");
                },
                icon: Icon(Icons.exit_to_app))
          ]),
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
              text: 'Anonim Giriş',
              backgroundColor: Colors.greenAccent.shade200,
              onPressed:  isLoading ? null : _signInAnonymously,
              // ()  async {
              //   // Kayıt ol butonuna tıklandığında yapılacak işlemler buraya yazılır.
              //   final user =
              //       await Provider.of<Authentication>(context, listen: false)
              //           .signInAnonymously();
              //   print(user?.uid);
              // },
              svgPath: 'assets/icons/anonymous.svg',
              textColor: Colors.black, SizedBoxRange: 20.0,
            ),
            SizedBox(height: 20.0),
            MyCustomButton(
              text: 'Email İle Giriş',
              backgroundColor: Colors.blue,
              onPressed: () {
                // Giriş yap butonuna tıklandığında yapılacak işlemler buraya yazılır.
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EmailLoginPage(formValid: FormValid.login),
                  ),
                );
                print("Email giriş sayfasına yönlendirildi");
              },
              svgPath: 'assets/icons/email.svg',
              textColor: Colors.white, SizedBoxRange: 20.0,
            ),
            SizedBox(height: 20.0),
            MyCustomButton(
              text: 'Google İle Giriş',
              backgroundColor: Colors.white,
              onPressed: () {
                // Kayıt ol butonuna tıklandığında yapılacak işlemler buraya yazılır.
              },
              svgPath: 'assets/icons/google.svg',
              textColor: Colors.black, SizedBoxRange: 20.0,
            ),
            SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                // "Üyeliğiniz yok mu? Kayıt olmak için lütfen tıklayın..." metni tıklandığında yapılacak işlemler buraya yazılır.
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EmailLoginPage(formValid: FormValid.signup),
                  ),
                );

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
