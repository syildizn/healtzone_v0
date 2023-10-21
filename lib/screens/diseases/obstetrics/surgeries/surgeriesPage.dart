// import 'package:flutter/material.dart';
//
// class Surgeries extends StatefulWidget {
//   static String routeName = "SurgeriesPage";
//   const Surgeries({Key? key}) : super(key: key);
//
//   @override
//   State<Surgeries> createState() => _SurgeriesState();
// }
//
// class _SurgeriesState extends State<Surgeries> {
//   int _currentPage = 1;
//   bool? _hadPreviousSurgery;
//   String? _diagnosis;
//   String? _selectedSurgery;
//   String? _surgeryType;
//   String? _pathologyResults;
//   bool? _hasMedicalInfo;
//   String? _medicalInfo;
//
//   void _nextPage() {
//     setState(() {
//       _currentPage += 1;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ameliyatlar'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           if (_currentPage == 1)
//             Column(
//               children: [
//                 Text('Daha önce ameliyat oldunuz mu?'),
//                 Row(
//                   children: [
//                     Text('Hayır'),
//                     Radio(
//                       value: false,
//                       groupValue: _hadPreviousSurgery,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           _hadPreviousSurgery = value;
//                         });
//                       },
//                     ),
//                     Text('Evet'),
//                     Radio(
//                       value: true,
//                       groupValue: _hadPreviousSurgery,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           _hadPreviousSurgery = value;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//                 if (_hadPreviousSurgery == true)
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Lütfen Ameliyat detaylarını yazınız',
//                     ),
//                   ),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText:
//                         'Kadın Hastalıkları ve Doğum Uzmanı tarafından konulan teşhisinizi yazınız',
//                   ),
//                   onChanged: (value) {
//                     _diagnosis = value;
//                   },
//                 ),
//                 DropdownButton<String>(
//                   value: _selectedSurgery,
//                   items: <String>[
//                     'Histerektomi+ooferektomi (Rahim ve yumurtalık alma ameliyatı)',
//                     'Histerektomi (Rahim alma ameliyatı)',
//                     'Over cerrahisi (yumurtalık kisti veya ooferektomi)',
//                     'Myomektomi (Myom alma ameliyatı)',
//                     'Rahim sarkması ameliyatı',
//                     'İdrar kaçırma ameliyatı',
//                     'Tubaplasti (tüplerin açılması)',
//                     'Tüp ligasyonu (tüplerin bağlanması)',
//                     'Histeroskopi (endometriyal polip, septum veya tanısal amaçlı)',
//                     'Diğer',
//                   ].map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   hint: Text('Ameliyat Seçiniz'),
//                   onChanged: (String? value) {
//                     setState(() {
//                       _selectedSurgery = value;
//                     });
//                   },
//                 ),
//                 if (_selectedSurgery == 'Diğer')
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Lütfen ameliyatı belirtiniz',
//                     ),
//                     onChanged: (value) {
//                       _selectedSurgery = value;
//                     },
//                   ),
//                 DropdownButton<String>(
//                   value: _surgeryType,
//                   items: <String>[
//                     'Açık ameliyat',
//                     'Kapalı (Laparoskopik) ameliyat'
//                   ].map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   hint: Text('Ameliyat Tipi Seçiniz'),
//                   onChanged: (String? value) {
//                     setState(() {
//                       _surgeryType = value;
//                     });
//                   },
//                 ),
//                 ElevatedButton(
//                   onPressed: _nextPage,
//                   child: Text('Diğer Sayfa'),
//                 ),
//               ],
//             ),
//           if (_currentPage == 2)
//             Column(
//               children: [
//                 // Dosya yükleme widget'ını burada ekleyin
//                 Text(
//                     'Varsa servikal smear, rahim içi biyopsi(endometriyal biyopsi) gibi patoloji sonuçlarınızı, tetkik ve ultrasonografi ve MR sonuçlarını yükleyiniz (yükleme yapabileceği yer)'),
//                 ElevatedButton(
//                   onPressed: _nextPage,
//                   child: Text('Diğer Sayfa'),
//                 ),
//               ],
//             ),
//           if (_currentPage == 3)
//             Column(
//               children: [
//                 Text(
//                     'Tıbbi durumunuzla ilgili belirtmek istediğiniz bilgi varsa yazınız'),
//                 Row(
//                   children: [
//                     Text('Yok'),
//                     Radio(
//                       value: false,
//                       groupValue: _hasMedicalInfo,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           _hasMedicalInfo = value;
//                         });
//                       },
//                     ),
//                     Text('Var'),
//                     Radio(
//                       value: true,
//                       groupValue: _hasMedicalInfo,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           _hasMedicalInfo = value;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//                 if (_hasMedicalInfo == true)
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Tıbbi Bilgiler',
//                     ),
//                     onChanged: (value) {
//                       _medicalInfo = value;
//                     },
//                   ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle submission or navigate to the next page
//                   },
//                   child: Text('GÖNDER'),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:healtzone_v0/screens/diseases/obstetrics/surgeries/surgeriesViewModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../homePage/publications.dart';
import '../../../profilPage/profilPage.dart';
import '../../../profilPage/profilPageViewModel.dart';

class Surgeries extends StatefulWidget {
  static String routeName = "SurgeriesPage";
  const Surgeries({Key? key}) : super(key: key);

  @override
  State<Surgeries> createState() => _SurgeriesState();
}

