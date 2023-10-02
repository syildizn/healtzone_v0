import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: () {
                  // Handle submission or navigate to the next page
                },
                child: Text('Gönder'),
              ),
            ),
          ],
        ),
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
              final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);


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