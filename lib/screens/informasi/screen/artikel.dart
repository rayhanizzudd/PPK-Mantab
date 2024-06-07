import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:flutter/material.dart';

class Artikel extends StatelessWidget {
  final String imageUrl; // Tambahkan parameter imageUrl
  final String judulArtikel;

  Artikel({
    required this.imageUrl,
    required this.judulArtikel,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: -30,
            left: 0,
            child: Image.network(
              imageUrl,
              width: 430,
              height: 341.5,
              // fit: BoxFit.cover,
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
                  onTap: () {},
                  child: Image.asset(
                    'lib/images/back.png', // Ganti dengan path gambar Anda
                    width: 24, // Sesuaikan ukuran gambar dengan kebutuhan Anda
                    height: 24,
                  ),
                ),
                SizedBox(height: 10), // Spacer antara gambar dan teks
              ],
            ),
          ),

          Positioned(
            top: 320, // Atur posisi teks header di sini
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  judulArtikel,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 400, // Atur posisi box di sini
            left: 20,
            right: 20,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1, // Atur blurRadius kecil
                    offset: Offset(0,1), // Offset ke bawah untuk shadow hanya muncul di atas
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1, // Atur blurRadius kecil
                    offset: Offset(0,-1), // Offset ke atas untuk shadow hanya muncul di bawah
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1, // Atur blurRadius kecil
                    offset: Offset(-1,
                        0), // Offset ke kiri untuk shadow hanya muncul di kanan
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1, // Atur blurRadius kecil
                    offset: Offset(1,
                        0), // Offset ke kanan untuk shadow hanya muncul di kiri
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('informasi')
                      .where('judul', isEqualTo: judulArtikel)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('Artikel tidak ditemukan'));
                    } else {
                      var data = snapshot.data!.docs.first.data()
                          as Map<String, dynamic>;
                      var isiArtikel = data['artikel'] as String;
                      return Text(
                        isiArtikel,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: navigasi(),
    );
  }
}
