import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/widgets/myCustomButton.dart';

//enum operatörü bir nevi if gibi, kontrol yapıp giriş sayfası ya da kayıt ol sayfası gösteriyor.
enum FormValid{login,signup}

class EmailLoginPage extends StatefulWidget {

  static String routeName = "EmailLoginPage";

   FormValid formValid;

  EmailLoginPage({required this.formValid});

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {

  bool _isObscure = true;

  FormValid? formValid= FormValid.login;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });}

  @override
  Widget build(BuildContext context) {
    return widget.formValid == FormValid.login? buildLogin():buildSignup();
  }

  Widget buildLogin() {
    return Scaffold(
    appBar: AppBar(
      title: Text("Lütfen Giriş Yapınız"),
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "E-posta",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: "Şifre",
                suffixIcon: GestureDetector(
                  onTap: _togglePasswordVisibility,
                  child: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: _isObscure,
            ),
            SizedBox(height: 24.0),
            MyCustomButton(
              text: 'Giriş Yap',
              backgroundColor: Colors.amberAccent,
              onPressed: () {
                // E-posta ve şifre doğrulamasını yapma işlemi burada gerçekleşir.
                // Eğer doğrulama başarılı ise ilgili işlemler yapılır, aksi halde hata gösterilir.
              },
               svgPath: 'assets/icons/login.svg', textColor: Colors.black,
            ),
            SizedBox(height: 26.0),
            InkWell(
              onTap: () {
                // "Üyeliğiniz yok mu? Kayıt olmak için tıklayın..." metni tıklandığında yapılacak işlemler buraya yazılır.
                setState(() {
                  widget.formValid= FormValid.signup;
                });
              },
              child: Text(
                "Üyeliğiniz yok mu? Kayıt olmak için tıklayın...",
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.underline,fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
  Widget buildSignup() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lütfen Giriş Yapınız"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "E-posta",
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: "Şifre",
                  suffixIcon: GestureDetector(
                    onTap: _togglePasswordVisibility,
                    child: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                obscureText: _isObscure,
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: "Şifreyi Doğrula",
                  suffixIcon: GestureDetector(
                    onTap: _togglePasswordVisibility,
                    child: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                obscureText: _isObscure,
              ),
              SizedBox(height: 24.0),
              MyCustomButton(
                text: 'Kayıt Ol',
                backgroundColor: Colors.amberAccent,
                onPressed: () {
                  // E-posta ve şifre doğrulamasını yapma işlemi burada gerçekleşir.
                  // Eğer doğrulama başarılı ise ilgili işlemler yapılır, aksi halde hata gösterilir.
                },
                svgPath: 'assets/icons/login.svg', textColor: Colors.black,
              ),
              SizedBox(height: 26.0),
              InkWell(
                onTap: () {
                  // "Üyeliğiniz yok mu? Kayıt olmak için tıklayın..." metni tıklandığında yapılacak işlemler buraya yazılır.
                  setState(() {
                    widget.formValid = FormValid.login;
                  });
                },
                child: Text(
                  "Üye misiniz? Giriş yapmak için tıklayın...",
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}