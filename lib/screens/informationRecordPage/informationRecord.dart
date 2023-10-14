import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/informationRecordPage/informationRecordViewModel.dart';
import 'package:healtzone_v0/screens/models/doctorModel.dart';
import 'package:healtzone_v0/screens/publications.dart';
import 'package:provider/provider.dart';

import '../../services/authentication.dart';
import '../widgets/myCustomButton.dart';

enum FormValidInfo { doctorInfo, patientInfo }

class InformationRecord extends StatefulWidget {
  static String routeName = "InformationRecordPage";

  FormValidInfo? formValidInfo;

  AsyncSnapshot<DocumentSnapshot>? snapshot;

  // Bu constructor'da "this.formValidInfo" ve "this.snapshot" ile değişkenleri sınıf değişkenlerine atanması gerekiyor.
  InformationRecord({required this.formValidInfo,  this.snapshot});

  @override
  State<InformationRecord> createState() => _InformationRecordState();
}

class _InformationRecordState extends State<InformationRecord> {


  @override
  Widget build(BuildContext context) {
    return widget.formValidInfo == FormValidInfo.doctorInfo
        ? buildDoctorInfo()
        : buildPatientInfo();
  }

  Widget buildDoctorInfo() {
    final doctorInfoFormKey = GlobalKey<FormState>();

    // TextEditingController emailSignUpControler = TextEditingController();
    // TextEditingController passwordSignUpControler = TextEditingController();
    // TextEditingController passwordConfirmSignUpControler = TextEditingController();
    TextEditingController addressSignUpControler = TextEditingController();
    TextEditingController companyNameSignUpControler = TextEditingController();
    TextEditingController departmentSignUpControler = TextEditingController();
    TextEditingController nameSignUpControler = TextEditingController();
    TextEditingController graduationYearSignUpControler =
        TextEditingController();
    TextEditingController phoneSignUpControler = TextEditingController();
    TextEditingController titleSignUpControler = TextEditingController();
    TextEditingController universitySignUpControler = TextEditingController();

    @override
    void dispose() {
      // emailSignUpControler.dispose();
      // passwordSignUpControler.dispose();
      // passwordConfirmSignUpControler.dispose();
      addressSignUpControler.dispose();
      companyNameSignUpControler.dispose();
      departmentSignUpControler.dispose();
      nameSignUpControler.dispose();
      graduationYearSignUpControler.dispose();
      phoneSignUpControler.dispose();
      titleSignUpControler.dispose();
      universitySignUpControler.dispose();

      super.dispose();
    }

    ;

    return ChangeNotifierProvider<InfRecVievModel>(
      create: (_) => InfRecVievModel(),
      builder: (context, _) => Scaffold(
        appBar:
            AppBar(title: Text("Doktor Profili Oluşturma Sayfası"), actions: [
          IconButton(
              onPressed: () async {
                await Provider.of<Authentication>(context, listen: false)
                    .signOut();
              },
              icon: Icon(Icons.exit_to_app))
        ]),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(26.0),
              child: Form(
                key: doctorInfoFormKey,
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
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
                      controller: departmentSignUpControler,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.difference_sharp),
                        prefixIconColor: Colors.amber,
                        labelText: "Uzmanlık Branşı",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Lütfen bir uzmanlık branşı giriniz';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: companyNameSignUpControler,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.home_work),
                        prefixIconColor: Colors.amber,
                        labelText: "Sağlık Kurumu Adı",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Lütfen bir sağlık kurumu adı giriniz';
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
                        labelText: "Sağlık Kurumunuzun Adresi",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Lütfen geçerli bir e-posta adresi giriniz';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: titleSignUpControler,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.leaderboard_outlined),
                        prefixIconColor: Colors.amber,
                        labelText: "Ünvan",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Lütfen ünvanınızı giriniz';
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Lütfen bir telefon numarası giriniz';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: universitySignUpControler,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.school),
                        prefixIconColor: Colors.amber,
                        labelText: "Mezun Olduğunuz Üniversiteyi Giriniz",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Lütfen bir üniversite giriniz';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: graduationYearSignUpControler,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.date_range_outlined),
                        prefixIconColor: Colors.amber,
                        labelText: "Mezun Olduğunuz Yıl",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Lütfen bir yıl giriniz';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),

                    SizedBox(height: 24.0),
                    MyCustomButton(
                      text: 'Gönder',
                      backgroundColor: Colors.amberAccent,
                      onPressed: () async {
                        print("tuşa ilk defa basıldı try'ın dışında");
                        try {
                          if (doctorInfoFormKey.currentState!.validate()) {
                            // kullanıcı bilgileri ile doctorUpdate metodu çağırılacak
                            await Provider.of<InfRecVievModel>(context,
                                    listen: false)
                                .doctorUpdate(
                                    id: widget.snapshot?.data?["id"],
                                    email: widget.snapshot?.data?["email"],
                                    university: universitySignUpControler.text,
                                    title: titleSignUpControler.text,
                                    address: addressSignUpControler.text,
                                    companyName:
                                        companyNameSignUpControler.text,
                                    department: departmentSignUpControler.text,
                                    graduationYear:
                                        graduationYearSignUpControler.text,
                                    name: nameSignUpControler.text,
                                    phone: phoneSignUpControler.text);
                            print(
                                "tuşa basıldı id: ${widget.snapshot?.data?["id"]} email: ${widget.snapshot?.data?["email"]}  ");
                          }
                        } catch (e) {
                          print(e.toString());
                          //_showMyErrorDialog(e.message);
                        }

                        // Navigator.pushNamed(context, PublicationsScreen.routeName);
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

  Widget buildPatientInfo() {
    final patientInfoFormKey = GlobalKey<FormState>();

    // TextEditingController emailSignUpControler = TextEditingController();
    // TextEditingController passwordSignUpControler = TextEditingController();
    // TextEditingController passwordConfirmSignUpControler = TextEditingController();
    TextEditingController addressSignUpControler = TextEditingController();
    TextEditingController genderControler = TextEditingController();
    TextEditingController birthdayControler = TextEditingController();
    TextEditingController nameSignUpControler = TextEditingController();
    TextEditingController drugsUsed = TextEditingController();
    TextEditingController phoneSignUpControler = TextEditingController();
    TextEditingController chronicDiseaseControler = TextEditingController();
    TextEditingController bloodGroupControler = TextEditingController();

    @override
    void dispose() {
      // emailSignUpControler.dispose();
      // passwordSignUpControler.dispose();
      // passwordConfirmSignUpControler.dispose();
      addressSignUpControler.dispose();
      genderControler.dispose();
      birthdayControler.dispose();
      nameSignUpControler.dispose();
      drugsUsed.dispose();
      phoneSignUpControler.dispose();
      chronicDiseaseControler.dispose();
      bloodGroupControler.dispose();

      super.dispose();
    }

    ;

    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Profili Oluşturma Sayfası"),
        actions: [ IconButton(
            onPressed: () async {
              await Provider.of<Authentication>(context, listen: false)
                  .signOut();
            },
            icon: Icon(Icons.exit_to_app))],
      ),
      body: SingleChildScrollView(
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
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
                    controller: chronicDiseaseControler,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.co_present_rounded),
                      prefixIconColor: Colors.amber,
                      labelText: "Kronik Hastalık/Alerji",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'Eğer bir hastalık/alerji yoksa, yok yazınız.';
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'Lütfen bir telefon numarası giriniz';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: bloodGroupControler,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.bloodtype),
                      prefixIconColor: Colors.amber,
                      labelText: "Kan Grubu",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'Lütfen bir kan grubu giriniz';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: drugsUsed,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.co_present_rounded),
                      prefixIconColor: Colors.amber,
                      labelText: "Düzenli kullanılan ilaçlar",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'Eğer yoksa yok yazın';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),

                  SizedBox(height: 24.0),
                  MyCustomButton(
                    text: 'Kaydet',
                    backgroundColor: Colors.amberAccent,
                    onPressed: () async {
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
    );
  }
}
