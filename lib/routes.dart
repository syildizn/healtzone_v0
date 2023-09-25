import 'package:flutter/cupertino.dart';
import 'package:healtzone_v0/screens/doctorLoginAndSignupPage/doctorLoginAndSignup.dart';
import 'package:healtzone_v0/screens/doctorPage/doctor.dart';
import 'package:healtzone_v0/screens/emailLoginPage.dart';
import 'package:healtzone_v0/screens/informationRecordPage/informationRecord.dart';
import 'package:healtzone_v0/screens/loginPage.dart';
import 'package:healtzone_v0/screens/offers.dart';
import 'package:healtzone_v0/screens/publications.dart';
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
 // EmailLoginPage.routeName:(context) => EmailLoginPage(formValid:FormValid.login ),
 // EmailLoginPage.routeName:(context) => EmailLoginPage(formValid:FormValid.signup ),
 // EmailLoginPage.routeName:(context) => EmailLoginPage(formValid:FormValid.reset ),
 // DoctorLoginAndSignup.routeName:(context) => DoctorLoginAndSignup(formValidi: FormValidi.login),
 // DoctorLoginAndSignup.routeName:(context) => DoctorLoginAndSignup(formValidi: FormValidi.signup),
 // DoctorLoginAndSignup.routeName:(context) => DoctorLoginAndSignup(formValidi: FormValidi.reset),
 // InformationRecord.routeName:(context) => InformationRecord(formValidInfo: FormValidInfo.doctorInfo),
 // InformationRecord.routeName:(context) => InformationRecord(formValidInfo: FormValidInfo.patientInfo),
};