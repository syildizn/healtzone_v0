import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/widgets/myCustomButton.dart';

//enum operatörü bir nevi if gibi, kontrol yapıp giriş sayfası ya da kayıt ol sayfası gösteriyor.
enum FormValid { login, signup }

class EmailLoginPage extends StatefulWidget {
  static String routeName = "EmailLoginPage";

  FormValid formValid;

  EmailLoginPage({required this.formValid});

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  bool _isObscure = true;

  FormValid? formValid = FormValid.login;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.formValid == FormValid.login ? buildLogin() : buildSignup();
  }

  Widget buildLogin() {

    final loginFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Lütfen Giriş Yapınız"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_sharp),
                    prefixIconColor: Colors.amber,
                    labelText: "E-posta",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen e-posta adresinizi girin';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen e-posta adresinizi girin';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    prefixIconColor: Colors.amber,
                    labelText: "Şifre",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
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
                MyCustomButton(SizedBoxRange: 38.0,
                  text: 'Giriş Yap',
                  backgroundColor: Colors.amberAccent,
                  onPressed: () {
                    // E-posta ve şifre doğrulamasını yapma işlemi burada gerçekleşir.
                    // Eğer doğrulama başarılı ise ilgili işlemler yapılır, aksi halde hata gösterilir.
                    setState(() {
                      if (loginFormKey.currentState!.validate()) {
                        // Doğrulama başarılı ise ilgili işlemler yapılır.
                      }
                    });


                  },
                  svgPath: 'assets/icons/login.svg',
                  textColor: Colors.black,
                ),
                SizedBox(height: 26.0),
                InkWell(
                  onTap: () {
                    // "Üyeliğiniz yok mu? Kayıt olmak için tıklayın..." metni tıklandığında yapılacak işlemler buraya yazılır.
                    setState(() {
                      widget.formValid = FormValid.signup;
                    });
                  },
                  child: Text(
                    "Üyeliğiniz yok mu? Kayıt olmak için tıklayın...",
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignup() {

    final signupFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Lütfen Giriş Yapınız"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Form(
            key: signupFormKey,
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_sharp),
                    prefixIconColor: Colors.amber,
                    labelText: "E-posta",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen e-posta adresinizi girin';
                    }
                    return null;
                  },
                ),


                SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen e-posta adresinizi girin';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    prefixIconColor: Colors.amber,
                    labelText: "Şifre",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
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
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen e-posta adresinizi girin';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    prefixIconColor: Colors.amber,
                    labelText: "Şifre",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
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

                    setState(() {
                      signupFormKey.currentState?.validate();
                    });

                  },
                  svgPath: 'assets/icons/login.svg',
                  textColor: Colors.black, SizedBoxRange: 40.0,
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
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
