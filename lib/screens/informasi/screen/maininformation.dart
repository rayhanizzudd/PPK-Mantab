import 'package:first/screens/informasi/screen/artikel.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
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

              // Content
              Positioned(
                top: 20,
                left: 0,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Halaman Informasi',
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
                top: 100,
                left: 0,
                right: 0,
                bottom: 0,
                child: FutureBuilder(
                  future:
                      FirebaseFirestore.instance.collection('informasi').get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      var documents = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          var judul = documents[index]['judul'];
                          var imageUrl = documents[index]['imageUrl'];
                          return _buildArticle(context, imageUrl, judul);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: navigasi(),
    );
  }

  Widget _buildArticle(BuildContext context, String imageUrl, String judul) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Artikel(
                  imageUrl: imageUrl,
                  judulArtikel: judul,)), // Tambahkan parameter),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            FutureBuilder(
              future: FirebaseStorage.instance.ref(imageUrl).getDownloadURL(),
              builder:
                  (BuildContext context, AsyncSnapshot<String> urlSnapshot) {
                if (urlSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (urlSnapshot.hasError) {
                  print('Error fetching image URL: ${urlSnapshot.error}');
                  return Center(child: Text('Error fetching image'));
                } else if (urlSnapshot.data == null) {
                  print('Image URL is null');
                  return Center(child: Text('Image URL is null'));
                } else {
                  return Image.network(
                    urlSnapshot.data!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  );
                }
              },
            ),
            SizedBox(height: 10),
            Text(
              judul,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
