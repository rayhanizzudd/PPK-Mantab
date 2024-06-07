import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:first/screens/tambahDataDomba/screen/tambahdatadomba.dart';
import 'package:first/screens/editDataDomba/screen/ubahdomba.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateDomba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Stack(
        children: [
          // Background Batik
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
            top: 25,
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
                    'lib/images/back.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          // Title and button
          Positioned(
            top: 70,
            left: 15,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Data Domba',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => CreateData()),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                          Size(190, 55),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.all(12),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(0, 163, 255, 1),
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(15),
                        shadowColor: MaterialStateProperty.all<Color>(
                          Colors.black.withOpacity(1),
                        ),
                      ),
                      child: Text(
                        'Tambah',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateDomba(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                          Size(190, 55),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.all(12),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(0, 163, 255, 1),
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(15),
                        shadowColor: MaterialStateProperty.all<Color>(
                          Colors.black.withOpacity(1),
                        ),
                      ),
                      child: Text(
                        'Ubah',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            top: 180,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color.fromRGBO(78, 59, 33, 1)),
                color: Colors.white,
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('domba')
                    .doc(user!.uid)
                    .collection('dataDomba')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return Text('No data available');
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Domba saat ini',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(117, 117, 117, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNumberBox(
                              snapshot.data!.docs
                                  .where((doc) =>
                                      doc['jenisKelamin'] ==
                                      'SQ7e1oe2XtoQCQRYOQXe')
                                  .length
                                  .toString(),
                              'Jantan'),
                          _buildNumberBox(
                              snapshot.data!.docs
                                  .where((doc) =>
                                      doc['jenisKelamin'] ==
                                      'MJdiCLP726Un0p4A8vu2')
                                  .length
                                  .toString(),
                              'Betina'),
                          _buildNumberBox(
                              snapshot.data!.docs
                                  .where((doc) => int.parse(doc['umurDomba']) < 13)
                                  .length
                                  .toString(),
                              'Anakan'),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          // Scrollable content
          Positioned(
            top: 350,
            left: -15,
            right: -15,
            bottom: 50,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('domba')
                          .doc(user.uid)
                          .collection('dataDomba')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        if (snapshot.data!.docs.isEmpty) {
                          return Text('No data available');
                        }

                        // Sort the list of documents based on 'kodeDomba'
                        List<DocumentSnapshot> sortedDocs = snapshot.data!.docs;
                        sortedDocs.sort(
                            (a, b) => a['kodeDomba'].compareTo(b['kodeDomba']));

                        return Column(
                          children: sortedDocs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return Column(
                              children: [
                                _buildItem(
                                  title:
                                      'Bobot : ${data['bobotDomba']}, Umur : ${data['umurDomba']}, Jenis Kelamin : ${data['jenisKelamin']}',
                                  kodeDomba: data['kodeDomba'],
                                  result1: data[
                                      'bobotDomba'], // Specific weight value
                                  result2:
                                      data['umurDomba'], // Specific age value
                                  result3: data[
                                      'jenisKelamin'], // Specific gender value
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: navigasi(),
    );
  }

  Widget _buildItem({
    required String title,
    required String kodeDomba, // Kode domba
    required String result1, // Weight
    required String result2, // Age
    required String result3, // Gender
  }) {
    bool isJantan = result3 == 'SQ7e1oe2XtoQCQRYOQXe';
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 7,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                kodeDomba, // Kode domba
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(width: 20), // Spasi antara kode domba dan judul
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bobot : $result1', // Specific weight value
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                Text(
                  'Umur : $result2', // Specific age value
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                Text(
                  'Jenis Kelamin : ${isJantan ? 'Jantan' : 'Betina'}', // Tampilkan Jantan/Betina sesuai jenis kelamin
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberBox(String number, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Color.fromRGBO(254, 203, 1, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 0),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(117, 117, 117, 1),
          ),
        ),
      ],
    );
  }
}
