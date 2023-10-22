import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/inVitroFertilization/inVitroFertilizationViewModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../homePage/publications.dart';
import '../../../profilPage/profilPage.dart';
import '../../../profilPage/profilPageViewModel.dart';

class InVitroFertilization extends StatefulWidget {
  static String routeName = "InVitroFertilizationPage";
  const InVitroFertilization({Key? key}) : super(key: key);

  @override
  State<InVitroFertilization> createState() => _InVitroFertilizationState();
}

class _InVitroFertilizationState extends State<InVitroFertilization> {
  bool? _hadIVFTreatmentBefore;
  bool? _haveFrozenEmbryos;
  bool? _havePreviousDiagnosis;
  String _previousDiagnosisText = '';
  String _additionalInformation = '';
  bool? _haveAdditionalInformation;
  String? filePath;
  String? picPath;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InVitroFertViewModel>(
      create: (_) => InVitroFertViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text('Tüp Bebek Tedavisi'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade200, Colors.white],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              _buildCard(
                title: 'Daha önce tüp bebek tedavisi aldınız mı?',
                child: Row(
                  children: [
                    Text('Evet'),
                    Radio(
                      value: true,
                      groupValue: _hadIVFTreatmentBefore,
                      onChanged: (bool? value) {
                        setState(() {
                          _hadIVFTreatmentBefore = value;
                        });
                      },
                    ),
                    Text('Hayır'),
                    Radio(
                      value: false,
                      groupValue: _hadIVFTreatmentBefore,
                      onChanged: (bool? value) {
                        setState(() {
                          _hadIVFTreatmentBefore = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (_hadIVFTreatmentBefore == true)
                _buildCard(
                  title: 'Dondurulmuş embriyonuz var mı?',
                  child: Row(
                    children: [
                      Text('Evet'),
                      Radio(
                        value: true,
                        groupValue: _haveFrozenEmbryos,
                        onChanged: (bool? value) {
                          setState(() {
                            _haveFrozenEmbryos = value;
                          });
                        },
                      ),
                      Text('Hayır'),
                      Radio(
                        value: false,
                        groupValue: _haveFrozenEmbryos,
                        onChanged: (bool? value) {
                          setState(() {
                            _haveFrozenEmbryos = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              _buildCard(
                title: 'Daha önce uzman tarafından konulmuş teşhisiniz var mı?',
                child: Row(
                  children: [
                    Text('Hayır'),
                    Radio(
                      value: false,
                      groupValue: _havePreviousDiagnosis,
                      onChanged: (bool? value) {
                        setState(() {
                          _havePreviousDiagnosis = value;
                        });
                      },
                    ),
                    Text('Evet'),
                    Radio(
                      value: true,
                      groupValue: _havePreviousDiagnosis,
                      onChanged: (bool? value) {
                        setState(() {
                          _havePreviousDiagnosis = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (_havePreviousDiagnosis == true)
                _buildCard(
                  title: 'Teşhisinizi yazın',
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Teşhis',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _previousDiagnosisText = value;
                    },
                  ),
                ),
              _buildFileUploadCard(),
              _buildCard(
                title:
                    'Tıbbi durumunuzla ilgili bilgi vermek istediğiniz durumlar var mı (ek hastalık, ilaç kullanımı gibi)?',
                child: Row(
                  children: [
                    Text('Hayır'),
                    Radio(
                      value: false,
                      groupValue: _haveAdditionalInformation,
                      onChanged: (bool? value) {
                        setState(() {
                          _haveAdditionalInformation = value;
                        });
                      },
                    ),
                    Text('Evet'),
                    Radio(
                      value: true,
                      groupValue: _haveAdditionalInformation,
                      onChanged: (bool? value) {
                        setState(() {
                          _haveAdditionalInformation = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (_haveAdditionalInformation == true)
                _buildCard(
                  title: 'Ek bilgiler',
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Ek bilgiler',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _additionalInformation = value;
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    // Handle submission or navigate to the next page
                    try {
                      await Provider.of<InVitroFertViewModel>(context,
                              listen: false)
                          .getUserData();
                      await Provider.of<InVitroFertViewModel>(context,
                              listen: false)
                          .inVitro(
                              _hadIVFTreatmentBefore,
                              _additionalInformation,
                              _previousDiagnosisText,
                              _haveAdditionalInformation,
                              _haveFrozenEmbryos,
                              _havePreviousDiagnosis,
                              filePath,
                              picPath);
                      print("inVitro tuşuna basıldı");
                      showDialog(
                        context: context,
                        barrierDismissible: false,  // Dialog dışına tıklanamaz
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),  // Yuvarlak köşeler
                            ),
                            elevation: 16,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,  // İçeriği saran boyut
                                children: <Widget>[
                                  Text(
                                    'İşlem Başarılı',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 20),  // Boşluk
                                  Text(
                                    'İşlem başarılı, ilanınız başarıyla yayınlandı, ilanlarım sayfasından takip edebilirsiniz.',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 20),  // Boşluk
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();  // Dialog'u kapat
                                      Navigator.pushNamed(context, PublicationsScreen.routeName);  // Yeni sayfaya yönlendir
                                    },
                                    child: Text('Tamam'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text('Gönder'),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    // TODO: İlanlarım ikonuna tıklandığında yapılacak işlemler
                    Navigator.pushNamed(context, PublicationsScreen.routeName);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // TODO: Doktor Bul ikonuna tıklandığında yapılacak işlemler
                  },
                ),
              ),
              SizedBox(), // Orta boşluk
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    // TODO: Bildirimler ikonuna tıklandığında yapılacak işlemler
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    // TODO: Profilim ikonuna tıklandığında yapılacak işlemler
                    // Navigator.pushNamed(
                    //     context, "ProfilPage");
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
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            // TODO: İlan Ver butonuna tıklandığında yapılacak işlemler
            //ilanver();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildFileUploadCard() {
    return _buildCard(
      title: 'Dosya Yükleme',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Varsa Tetkik(hormon),rahim filmi ,spermiogram,ultrasonografi sonuçlarını yükleyiniz:',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            icon: Icon(Icons.file_upload),
            label: Text('Dosya Yükleyin'),
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['jpg', 'pdf', 'doc'],
              );

              if (result != null) {
                File file = File(result.files.single.path!);
                // Yüklenen dosyayı işleyin
              } else {
                // Kullanıcı dosya seçimini iptal etti
              }
            },
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            icon: Icon(Icons.camera_alt),
            label: Text('Fotoğraf Yükleyin'),
            onPressed: () async {
              final picker = ImagePicker();
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);

              if (pickedFile != null) {
                File imageFile = File(pickedFile.path);
                // Yüklenen resmi işleyin
              } else {
                // Kullanıcı resim seçimini iptal etti
              }
            },
          ),
        ],
      ),
    );
  }
}
