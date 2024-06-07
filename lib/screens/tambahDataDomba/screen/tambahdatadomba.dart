import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateData extends StatefulWidget {
  @override
  _CreateDataState createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  String? jenisKelamin; // Menyimpan nilai jenis kelamin yang dipilih

  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController bobotController = TextEditingController();
  final TextEditingController umurController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'lib/images/bgbatik.png',
              width: 430,
              height: 341.5,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 20, // Atur posisi teks header di sini
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'lib/images/back.png', // Ganti dengan path gambar Anda
                    width: 24, // Sesuaikan ukuran gambar dengan kebutuhan Anda
                    height: 24,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Tambah Data Domba',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 100, // Atur posisi kotak informasi domba di sini
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color:
                        Color.fromRGBO(104, 119, 69, 1)), // Warna outline hijau
                color: Colors.white, // Warna latar belakang putih
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10), // Tambahkan margin bawah
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Kode Domba',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(117, 117, 117, 1)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 55, // Atur tinggi container
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 158, 158, 158)
                              .withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Colors.white, // Warna latar belakang putih
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: kodeController,
                            decoration: InputDecoration(
                                hintText: 'Kode',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                isDense: true,
                                alignLabelWithHint: true,
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(117, 117, 117, 100))),
                            textAlign: TextAlign
                                .left, // Teks dalam TextField menjadi rata kiri
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10), // Tambahkan margin bawah
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Bobot Domba (Kg)',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(117, 117, 117, 1)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 55, // Atur tinggi container
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 158, 158, 158)
                              .withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Colors.white, // Warna latar belakang putih
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: bobotController,
                            decoration: InputDecoration(
                                hintText: 'Bobot',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                isDense: true,
                                alignLabelWithHint: true,
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(117, 117, 117, 100))),
                            textAlign: TextAlign
                                .left, // Teks dalam TextField menjadi rata kiri
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10), // Tambahkan margin bawah
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Umur Domba (Bulan)',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(117, 117, 117, 1)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 55, // Atur tinggi container
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 158, 158, 158)
                              .withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Colors.white, // Warna latar belakang putih
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: umurController,
                            decoration: InputDecoration(
                                hintText: 'Umur',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                isDense: true,
                                alignLabelWithHint: true,
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(117, 117, 117, 100))),
                            textAlign: TextAlign
                                .left, // Teks dalam TextField menjadi rata kiri
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10), // Tambahkan margin bawah
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Jenis Kelamin Domba',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(117, 117, 117, 1)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 55, 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 158, 158, 158)
                              .withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Colors.white, // Warna latar belakang putih
                    ),
                    child: Center(
                      child: DropdownButton<String>(
                        value: jenisKelamin, // Nilai yang dipilih
                        hint: Text('Pilih Jenis Kelamin'),
                        onChanged: (String? newValue) {
                          setState(() {
                            jenisKelamin = newValue;
                          });
                        },
                        items: <String>['Jantan', 'Betina'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tombol Simpan
          Positioned(
            top: 600,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                _saveDataToFirestore();
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(180, 60)), 
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(12)), 
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(104, 119, 68, 1)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),
              ),
              child: Text(
                'Tambah Data Domba',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18 
                    ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: navigasi(),
    );
  }
  void _saveDataToFirestore() {
    
    String kodeDomba = kodeController.text.trim();
    String bobotDomba = bobotController.text.trim();
    String umurDomba = umurController.text.trim();
    String idDomba = '';
    if (jenisKelamin == 'Jantan') {
      idDomba = "SQ7e1oe2XtoQCQRYOQXe";
    } else if (jenisKelamin == 'Betina') {
      idDomba = "MJdiCLP726Un0p4A8vu2";
    }
    
    Map<String, dynamic> dataDomba = {
      'kodeDomba': kodeDomba,
      'bobotDomba': bobotDomba,
      'umurDomba': umurDomba,
      'jenisKelamin': idDomba,
    };

    
    FirebaseFirestore.instance
        .collection('domba') 
        .doc(user!.uid) 
        .collection('dataDomba')
        .add(dataDomba) 
        .then((value) {
      print('Data berhasil disimpan ke Firestore');
      Navigator.pop(context);
    })
    .catchError((error) {
      print('Error: $error');
    });
  }
}
