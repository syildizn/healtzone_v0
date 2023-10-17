import 'package:flutter/cupertino.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/detailedUltrasoundPage.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/genitalAestheticsPage.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/inVitroFertilizationPage.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/obstetricsPage.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/pregnancyAndBirthPage.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/surgeriesPage.dart';
import 'package:healtzone_v0/screens/doctorLoginAndSignupPage/doctorLoginAndSignup.dart';
import 'package:healtzone_v0/screens/doctorPage/doctor.dart';
import 'package:healtzone_v0/screens/editProfile/editPatientsProfile.dart';
import 'package:healtzone_v0/screens/patientEmailLoginSignupPage/emailLoginPage.dart';
import 'package:healtzone_v0/screens/informationRecordPage/informationRecord.dart';
import 'package:healtzone_v0/screens/loginPage/loginPage.dart';
import 'package:healtzone_v0/screens/offers.dart';
import 'package:healtzone_v0/screens/profilPage/profilPage.dart';
import 'package:healtzone_v0/screens/homePage/publications.dart';
import 'package:healtzone_v0/screens/waitingPage.dart';
import 'package:healtzone_v0/screens/widgets/onBoard.dart';
import 'package:healtzone_v0/screens/widgets/onBoardSetState.dart';

Map<String,WidgetBuilder> routes = {
 PublicationsScreen.routeName: (context) => PublicationsScreen(),
 Doctor.routeName: (context) => Doctor(),
 OffersPage.routeName:(context) => OffersPage(),
 LoginPage.routeName: (context) => LoginPage(),
 OnBoard.routeName:(context) => OnBoard(),
 OnBoardSetState.routeName:(context) => OnBoardSetState(),
 EmailLoginPage.routeName + "_login": (context) => EmailLoginPage(formValid:FormValid.login ),
 EmailLoginPage.routeName + "_signup": (context) => EmailLoginPage(formValid:FormValid.signup ),
 EmailLoginPage.routeName + "_reset": (context) => EmailLoginPage(formValid:FormValid.reset ),
 DoctorLoginAndSignup.routeName + "_login": (context) => DoctorLoginAndSignup(formValidi: FormValidi.login),
 DoctorLoginAndSignup.routeName + "_signup": (context) => DoctorLoginAndSignup(formValidi: FormValidi.signup),
 DoctorLoginAndSignup.routeName + "_reset": (context) => DoctorLoginAndSignup(formValidi: FormValidi.reset),
 InformationRecord.routeName + "_doctor": (context) => InformationRecord(formValidInfo: FormValidInfo.doctorInfo),
 InformationRecord.routeName + "_patient": (context) => InformationRecord(formValidInfo: FormValidInfo.patientInfo),
 WaitingPage.routeName:(context) => WaitingPage(),
 //------------
 DetailedUltrasound.routeName:(context) => DetailedUltrasound(),
 GenitalAesthetics.routeName:(context) => GenitalAesthetics(),
 InVitroFertilization.routeName:(context) => InVitroFertilization(),
 Obstetrics.routeName:(context) => Obstetrics(),
 PregnancyAndBirth.routeName:(context) => PregnancyAndBirth(),
 Surgeries.routeName:(context) => Surgeries(),
 ProfilPage.routeName:(context) => ProfilPage(),
 EditPatientsProfile.routeName:(context) => EditPatientsProfile(),

 // EmailLoginPage.routeName:(context) => EmailLoginPage(formValid:FormValid.login ),
 // EmailLoginPage.routeName:(context) => EmailLoginPage(formValid:FormValid.signup ),
 // EmailLoginPage.routeName:(context) => EmailLoginPage(formValid:FormValid.reset ),
 // DoctorLoginAndSignup.routeName:(context) => DoctorLoginAndSignup(formValidi: FormValidi.login),
 // DoctorLoginAndSignup.routeName:(context) => DoctorLoginAndSignup(formValidi: FormValidi.signup),
 // DoctorLoginAndSignup.routeName:(context) => DoctorLoginAndSignup(formValidi: FormValidi.reset),
 // InformationRecord.routeName:(context) => InformationRecord(formValidInfo: FormValidInfo.doctorInfo),
 // InformationRecord.routeName:(context) => InformationRecord(formValidInfo: FormValidInfo.patientInfo),
};