class _SurgeriesState extends State<Surgeries> {
  int _currentPage = 1;
  bool? _hadPreviousSurgery;
  String? _diagnosis;
  String? _selectedSurgery;
  String? _surgeryType;
  String? _pathologyResults;
  bool? _hasMedicalInfo;
  String? _medicalInfo;
  String? picPath;
  String? filePath;

  void _nextPage() {
    setState(() {
      _currentPage += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SurgeriesViewModel>(
      create:(_) => SurgeriesViewModel(),
      builder: (context, _) =>  Scaffold(
        appBar: AppBar(
          title: Text('Ameliyatlar'),
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
              if (_currentPage == 1)
                Column(
                  children: [
                    _buildCard(
                      title: 'Daha önce ameliyat oldunuz mu?',
                      child: Row(
                        children: [
                          Text('Hayır'),
                          Radio(
                            value: false,
                            groupValue: _hadPreviousSurgery,
                            onChanged: (bool? value) {
                              setState(() {
                                _hadPreviousSurgery = value;
                              });
                            },
                          ),
                          Text('Evet'),
                          Radio(
                            value: true,
                            groupValue: _hadPreviousSurgery,
                            onChanged: (bool? value) {
                              setState(() {
                                _hadPreviousSurgery = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    if (_hadPreviousSurgery == true)
                      _buildCard(
                        title: 'Ameliyat Detayları',
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Lütfen Ameliyat detaylarını yazınız',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    _buildCard(
                      title: 'Teşhis',
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText:
                          'Kadın Hastalıkları ve Doğum Uzmanı tarafından konulan teşhisinizi yazınız',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _diagnosis = value;
                        },
                      ),
                    ),
                    _buildCard(
                      title: 'Ameliyat Seçiniz',
                      child: Container(
                        width: double.infinity,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: _selectedSurgery,
                          items: <String>[
                            'Histerektomi+ooferektomi (Rahim ve yumurtalık alma ameliyatı)',
                            'Histerektomi (Rahim alma ameliyatı)',
                            'Over cerrahisi (yumurtalık kisti veya ooferektomi)',
                            'Myomektomi (Myom alma ameliyatı)',
                            'Rahim sarkması ameliyatı',
                            'İdrar kaçırma ameliyatı',
                            'Tubaplasti (tüplerin açılması)',
                            'Tüp ligasyonu (tüplerin bağlanması)',
                            'Histeroskopi (endometriyal polip, septum veya tanısal amaçlı)',
                            // ... other options
                            'Diğer',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: Text('Ameliyat Seçiniz'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedSurgery = value;
                            });
                          },
                        ),
                      ),
                    ),
                    if (_selectedSurgery == 'Diğer')
                      _buildCard(
                        title: 'Diğer Ameliyat',
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Lütfen ameliyatı belirtiniz',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _selectedSurgery = value;
                          },
                        ),
                      ),
                    _buildCard(
                      title: 'Ameliyat Tipi Seçiniz',
                      child: DropdownButtonFormField<String>(
                        value: _surgeryType,
                        items: <String>[
                          'Açık ameliyat',
                          'Kapalı (Laparoskopik) ameliyat'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: Text('Ameliyat Tipi Seçiniz'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _surgeryType = value;
                          });
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
                        onPressed: _nextPage,
                        child: Text('Diğer Sayfa'),
                      ),
                    ),
                  ],
                ),
              if (_currentPage == 2)
                Column(
                  children: [
                    // Dosya yükleme widget'ını burada ekleyin
                    _buildFileUploadCard(),

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
                        onPressed: _nextPage,
                        child: Text('Diğer Sayfa'),
                      ),
                    ),
                  ],
                ),
              if (_currentPage == 3)
                Column(
                  children: [
                    _buildCard(
                      title: 'Tıbbi Bilgiler',
                      child: Column(
                        children: [
                          Text(
                              'Tıbbi durumunuzla ilgili belirtmek istediğiniz bilgi varsa yazınız'),
                          Row(
                            children: [
                              Text('Yok'),
                              Radio(
                                value: false,
                                groupValue: _hasMedicalInfo,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _hasMedicalInfo = value;
                                  });
                                },
                              ),
                              Text('Var'),
                              Radio(
                                value: true,
                                groupValue: _hasMedicalInfo,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _hasMedicalInfo = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          if (_hasMedicalInfo == true)
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Tıbbi Bilgiler',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                _medicalInfo = value;
                              },
                            ),
                        ],
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
                        onPressed: () async{
                          // Handle submission or navigate to the next page
                          try{
                            await Provider.of<SurgeriesViewModel>(context,listen: false).getUserData();
                            await Provider.of<SurgeriesViewModel>(context,listen: false).surgeries(
                                _hadPreviousSurgery,
                                _diagnosis,
                                _medicalInfo,
                                _hasMedicalInfo,
                                _pathologyResults,
                                _selectedSurgery,
                                _surgeryType,
                                filePath,
                                picPath);
                            print("surgeries tuşuna basıldı");
                          }catch(e){
                            print(e.toString());
                          }

                        },
                        child: Text('GÖNDER'),
                      ),
                    ),
                  ],
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
                    Navigator.pushNamed(
                        context, PublicationsScreen.routeName);
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
              SizedBox(),  // Orta boşluk
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
            'Varsa servikal smear, rahim içi biyopsi(endometriyal biyopsi) gibi patoloji sonuçlarınızı, tetkik ve ultrasonografi ve MR sonuçlarını yükleyiniz:',
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
