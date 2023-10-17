import 'package:flutter/material.dart';

class PregnancyAndBirth extends StatefulWidget {
  static String routeName = "PregnancyAndBirthPage";
  const PregnancyAndBirth({Key? key}) : super(key: key);

  @override
  State<PregnancyAndBirth> createState() => _PregnancyAndBirthState();
}

class _PregnancyAndBirthState extends State<PregnancyAndBirth> {
  bool? _hadPreviousDelivery;
  String? _deliveryMethod;
  String _pregnancyWeek = '';
  bool? _anyConcerns;
  String _concernsText = '';
  String? _serviceRequired;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gebelik Takibi Ve Doğum'),
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
              title: 'Daha önce doğum yaptınız mı?',
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Evet'),
                      Radio(
                        value: true,
                        groupValue: _hadPreviousDelivery,
                        onChanged: (bool? value) {
                          setState(() {
                            _hadPreviousDelivery = value;
                          });
                        },
                      ),
                      Text('Hayır'),
                      Radio(
                        value: false,
                        groupValue: _hadPreviousDelivery,
                        onChanged: (bool? value) {
                          setState(() {
                            _hadPreviousDelivery = value;
                          });
                        },
                      ),
                    ],
                  ),
                  if (_hadPreviousDelivery == true)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Normal Doğum mu Sezeryan mı?'),
                        Row(
                          children: [
                            Text('Normal Doğum'),
                            Radio(
                              value: 'Normal Doğum',
                              groupValue: _deliveryMethod,
                              onChanged: (String? value) {
                                setState(() {
                                  _deliveryMethod = value;
                                });
                              },
                            ),
                            Text('Sezeryan'),
                            Radio(
                              value: 'Sezeryan',
                              groupValue: _deliveryMethod,
                              onChanged: (String? value) {
                                setState(() {
                                  _deliveryMethod = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
            _buildCard(
              title: 'Gebeliğinizin kaçıncı haftasındasınız?',
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Örneğin: 23. hafta',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _pregnancyWeek = value;
                },
              ),
            ),
            _buildCard(
              title:
                  'Gebeliğiniz ile ilgili belirtmek istediğiniz bir durum var mı?',
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Hayır'),
                      Radio(
                        value: false,
                        groupValue: _anyConcerns,
                        onChanged: (bool? value) {
                          setState(() {
                            _anyConcerns = value;
                          });
                        },
                      ),
                      Text('Evet'),
                      Radio(
                        value: true,
                        groupValue: _anyConcerns,
                        onChanged: (bool? value) {
                          setState(() {
                            _anyConcerns = value;
                          });
                        },
                      ),
                    ],
                  ),
                  if (_anyConcerns == true)
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Lütfen durumunuzu belirtiniz',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _concernsText = value;
                      },
                    ),
                ],
              ),
            ),
            _buildCard(
              title: 'İhtiyacınız olan hizmet hangisidir?',
              child: DropdownButton<String>(
                value: _serviceRequired,
                items: [
                  DropdownMenuItem(
                    value: 'Gebelik Takibi',
                    child: Text('Gebelik Takibi'),
                  ),
                  DropdownMenuItem(
                    value: 'Doğum',
                    child: Text('Doğum'),
                  ),
                ],
                hint: Text('Seçiniz'),
                onChanged: (String? value) {
                  setState(() {
                    _serviceRequired = value;
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
}
