import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healtzone_v0/screens/doctorLoginAndSignupPage/doctorLogAndSgViewModel.dart';
import 'package:healtzone_v0/screens/widgets/myCustomButton.dart';
import 'package:healtzone_v0/services/authentication.dart';
import 'package:provider/provider.dart';

import '../widgets/onBoard.dart';

//enum operatörü bir nevi if gibi, kontrol yapıp giriş sayfası ya da kayıt ol sayfası gösteriyor.
enum FormValidi { login, signup, reset }

class DoctorLoginAndSignup extends StatefulWidget {
  static String routeName = "DoctorLoginAndSignup";

  FormValidi formValidi;

  DoctorLoginAndSignup({required this.formValidi});

  @override
  State<DoctorLoginAndSignup> createState() => _DoctorLoginAndSignupState();
}

class _DoctorLoginAndSignupState extends State<DoctorLoginAndSignup> {
  bool _isObscure = true;

  bool isLoading = false;

  FormValidi? formValid = FormValidi.login;

  Future<void> _signInWithGoogle(DocLgAndSgVievModel viewModel) async {

    try{
      setState(() {
      isLoading = true;
    });

    final User? user =
    await Provider.of<Authentication>(context, listen: false).signInWithGoogle();

    print("----------------------------------------------beklenen user: ${user?.uid}");


    await viewModel.addNewDoctor(id: user?.uid,email: user?.email);

    setState(() {
      isLoading = false;
    });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnBoard()),
      );

    }catch(e){print("hata: $e");}


  }

  @override
  Widget build(BuildContext context) {
    return widget.formValidi == FormValidi.login
        ? buildLogin(context)
        : widget.formValidi == FormValidi.signup
            ? buildSignup()
            : buildResetPassword();
  }

  Widget buildLogin(BuildContext context) {
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

    return ChangeNotifierProvider<DocLgAndSgVievModel>(
      create: (_) => DocLgAndSgVievModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text("Doktor Girişi"),
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
                    IconButton(
                        onPressed: isLoading ? null : (){
                          final viewModel =  Provider.of<DocLgAndSgVievModel>(context, listen: false);
                          _signInWithGoogle(viewModel);},
                        icon: SvgPicture.asset(
                          "assets/icons/google.svg",
                          height: 32,
                          width: 32,
                        )),
                    SizedBox(height: 16.0),
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
                      //burada statefulBuilder kullanıldı çünkü şifreyi gizleyip açarken tüm ekranın state'i değil de sadece şifre ksımının state bilgisi yeniden boyansın diye
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

                            final viewModel = Provider.of<DocLgAndSgVievModel>(
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

                            if (doctorCheck == false) {
                              await _showMyDoctorDialog();
                              await Provider.of<Authentication>(context,
                                      listen: false)
                                  .signOut();
                            }

                            //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Navigator çalışıyor!')));

                            Navigator.pop(context);
                            //Navigator.pushReplacementNamed(context, OnBoard.routeName);
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
                          widget.formValidi = FormValidi.signup;
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
                        //
                        setState(() {
                          widget.formValidi = FormValidi.reset;
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

    return ChangeNotifierProvider<DocLgAndSgVievModel>(
      create: (_) => DocLgAndSgVievModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text("Doktor Kayıt Sayfası"),
        ),
        body: SingleChildScrollView(
          child: Center(
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
                            labelText: "Şifreyi Tekrar Girin",
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
                        // // Eğer doğrulama başarılı ise ilgili işlemler yapılır, aksi halde hata gösterilir.
                        try {
                          if (signupFormKey.currentState!.validate()) {
                            final user = await Provider.of<Authentication>(
                                    context,
                                    listen: false)
                                .createUserWithEmailAndPassword(
                                    emailSignUpControler.text,
                                    passwordSignUpControler.text);

                            // kullanıcı bilgileri ile addNewDoctor metodu çağırılacak
                            await Provider.of<DocLgAndSgVievModel>(context,
                                    listen: false)
                                .addNewDoctor(
                              id: user?.uid,
                              email: emailSignUpControler.text,
                            );
                            // await context.read<DocLgAndSgVievModel>().addNewDoctor(
                            //      id: user?.uid,
                            //      email: emailSignUpControler.text,
                            //      role: "doctor"
                            //  );

                            if (!user!.emailVerified) {
                              await user?.sendEmailVerification();
                            }

                            await _showMyDialog();
                            await Provider.of<Authentication>(context,
                                    listen: false)
                                .signOut();

                            setState(() {
                              print("çalıştı numerator");
                              widget.formValidi = FormValidi.login;
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
                          widget.formValidi = FormValidi.login;
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
            child: SingleChildScrollView(
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

  Future<bool?> checkDoctor(User user, DocLgAndSgVievModel viewModel) async {
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

  Future<void> _showMyDoctorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hatalı Giriş.'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Merhaba, siz bir doktor değilsiniz.'),
                Text('Lütfen normal kullanıcı giriş kısmını kullanın.'),
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

// void checkDoctor(User user) async {
  //   if (user != null) {
  //     // Kullanıcı giriş yapmış. Hangi role sahip olduğunu kontrol edelim.
  //     return StreamBuilder<DocumentSnapshot>(
  //         stream:await Provider.of<DocLgAndSgVievModel>(context,
  //         listen: false).database?.firestore?.collection('doctors').doc(user.uid).snapshots(),
  //   builder: (context, doctorSnapshot) {
  //   if (doctorSnapshot.hasData) {
  //   if (doctorSnapshot.data!.exists) {
  //   // Kullanıcı bir doktor.
  //   return Text("a");
  //   }}});}else{
  //
  //   }
  // }
}
