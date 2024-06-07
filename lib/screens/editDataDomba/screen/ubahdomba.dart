import 'package:first/screens/navigasi/navigasi.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateDomba extends StatefulWidget {
  @override
  _UpdateDombaState createState() => _UpdateDombaState();
}

// ignore: must_be_immutable
class _UpdateDombaState extends State<UpdateDomba> {
  String?
      selectedKodeDomba; // Variabel untuk menyimpan nilai yang dipilih dari dropdown
  String? bobotSebelumnya;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

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
                    'Ubah Data Domba',
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
                  color: Color.fromRGBO(104, 119, 69, 1),
                ), // Warna outline hijau
                color: Colors.white, // Warna latar belakang putih
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('domba')
                        .doc(user!.uid)
                        .collection('dataDomba')
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Pilih Kode',
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
                            selectedKodeDomba =
                                newValue; 
                            _getBobotSebelumnya(newValue);
                          });
                        },
                        items: dropdownItems,
                      );
                    },
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ), // Tambahkan margin bawah
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Bobot Domba Sebelumnya (Kg)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(117, 117, 117, 1),
                          ),
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
                          Text(
                            bobotSebelumnya ??
                                '', // Tampilkan bobot sebelumnya pada TextField
                            style: TextStyle(
                              color: Color.fromRGBO(117, 117, 117, 100),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ), // Tambahkan margin bawah
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Bobot Domba Sekarang (Kg)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(117, 117, 117, 1),
                          ),
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
                            controller: textEditingController,
                            decoration: InputDecoration(
                              hintText: 'Bobot',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              isDense: true,
                              alignLabelWithHint: true,
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(117, 117, 117, 100),
                              ),
                            ),
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
                ],
              ),
            ),
          ),

          // Tombol Simpan
          Positioned(
            top: 500,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                _updateDataDomba(context);
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(180, 60),
                ), // Ukuran minimum tombol
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.all(12),
                ), // Padding tombol
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(104, 119, 68, 1),
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: Text(
                'Ubah Data Domba',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: navigasi(),
    );
  }

  void _getBobotSebelumnya(String? kodeDomba) {
    User? user = FirebaseAuth.instance.currentUser;

    if (kodeDomba != null) {
      FirebaseFirestore.instance
          .collection('domba')
          .doc(user!.uid)
          .collection('dataDomba')
          .where('kodeDomba',
              isEqualTo: kodeDomba) // Filter data berdasarkan kodeDomba
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          var bobotDomba = querySnapshot.docs
              .first['bobotDomba']; // Ambil bobot sebelumnya dari Firestore
          setState(() {
            bobotSebelumnya =
                bobotDomba.toString(); // Ubah bobotDomba ke dalam bentuk string
          });
        } else {
          setState(() {
            bobotSebelumnya = 'Data tidak ditemukan';
          });
        }
      }).catchError((error) {
        setState(() {
          bobotSebelumnya = 'Error: $error';
        });
      });
    }
  }


  void _updateDataDomba(BuildContext context) {
  User? user = FirebaseAuth.instance.currentUser;
   String bobotDombaSekarang = textEditingController.text;

  if (selectedKodeDomba != null) {
    FirebaseFirestore.instance
        .collection('domba')
        .doc(user!.uid)
        .collection('dataDomba')
        .where('kodeDomba', isEqualTo: selectedKodeDomba)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var docId = querySnapshot.docs.first.id; // Ambil id dokumen
        FirebaseFirestore.instance
            .collection('domba')
            .doc(user.uid)
            .collection('dataDomba')
            .doc(docId)
            .update({
          'bobotDomba': bobotDombaSekarang
          // Ganti 'bobotDombaSekarang' dengan nama field untuk bobot domba yang akan diupdate
        }).then((_) {
          // Jika update berhasil, tampilkan pesan sukses dan kembali ke halaman sebelumnya
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Data domba berhasil diubah'),
            duration: Duration(seconds: 2),
          ));
          Navigator.pop(context);
        }).catchError((error) {
          // Jika terjadi error saat update, tampilkan pesan error
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: $error'),
            duration: Duration(seconds: 2),
          ));
        });
      } else {
        // Jika data tidak ditemukan, tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Data domba tidak ditemukan'),
          duration: Duration(seconds: 2),
        ));
      }
    }).catchError((error) {
      // Jika terjadi error saat mengambil data, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $error'),
        duration: Duration(seconds: 2),
      ));
    });
  } else {
    // Jika kode domba tidak dipilih, tampilkan pesan error
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Pilih kode domba terlebih dahulu'),
      duration: Duration(seconds: 2),
    ));
  }
}

}
