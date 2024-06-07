import 'package:first/screens/login/views/login.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:first/screens/profile/screen/halamanubahpassword.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HalamanProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

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
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'lib/images/bgbatik.png'), // Ubah dengan path gambar background Anda
                      fit: BoxFit.cover, // Sesuaikan gambar dengan container
                    ),
                  ),
                  height: constraints.maxHeight * 0.4, // 1/3 dari tinggi layar
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Halaman Profil',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(49, 52, 19, 1),
                          ),
                        ),
                        const SizedBox(
                            height: 30), // Jarak antara teks dan gambar
                        Image.asset(
                          'lib/images/PP.png', // Ubah dengan path gambar Anda
                          width: 100, // Sesuaikan dengan ukuran gambar Anda
                          height: 100, // Sesuaikan dengan ukuran gambar Anda
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 70, // Menggeser tombol ke atas
                  left: 20, // Menggeser tombol ke kiri
                  right: 20, // Menggeser tombol ke kanan
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                bottom: 10), // Tambahkan margin bawah
                            child: Text(
                              'Nama',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(117, 117, 117, 1),
                              ),
                            ),
                          ),
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }
                              var userData = snapshot.data!.data()
                                  as Map<String, dynamic>?;

                              if (userData != null) {
                                return Container(
                                  height: 55, // Atur tinggi container
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 158, 158, 158)
                                            .withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Text(
                                      userData['nama'],
                                      style: TextStyle(
                                        color: Color.fromRGBO(117, 117, 117, 1),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Text('Data tidak tersedia');
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                bottom: 10), // Tambahkan margin bawah
                            child: Text(
                              'Nomor Anggota Kelompok',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(117, 117, 117, 1),
                              ),
                            ),
                          ),
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }
                              var userData = snapshot.data!.data()
                                  as Map<String, dynamic>?;

                              if (userData != null) {
                                return Container(
                                  height: 55, // Atur tinggi container
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 158, 158, 158)
                                            .withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Text(
                                      userData['nomorAnggota'].toString(),
                                      style: TextStyle(
                                        color: Color.fromRGBO(117, 117, 117, 1),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Text('Data tidak tersedia');
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ), // Mengurangi jarak antara tombol
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 20, // Menggeser tombol ke kiri
                      right: 20,
                      bottom: 100 // Menggeser tombol ke kanan
                      ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .end, // Letakkan konten di bagian bawah
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangePassword()),
                                  );
                                },
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(180, 60)), // Ukuran minimum tombol
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                      EdgeInsets.all(12)), // Padding tombol
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(0, 163, 255, 1)),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Atur border radius di sini
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Ubah Kata Sandi',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          18 // Ubah warna teks menjadi putih
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              OutlinedButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance
                                      .signOut(); // Logout dari Firebase Auth
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  );
                                },
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(180, 60)), // Ukuran minimum tombol
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                      EdgeInsets.all(12)), // Padding tombol
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(255, 0, 0, 1)),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Atur border radius di sini
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Keluar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          18 // Ubah warna teks menjadi putih
                                      ),
                                ),
                              )
                            ],
                          ),
                        )
                      ]))
            ],
          );
        },
      ),
      bottomNavigationBar: navigasi(),
    );
  }
}
