import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/editProfile/editPatProfileViewModel.dart';
import 'package:provider/provider.dart';

import '../../services/authentication.dart';
import '../profilPage/profilPage.dart';
import '../profilPage/profilPageViewModel.dart';
import '../widgets/myCustomButton.dart';

class EditPatientsProfile extends StatefulWidget {
  static String routeName = "ProfilPage";
  const EditPatientsProfile({Key? key}) : super(key: key);

  @override
  State<EditPatientsProfile> createState() => _EditPatientsProfileState();
}

class _EditPatientsProfileState extends State<EditPatientsProfile> {
  @override
  void initState() {
    super.initState();
    Provider.of<EditPatientsProfilViewModel>(context, listen: false).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final patientInfoFormKey = GlobalKey<FormState>();


    EditPatientsProfilViewModel viewModel = Provider.of<EditPatientsProfilViewModel>(context);
    // TextEditingController emailSignUpControler = TextEditingController();
    // TextEditingController passwordSignUpControler = TextEditingController();
    // TextEditingController passwordConfirmSignUpControler = TextEditingController();
    TextEditingController addressSignUpControler = TextEditingController(text: viewModel.address);
    TextEditingController genderControler = TextEditingController(text: viewModel.sex);
    TextEditingController birthdayControler = TextEditingController(text: viewModel.age.toString());
    TextEditingController nameSignUpControler = TextEditingController(text: viewModel.nameSurname);
   // TextEditingController drugsUsed = TextEditingController(text: viewModel.city);
    TextEditingController phoneSignUpControler = TextEditingController(text: viewModel.phone);
    TextEditingController citySignUpControler = TextEditingController(text: viewModel.city);
   // TextEditingController bloodGroupControler = TextEditingController(text: viewModel.nameSurname);


    @override
    void dispose() {
      // emailSignUpControler.dispose();
      // passwordSignUpControler.dispose();
      // passwordConfirmSignUpControler.dispose();
     // bloodGroupControler.dispose();
     // drugsUsed.dispose();
      addressSignUpControler.dispose();
      genderControler.dispose();
      birthdayControler.dispose();
      nameSignUpControler.dispose();
      phoneSignUpControler.dispose();
      citySignUpControler.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Profili Oluşturma Sayfası"),
        actions: [
          IconButton(
              onPressed: () async {
                await Provider.of<Authentication>(context, listen: false)
                    .signOut();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade200, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(26.0),
              child: Form(
                key: patientInfoFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // TextFormField(
                    //   controller: emailSignUpControler,
                    //   keyboardType: TextInputType.emailAddress,
                    //   decoration: InputDecoration(
                    //     prefixIcon: Icon(Icons.email_sharp),
                    //     prefixIconColor: Colors.amber,
                    //     labelText: "E-posta",
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     if (!EmailValidator.validate(value!)) {
                    //       return 'Lütfen geçerli bir e-posta adresi giriniz';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // SizedBox(height: 16.0),
                    // StatefulBuilder(
                    //   builder: (BuildContext context, StateSetter setState) {
                    //     return TextFormField(
                    //       controller: passwordSignUpControler,
                    //       validator: (value) {
                    //         if (value == null || value.isEmpty) {
                    //           return 'Lütfen şifrenizi girin';
                    //         }
                    //         return null;
                    //       },
                    //       decoration: InputDecoration(
                    //         prefixIcon: Icon(Icons.lock),
                    //         prefixIconColor: Colors.amber,
                    //         labelText: "Şifre",
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(20)),
                    //         suffixIcon: GestureDetector(
                    //           onTap: () {
                    //             setState(() {
                    //               _isObscure = !_isObscure;
                    //             });
                    //           },
                    //           child: Icon(
                    //             _isObscure
                    //                 ? Icons.visibility
                    //                 : Icons.visibility_off,
                    //           ),
                    //         ),
                    //       ),
                    //       obscureText: _isObscure,
                    //     );
                    //   },
                    // ),
                    // SizedBox(height: 16.0),
                    // StatefulBuilder(
                    //   builder: (BuildContext context, StateSetter setState) {
                    //     return TextFormField(
                    //       controller: passwordConfirmSignUpControler,
                    //       validator: (value) {
                    //         if (value != passwordSignUpControler.text) {
                    //           return 'Şifreler uyuşmuyor';
                    //         }
                    //         return null;
                    //       },
                    //       decoration: InputDecoration(
                    //         prefixIcon: Icon(Icons.lock),
                    //         prefixIconColor: Colors.amber,
                    //         labelText: "Şifreyi Tekrar Girin",
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(20)),
                    //         suffixIcon: GestureDetector(
                    //           onTap: () {
                    //             setState(() {
                    //               _isObscure = !_isObscure;
                    //             });
                    //           },
                    //           child: Icon(
                    //             _isObscure
                    //                 ? Icons.visibility
                    //                 : Icons.visibility_off,
                    //           ),
                    //         ),
                    //       ),
                    //       obscureText: _isObscure,
                    //     );
                    //   },
                    // ),
                    // SizedBox(height: 16.0),
                    TextFormField(
                      controller: nameSignUpControler,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        prefixIconColor: Colors.amber,
                        labelText: "İsim-Soyisim",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true, // Bu satırı ekleyin
                        fillColor: Colors.white, // Bu satırı ekleyin
                        focusedBorder: OutlineInputBorder(
                          // Odaklandığında da beyaz arka planı korumak için
                          borderSide: BorderSide(
                              color: Colors.amber), // veya istediğiniz bir renk
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Lütfen isminizi ve soyisminizi giriniz';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: birthdayControler,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.date_range_outlined),
                        prefixIconColor: Colors.amber,
                        labelText: "Doğum Tarihi",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true, // Bu satırı ekleyin
                        fillColor: Colors.white, // Bu satırı ekleyin
                        focusedBorder: OutlineInputBorder(
                          // Odaklandığında da beyaz arka planı korumak için
                          borderSide: BorderSide(
                              color: Colors.amber), // veya istediğiniz bir renk
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Lütfen doğum tarihinizi giriniz';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: genderControler,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.info),
                        prefixIconColor: Colors.amber,
                        labelText: "Cinsiyet",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true, // Bu satırı ekleyin
                        fillColor: Colors.white, // Bu satırı ekleyin
                        focusedBorder: OutlineInputBorder(
                          // Odaklandığında da beyaz arka planı korumak için
                          borderSide: BorderSide(
                              color: Colors.amber), // veya istediğiniz bir renk
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Lütfen cinsiyetinizi giriniz';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: addressSignUpControler,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.abc),
                        prefixIconColor: Colors.amber,
                        labelText: " Adresinizi Giriniz",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true, // Bu satırı ekleyin
                        fillColor: Colors.white, // Bu satırı ekleyin
                        focusedBorder: OutlineInputBorder(
                          // Odaklandığında da beyaz arka planı korumak için
                          borderSide: BorderSide(
                              color: Colors.amber), // veya istediğiniz bir renk
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Lütfen geçerli bir adres giriniz';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: citySignUpControler,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.co_present_rounded),
                        prefixIconColor: Colors.amber,
                        labelText: "Şehir",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true, // Bu satırı ekleyin
                        fillColor: Colors.white, // Bu satırı ekleyin
                        focusedBorder: OutlineInputBorder(
                          // Odaklandığında da beyaz arka planı korumak için
                          borderSide: BorderSide(
                              color: Colors.amber), // veya istediğiniz bir renk
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Lütfen şehir bilgisi giriniz.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: phoneSignUpControler,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android),
                        prefixIconColor: Colors.amber,
                        labelText: "Telefon Numarası",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true, // Bu satırı ekleyin
                        fillColor: Colors.white, // Bu satırı ekleyin
                        focusedBorder: OutlineInputBorder(
                          // Odaklandığında da beyaz arka planı korumak için
                          borderSide: BorderSide(
                              color: Colors.amber), // veya istediğiniz bir renk
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Lütfen bir telefon numarası giriniz';
                        }
                        return null;
                      },
                    ),
                    // SizedBox(height: 16.0),
                    // TextFormField(
                    //   controller: bloodGroupControler,
                    //   keyboardType: TextInputType.text,
                    //   decoration: InputDecoration(
                    //     prefixIcon: Icon(Icons.bloodtype),
                    //     prefixIconColor: Colors.amber,
                    //     labelText: "Kan Grubu",
                    //     floatingLabelBehavior: FloatingLabelBehavior.always,
                    //     labelStyle: TextStyle(
                    //         color: Colors.black45,
                    //         fontSize: 18.0,
                    //         fontWeight: FontWeight.bold),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //     filled: true, // Bu satırı ekleyin
                    //     fillColor: Colors.white, // Bu satırı ekleyin
                    //     focusedBorder: OutlineInputBorder(
                    //       // Odaklandığında da beyaz arka planı korumak için
                    //       borderSide: BorderSide(
                    //           color: Colors.amber), // veya istediğiniz bir renk
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //     focusColor: Colors.white,
                    //     hoverColor: Colors.white,
                    //   ),
                    //   validator: (value) {
                    //     if (value!.isEmpty || value == null) {
                    //       return 'Lütfen bir kan grubu giriniz';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // SizedBox(height: 16.0),
                    // TextFormField(
                    //   controller: drugsUsed,
                    //   keyboardType: TextInputType.text,
                    //   decoration: InputDecoration(
                    //     prefixIcon: Icon(Icons.co_present_rounded),
                    //     prefixIconColor: Colors.amber,
                    //     labelText: "Düzenli kullanılan ilaçlar",
                    //     floatingLabelBehavior: FloatingLabelBehavior.always,
                    //     labelStyle: TextStyle(
                    //         color: Colors.black45,
                    //         fontSize: 18.0,
                    //         fontWeight: FontWeight.bold),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //     filled: true, // Bu satırı ekleyin
                    //     fillColor: Colors.white, // Bu satırı ekleyin
                    //     focusedBorder: OutlineInputBorder(
                    //       // Odaklandığında da beyaz arka planı korumak için
                    //       borderSide: BorderSide(
                    //           color: Colors.amber), // veya istediğiniz bir renk
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //     focusColor: Colors.white,
                    //     hoverColor: Colors.white,
                    //   ),
                    //   validator: (value) {
                    //     if (value!.isEmpty || value == null) {
                    //       return 'Eğer yoksa yok yazın';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    SizedBox(height: 16.0),

                    SizedBox(height: 24.0),
                    MyCustomButton(
                      text: 'Kaydet',
                      backgroundColor: Colors.amberAccent,
                      onPressed: () async {
                        try {
                          if (patientInfoFormKey.currentState!.validate()) {
                            // kullanıcı bilgileri ile doctorUpdate metodu çağırılacak
                            await Provider.of<EditPatientsProfilViewModel>(context,
                                listen: false).patientsUpdate(
                              name: nameSignUpControler.text,
                              age:  int.tryParse(birthdayControler.text),
                              phone: phoneSignUpControler.text,
                              address: addressSignUpControler.text,
                              city: citySignUpControler.text,
                              sex: genderControler.text

                            );
                            print("tuşa basıldı  ");

                            await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Bilgi"),
                                  content: Text("Bilgileriniz başarı ile güncellenmiştir."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // AlertDialog'u kapat
                                          //Navigator.of(context).pushReplacementNamed(ProfilPage.routeName); // ProfilPage'e yönlendirme yap
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChangeNotifierProvider(
                                                create: (context) => ProfilPageViewModel(),
                                                child: ProfilPage(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text("Tamam")
                                    ),
                                  ],
                                );
                              },
                            );

                          }
                        } catch (e) {
                          print(e.toString());
                          //_showMyErrorDialog(e.message);
                        }

                        print("tuşa basıldı");
                      },
                      svgPath: 'assets/icons/save.svg',
                      textColor: Colors.black,
                      SizedBoxRange: 40.0,
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
}
