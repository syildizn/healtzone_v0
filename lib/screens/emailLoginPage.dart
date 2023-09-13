import 'package:email_validator/email_validator.dart';
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
                    if (!EmailValidator.validate(value!)) {
                      return 'Lütfen geçerli bir e-posta adresi girin';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen şifrenizi girin';
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
                          onTap: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          child: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: _isObscure,
                    );
                  },
                ),
                SizedBox(height: 24.0),
                MyCustomButton(
                  SizedBoxRange: 38.0,
                  text: 'Giriş Yap',
                  backgroundColor: Colors.amberAccent,
                  onPressed: () {
                    // E-posta ve şifre doğrulamasını yapma işlemi burada gerçekleşir.
                    // Eğer doğrulama başarılı ise ilgili işlemler yapılır, aksi halde hata gösterilir.

                    // if (loginFormKey.currentState!.validate()) {
                    //   // Doğrulama başarılı ise ilgili işlemler yapılır.
                    // }
                    if (loginFormKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Giriş Yapılıyor'),
                            backgroundColor: Colors.amber),
                      );
                    }
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

    TextEditingController emailSignUpControler = TextEditingController();
    TextEditingController passwordSignUpControler = TextEditingController();
    TextEditingController passwordConfirmSignUpControler = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Sayfası"),
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
                  controller: emailSignUpControler,
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
                    if (!EmailValidator.validate(value!)) {
                      return 'Lütfen geçerli bir e-posta adresi giriniz';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return TextFormField(
                      controller: passwordSignUpControler,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen şifrenizi girin';
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
                          onTap: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          child: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: _isObscure,
                    );
                  },
                ),
                SizedBox(height: 16.0),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return TextFormField(
                      controller: passwordConfirmSignUpControler,
                      validator: (value) {
                        if (value != passwordSignUpControler.text) {
                          return 'Şifreler uyuşmuyor';
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
                          onTap: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          child: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: _isObscure,
                    );
                  },
                ),
                SizedBox(height: 24.0),
                MyCustomButton(
                  text: 'Kayıt Ol',
                  backgroundColor: Colors.amberAccent,
                  onPressed: () {
                    // E-posta ve şifre doğrulamasını yapma işlemi burada gerçekleşir.
                    // Eğer doğrulama başarılı ise ilgili işlemler yapılır, aksi halde hata gösterilir.


                      signupFormKey.currentState?.validate();

                  },
                  svgPath: 'assets/icons/login.svg',
                  textColor: Colors.black,
                  SizedBoxRange: 40.0,
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
