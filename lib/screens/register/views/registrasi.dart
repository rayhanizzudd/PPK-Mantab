import 'package:first/screens/login/views/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nomorAnggotaController = TextEditingController();
  final TextEditingController kataSandiController = TextEditingController();

  Future<void> _register(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: '${nomorAnggotaController.text}@yourdomain.com',
        password: kataSandiController.text,
      );

      if (userCredential.user != null) {
        String nama = namaController.text;
        int nomorAnggota = int.parse(nomorAnggotaController.text) ;
        String userId = userCredential.user!.uid;

        // Membuat batch write
        WriteBatch batch = firestore.batch();

        // Menambahkan userId ke semua tabel
        List<String> tables = [
          'domba',
          'jenis_informasi',
          'jenis_kelamin',
          'record_beranak',
          'record_bunting',
          'record_kawin',
        ];

        tables.forEach((table) {
          batch.set(
            firestore.collection(table).doc(userId),
            {'userId': userId},
            SetOptions(
                merge:
                    true), // Gunakan opsi merge untuk memperbarui atau menambahkan data
          );
        });

        batch.set(
          firestore.collection('users').doc(userId),
          {'userId': userId, 'nama': nama, 'nomorAnggota' : nomorAnggota},
          SetOptions(
              merge:
                  true), // Gunakan opsi merge untuk memperbarui atau menambahkan data
        );

        // Jalankan batch write
        await batch.commit();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'lib/images/bglogreg.png'), // Ubah dengan path gambar background Anda
                      fit: BoxFit.cover, // Sesuaikan gambar dengan container
                    ),
                  ),
                  height: constraints.maxHeight * 0.3, // 1/3 dari tinggi layar
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Halaman Daftar',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 160, // Menggeser tombol ke atas
                  left: 20, // Menggeser tombol ke kiri
                  right: 20, // Menggeser tombol ke kanan
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/images/Logo.png', // Ubah dengan path gambar logo Anda
                      width: 250,
                      height: 150,
                    ),
                    SizedBox(
                      height: 10, // Mengurangi jarak antara logo dan tombol
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10), // Tambahkan margin bawah
                            child: Text(
                              'Nama',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(117, 117, 117, 1)),
                            ),
                          ),
                          Container(
                            height: 55, // Atur tinggi container
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 158, 158, 158)
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
                                    controller: namaController,
                                    decoration: InputDecoration(
                                        hintText: 'Nama',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        isDense: true,
                                        alignLabelWithHint: true,
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                117, 117, 117, 100))),
                                    textAlign: TextAlign
                                        .left, // Teks dalam TextField menjadi rata kiri
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
                                bottom: 10), // Tambahkan margin bawah
                            child: Text(
                              'Nomor Anggota Kelompok',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(117, 117, 117, 1)),
                            ),
                          ),
                          Container(
                            height: 55, // Atur tinggi container
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 158, 158, 158)
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
                                    controller: nomorAnggotaController,
                                    decoration: InputDecoration(
                                        hintText: 'Nomor Anggota Kelompok',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        isDense: true,
                                        alignLabelWithHint: true,
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                117, 117, 117, 100))),
                                    textAlign: TextAlign
                                        .left, // Teks dalam TextField menjadi rata kiri
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
                                bottom: 10), // Tambahkan margin bawah
                            child: Text(
                              'Kata Sandi',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(117, 117, 117, 1)),
                            ),
                          ),
                          Container(
                            height: 55, // Atur tinggi container
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 158, 158, 158)
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
                                    controller: kataSandiController,
                                    decoration: InputDecoration(
                                        hintText: 'Kata Sandi',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        isDense: true,
                                        alignLabelWithHint: true,
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                117, 117, 117, 100))),
                                    textAlign: TextAlign
                                        .left, // Teks dalam TextField menjadi rata kiri
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              _register(
                                  context); // Panggil fungsi pendaftaran saat tombol ditekan
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(180, 60)), // Ukuran minimum tombol
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.all(12)), // Padding tombol
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(104, 119, 68, 1)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Atur border radius di sini
                                ),
                              ),
                            ),
                            child: Text(
                              'Daftar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18 // Ubah warna teks menjadi putih
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
