import 'package:first/screens/login/views/login.dart';
import 'package:first/screens/register/views/registrasi.dart';
import 'package:flutter/material.dart';

class LogRegPage extends StatelessWidget {
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
                  height: constraints.maxHeight * 0.33, // 1/3 dari tinggi layar
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 42), // Tambahkan padding horizontal
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Geser teks ke kiri
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0), // Tambahkan padding bawah
                            child: Text(
                              'Selamat datang di MANTAB!',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'Aplikasi berbasis mobile untuk memanajemen pemeliharaan dan ransum ternak domba.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10, // Menggeser tombol ke atas
                  left: 20, // Menggeser tombol ke kiri
                  right: 20, // Menggeser tombol ke kanan
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/images/logo.png', // Ubah dengan path gambar logo Anda
                      width: 250,
                      height: 150,
                    ),
                    SizedBox(
                      height: 10, // Mengurangi jarak antara logo dan tombol
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(180, 50)), // Ukuran minimum tombol
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.all(12)), // Padding tombol
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(78, 59, 33, 1)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Atur border radius di sini
                                ),
                              ),
                            ),
                            child: Text(
                              'Masuk',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16 // Ubah warna teks menjadi putih
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ), // Mengurangi jarak antara tombol
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegistrationPage(),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(180, 50)), // Ukuran minimum tombol
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
                                  fontSize: 16 // Ubah warna teks menjadi putih
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
