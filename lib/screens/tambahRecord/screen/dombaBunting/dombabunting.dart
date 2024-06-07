import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:flutter/material.dart';

class DombaHamil extends StatefulWidget {
  @override
  _DombaHamilState createState() => _DombaHamilState();
}

class _DombaHamilState extends State<DombaHamil> {
  String? selectedKodeDomba;
  DateTime? _selectedDate;
  User? user = FirebaseAuth.instance.currentUser;
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
                    'Domba Bunting',
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
                          'Kode Domba Betina',
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
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('domba')
                            .doc(user!.uid)
                            .collection('dataDomba')
                            .where('jenisKelamin',
                                isEqualTo: 'SQ7e1oe2XtoQCQRYOQXe')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }

                          var dropdownItems = snapshot.data!.docs
                              .map((doc) => DropdownMenuItem<String>(
                                    value: doc['kodeDomba'],
                                    child: Text(doc['kodeDomba']),
                                  ))
                              .toList();

                          return DropdownButton<String>(
                            value: selectedKodeDomba,
                            hint: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Pilih Kode Domba Betina',
                                style: TextStyle(
                                  color: Color.fromRGBO(117, 117, 117, 1),
                                ),
                              ),
                            ),
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 36,
                            isExpanded: true,
                            underline: SizedBox(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedKodeDomba = newValue;
                              });
                            },
                            items: dropdownItems,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10), // Tambahkan margin bawah
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Tanggal Mulai Bunting',
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
                      child: GestureDetector(
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2025),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                _tanggalText(),
                                style: TextStyle(
                                  color: Color.fromRGBO(117, 117, 117, 1),
                                ),
                              ),
                            ),
                            Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),

          // Tombol Simpan
          Positioned(
            top: 400,
            left: 40,
            right: 40,
            child: ElevatedButton(
              onPressed: () {
                _saveDataToFirestore();
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(180, 60)), // Ukuran minimum tombol
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(12)), // Padding tombol
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(104, 119, 68, 1)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Atur border radius di sini
                  ),
                ),
              ),
              child: Text(
                'Tambah',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18 // Ubah warna teks menjadi putih
                    ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: navigasi(),
    );
  }
  String _tanggalText() {
    if (_selectedDate != null) {
      return '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
    } else {
      return 'Pilih Tanggal';
    }
  }
  void _saveDataToFirestore() {
    String? kodeDomba = selectedKodeDomba;
    DateTime? tanggalBunting = _selectedDate;

    Map<String, dynamic> dataBunting= {
      'kodeDomba': kodeDomba,
      'tanggalBunting': tanggalBunting,
    };

    FirebaseFirestore.instance
        .collection('record_bunting')
        .doc(user!.uid)
        .collection('dataBunting')
        .add(dataBunting)
        .then((value) {
      print('Data berhasil disimpan ke Firestore');
      Navigator.pop(context);
    }).catchError((error) {
      print('Error: $error');
    });
  }
}
