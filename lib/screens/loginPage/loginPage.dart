import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healtzone_v0/screens/doctorLoginAndSignupPage/doctorLoginAndSignup.dart';
import 'package:healtzone_v0/screens/loginPage/loginPageViewModel.dart';
import 'package:healtzone_v0/screens/patientEmailLoginSignupPage/emailLoginPage.dart';
import 'package:healtzone_v0/screens/homePage/publications.dart';
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


  }


  Future<void> _signInWithGoogle(LoginPageViewModel viewModel) async {
    setState(() {
      isLoading = true;
    });

    final User? user =
    await Provider.of<Authentication>(context, listen: false).signInWithGoogle();

    print("----------------------------------------------beklenen user: ${user?.uid}");


    await viewModel.addNewPatient(id: user?.uid,email: user?.email);
    setState(() {
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginPageViewModel>(
      create: (_) => LoginPageViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(

            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 24, 8),
                child: Text("Doktor musunuz ?",style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(Icons.arrow_forward),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: IconButton(
                    onPressed: isLoading ? null : () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DoctorLoginAndSignup(formValidi: FormValidi.login)),
                        );

                    },
                    icon: SvgPicture.asset('assets/icons/doctorx.svg',width: 35,height: 35,)),
              )
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
              ), //anonim
              SizedBox(height: 20.0),
              MyCustomButton(
                text: 'Email İle Giriş',
                backgroundColor: Colors.blue,
                onPressed: isLoading ? null : () {
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
              ), //email
              SizedBox(height: 20.0),
              MyCustomButton(
                text: 'Google İle Giriş',
                backgroundColor: Colors.white,
                onPressed:  isLoading ? null : (){
                  final viewModel =  Provider.of<LoginPageViewModel>(context, listen: false);
                  _signInWithGoogle(viewModel);},
                svgPath: 'assets/icons/google.svg',
                textColor: Colors.black, SizedBoxRange: 20.0,
              ), //google
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
      ),
    );
  }
}
