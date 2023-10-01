
import 'package:flutter/material.dart';

class DetailedUltrasound extends StatefulWidget {
  static String routeName = "DetailedUltrasoundPage";
  const DetailedUltrasound({Key? key}) : super(key: key);

  @override
  State<DetailedUltrasound> createState() => _DetailedUltrasoundState();
}

class _DetailedUltrasoundState extends State<DetailedUltrasound> {
  String _pregnancyWeek = '';
  bool? _hadPreviousIssues;
  String _previousIssuesText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayrıntılı Ultrasonografi ',),
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
              title: 'Bilgilendirme',
              child: Text(
                'Ayrıntılı Ultrasonografi (Fetal Anomali Taraması) gebeliğin 18-23. haftaları arasında yapılmaktadır ',
                style: TextStyle(
                  fontStyle: FontStyle.normal,fontSize: 16
                ),
              ),
            ),
            _buildCard(
              title: 'Kaçıncı gebelik haftasındasınız? (Örneğin: 21. hafta)',
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Gebelik Haftası',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _pregnancyWeek = value;
                },
              ),
            ),
            _buildCard(
              title: 'Şimdiki yada daha önceki gebeliğinizde herhangi bir sorun yaşadınızmı?',
              child: Row(
                children: [
                  Text('Hayır'),
                  Radio(
                    value: false,
                    groupValue: _hadPreviousIssues,
                    onChanged: (bool? value) {
                      setState(() {
                        _hadPreviousIssues = value;
                      });
                    },
                  ),
                  Text('Evet'),
                  Radio(
                    value: true,
                    groupValue: _hadPreviousIssues,
                    onChanged: (bool? value) {
                      setState(() {
                        _hadPreviousIssues = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            if (_hadPreviousIssues == true)
              _buildCard(
                title: 'Lütfen sorunları belirtin',
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Sorunlar',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _previousIssuesText = value;
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
