import 'package:flutter/material.dart';
import 'package:heroapp/management/hobby_management.dart';
import 'package:heroapp/models/hobby_class.dart';
import 'package:uuid/uuid.dart';

class HobiScreen extends StatefulWidget {
  @override
  _HobiScreenState createState() => _HobiScreenState();
}

class _HobiScreenState extends State<HobiScreen> {
  final TextEditingController _hobiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    HobiYonetimi.init();
  }

  void _showEditDialog(Hobi hobi) {
    _hobiController.text = hobi.isim;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hobi Düzenle'),
        content: TextField(
          controller: _hobiController,
          decoration: InputDecoration(hintText: "Hobi adını girin"),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('İptal'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Kaydet'),
            onPressed: () {
              var yeniIsim = _hobiController.text;
              if (yeniIsim.isNotEmpty) {
                HobiYonetimi.updateHobi(Hobi(id: hobi.id, isim: yeniIsim));
                setState(() {});
                Navigator.of(context).pop();
                _hobiController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Hobi> hobiler = HobiYonetimi.getHobiler();

    return Scaffold(
      appBar: AppBar(
        title: Text('Hobilerim'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _hobiController,
              decoration: InputDecoration(
                labelText: 'Yeni Hobi',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    final String yeniHobi = _hobiController.text;
                    if (yeniHobi.isNotEmpty) {
                      HobiYonetimi.addHobi(
                          Hobi(id: Uuid().v4(), isim: yeniHobi));
                      setState(() {});
                      _hobiController.clear();
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: hobiler.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(hobiler[index].isim),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showEditDialog(hobiler[index]),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          HobiYonetimi.removeHobi(hobiler[index].id);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
