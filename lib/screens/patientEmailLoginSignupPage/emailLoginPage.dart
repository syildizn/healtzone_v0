import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/patientEmailLoginSignupPage/patLogAndSgnViewModel.dart';
import 'package:healtzone_v0/screens/widgets/myCustomButton.dart';
import 'package:healtzone_v0/services/authentication.dart';
import 'package:provider/provider.dart';

//enum operatörü bir nevi if gibi, kontrol yapıp giriş sayfası ya da kayıt ol sayfası gösteriyor.
enum FormValid { login, signup, reset }

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
    return widget.formValid == FormValid.login
        ? buildLogin()
        : widget.formValid == FormValid.signup
            ? buildSignup()
            : buildResetPassword();
  }

  Widget buildLogin() {
    TextEditingController emailLoginControler = TextEditingController();
    TextEditingController passwordLoginControler = TextEditingController();

    @override
    void dispose() {
      emailLoginControler.dispose();
      passwordLoginControler.dispose();
      super.dispose();
    }

    ;

    final loginFormKey = GlobalKey<FormState>();

    return ChangeNotifierProvider<PatLogAndSgnViewModel>(
      create: (_) => PatLogAndSgnViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text("Lütfen Giriş Yapınız"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Form(
              key: loginFormKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: emailLoginControler,
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
                          controller: passwordLoginControler,
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
                      onPressed: () async {
                        // E-posta ve şifre doğrulamasını yapma işlemi burada gerçekleşir.
                        // Eğer doğrulama başarılı ise ilgili işlemler yapılır, aksi halde hata gösterilir.

                        try {
                          if (loginFormKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.

                            final user = await Provider.of<Authentication>(
                                    context,
                                    listen: false)
                                .signInWithEmailAndPassword(
                                    emailLoginControler.text,
                                    passwordLoginControler.text);
                            final viewModel = Provider.of<PatLogAndSgnViewModel>(
                                context,
                                listen: false);

                            if (!user!.emailVerified) {
                              await _showMyDialog();
                              await Provider.of<Authentication>(context,
                                      listen: false)
                                  .signOut();
                            }

                            final bool? doctorCheck =
                                await checkDoctor(user, viewModel);

                            if (doctorCheck == true) {
                              await _showMyPatientDialog();
                              await Provider.of<Authentication>(context,
                                      listen: false)
                                  .signOut();
                            }

                            Navigator.pop(context);
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //       content: Text('Giriş Yapılıyor'),
                            //       backgroundColor: Colors.amber),
                            // );
                          }
                        } on FirebaseAuthException catch (e) {
                          print(e.message);
                          _showMyErrorDialog(e.message);
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
                    SizedBox(height: 26.0),
                    InkWell(
                      onTap: () {
                        // "Üyeliğiniz yok mu? Kayıt olmak için tıklayın..." metni tıklandığında yapılacak işlemler buraya yazılır.
                        setState(() {
                          widget.formValid = FormValid.reset;
                        });
                      },
                      child: Text(
                        "Şifrenizi unuttunuz mu? Yenilemek için tıklayın...",
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
        ),
      ),
    );
  }

  Widget buildSignup() {
    final signupFormKey = GlobalKey<FormState>();

    TextEditingController emailSignUpControler = TextEditingController();
    TextEditingController passwordSignUpControler = TextEditingController();
    TextEditingController passwordConfirmSignUpControler =
        TextEditingController();

    @override
    void dispose() {
      emailSignUpControler.dispose();
      passwordSignUpControler.dispose();
      passwordConfirmSignUpControler.dispose();
      super.dispose();
    }

    ;

    return ChangeNotifierProvider<PatLogAndSgnViewModel>(
      create: (_) => PatLogAndSgnViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text("Kayıt Sayfası"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Form(
              key: signupFormKey,
              child: SingleChildScrollView(
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
                      onPressed: () async {
                        // E-posta ve şifre doğrulamasını yapma işlemi burada gerçekleşir.
                        // Eğer doğrulama başarılı ise ilgili işlemler yapılır, aksi halde hata gösterilir.
                        try {
                          if (signupFormKey.currentState!.validate()) {
                            final user = await Provider.of<Authentication>(
                                    context,
                                    listen: false)
                                .createUserWithEmailAndPassword(
                                    emailSignUpControler.text,
                                    passwordSignUpControler.text);
                            await Provider.of<PatLogAndSgnViewModel>(context,
                                    listen: false)
                                .addNewPatient(
                              email: user?.email,id: user?.uid
                            );

                            if (!user!.emailVerified) {
                              await user?.sendEmailVerification();
                            }

                            await _showMyDialog();
                            await Provider.of<Authentication>(context,
                                    listen: false)
                                .signOut();

                            setState(() {
                              print("çalıştı numerator");
                              widget.formValid = FormValid.login;
                            });
                          }
                        } on FirebaseAuthException catch (e) {
                          print(e.message);
                          _showMyErrorDialog(e.message);
                        }
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
        ),
      ),
    );
  }

  Widget buildResetPassword() {
    TextEditingController emailResetControler = TextEditingController();

    final resetFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Şifre Yenileme"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Form(
            key: resetFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: emailResetControler,
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
                SizedBox(height: 24.0),
                MyCustomButton(
                  SizedBoxRange: 38.0,
                  text: 'Gönder',
                  backgroundColor: Colors.amberAccent,
                  onPressed: () async {
                    // E-posta ve şifre doğrulamasını yapma işlemi burada gerçekleşir.
                    // Eğer doğrulama başarılı ise ilgili işlemler yapılır, aksi halde hata gösterilir.

                    if (resetFormKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.

                      await Provider.of<Authentication>(context, listen: false)
                          .sendPasswordResetEmail(emailResetControler.text);
                      await _showMyResetDialog();

                      Navigator.pop(context);
                    }
                  },
                  svgPath: 'assets/icons/lockReset.svg',
                  textColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Onay Gerekiyor'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Merhaba, e-postanıza bir onay linki gönderildi.'),
                Text(
                    'Onay linkine tıkladıktan sonra kaydınız tamamlanacaktır.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anladım'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyResetDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Şifre Yenileme'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Merhaba, e-postanıza bir şifre yenileme linki gönderildi.'),
                Text(
                    'Şifre yenileme linkine tıklayarak şifrenizi yenileyebilirsiniz.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anladım'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyErrorDialog(String? errore) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        // String getTurkishErrorMessage(String errorCode) {
        //   switch (errorCode) {
        //     case 'wrong-password':
        //       return 'Hatalı şifre girişi. Lütfen şifrenizi kontrol edin.';
        //     case 'user-not-found':
        //       return 'Kullanıcı bulunamadı. Lütfen kayıtlı olduğunuzdan emin olun.';
        //   // Diğer hata kodları için gerekli çevirileri ekleyin.
        //     default:
        //       return 'Bir hata oluştu. Lütfen tekrar deneyin.';
        //   }
        // }

        return AlertDialog(
          title: Text('Hata !'),
          content: SingleChildScrollView(
            child: Text(errore!),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anladım'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> checkDoctor(User user, PatLogAndSgnViewModel viewModel) async {
    if (user != null) {
      final doctorRef =
          viewModel.database?.firestore?.collection('doctors').doc(user.uid);
      final snapshot = await doctorRef?.get();

      if (snapshot != null && snapshot.exists) {
        // Kullanıcı bir doktor.
        print("User is a doctor");
        return true;
      } else {
        // Kullanıcı bir doktor değil. Hata mesajı göster ve signOut yap.
        // TODO: Sign out user and show error message.
        print("User is not a doctor");
        return false;
      }
    }
  }

  Future<void> _showMyPatientDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hatalı Giriş.'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Merhaba, siz bir doktorsunuz.'),
                Text('Lütfen doktor giriş kısmını kullanın.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anladım'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
