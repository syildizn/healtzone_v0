import 'package:flutter/material.dart';

class GenitalAesthetics extends StatefulWidget {
  static String routeName = "GenitalAestheticsPage";
  const GenitalAesthetics({Key? key}) : super(key: key);

  @override
  State<GenitalAesthetics> createState() => _GenitalAestheticsState();
}

class _GenitalAestheticsState extends State<GenitalAesthetics> {
  bool? _hadPreviousSurgery;
  bool? _hadProfessionalExamination;
  String? _recommendedProcedure;
  String? _desiredProcedure;
  String? _otherProcedure;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genital Estetik'),
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
              title: 'Daha önce genital estetik ameliyatı oldunuz mu?',
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
                title: 'Lütfen detayları belirtin',
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Detaylar',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // ...
                  },
                ),
              ),
            _buildCard(
              title: 'Daha önce uzman tarafından muayene olduysanız önerilen genital estetik işlemi var mı?',
              child: Row(
                children: [
                  Text('Hayır'),
                  Radio(
                    value: false,
                    groupValue: _hadProfessionalExamination,
                    onChanged: (bool? value) {
                      setState(() {
                        _hadProfessionalExamination = value;
                      });
                    },
                  ),
                  Text('Evet'),
                  Radio(
                    value: true,
                    groupValue: _hadProfessionalExamination,
                    onChanged: (bool? value) {
                      setState(() {
                        _hadProfessionalExamination = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            if (_hadProfessionalExamination == true)
              _buildCard(
                title: 'Önerilen işlemi belirtin',
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Önerilen İşlem',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _recommendedProcedure = value;
                  },
                ),
              ),
            _buildCard(
              title: 'İstediğiniz genital estetik işlemi hangisidir?',
              child: DropdownButton<String>(
                value: _desiredProcedure,
                items: [
                  DropdownMenuItem(
                    value: 'Labioplasti',
                    child: Text('Labioplasti'),
                  ),
                  DropdownMenuItem(
                    value: 'Klitoris Estetiği',
                    child: Text('Klitoris Estetiği'),
                  ),
                  DropdownMenuItem(
                    value: 'Vajen daraltma',
                    child: Text('Vajen daraltma'),
                  ), DropdownMenuItem(
                    value: 'Vulva Beyazlatma',
                    child: Text('Vulva Beyazlatma'),
                  ), DropdownMenuItem(
                    value: 'Hymenoplasti (Kızlık zarı dikimi)',
                    child: Text('Hymenoplasti (Kızlık zarı dikimi)'),
                  ), DropdownMenuItem(
                    value: 'Doğum izi düzeltilmesi',
                    child: Text('Doğum izi düzeltilmesi'),
                  ),
                  DropdownMenuItem(
                    value: 'Diğer',
                    child: Text('Diğer'),
                  ),
                ],
                hint: Text('Seçiniz'),
                onChanged: (String? value) {
                  setState(() {
                    _desiredProcedure = value;
                    if (value == 'Diğer') {
                      _otherProcedure = '';  // Reset the otherProcedure field for user input
                    }
                  });
                },
              ),
            ),
            if (_desiredProcedure == 'Diğer')
              _buildCard(
                title: 'Lütfen diğer işlemi belirtin',
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Diğer İşlem',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _otherProcedure = value;
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
