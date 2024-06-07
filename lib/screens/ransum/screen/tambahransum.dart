import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
class CreateRansum extends StatefulWidget {
  @override
  _CreateRansumState createState() => _CreateRansumState();
}

class _CreateRansumState extends State<CreateRansum> {
  late List<double> totalResults; // Declare totalResults as a late variable

  @override
  void initState() {
    super.initState();
    initializeTotalResults(); // Initialize totalResults in initState
  }

  void initializeTotalResults() {
    totalResults = [0, 0, 0, 0, 0, 0]; // Initialize totalResults
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

  
    return Scaffold(
      body: Stack(
        children: [
          // Background batik
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
          // Button Back
          Positioned(
            top: 25, // Atur posisi teks header di sini
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

          //Title and button
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
              ],
            ),
          ),

        Positioned(
            top: 130,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color.fromRGBO(78, 59, 33, 1)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Kebutuhan Pakan Keseluruhan Hari Ini',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(117, 117, 117, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  StreamBuilder(
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

                      // Reset totalResults before calculating
                      initializeTotalResults();

                      snapshot.data!.docs.forEach((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        double bobot = double.parse(data['bobotDomba']);
                        double result2Value = 0.15 * bobot * 0.122;
                        double result3Value = 0.15 * bobot * 0.685;
                        double result4Value = 0.15 * bobot * 0.027;
                        double result5Value = 0.15 * bobot * 0.01;
                        double result6Value = 0.15 * bobot * 0.071;
                        double result7Value = 0.15 * bobot * 0.112;

                        totalResults[0] += result2Value;
                        totalResults[1] += result3Value;
                        totalResults[2] += result4Value;
                        totalResults[3] += result5Value;
                        totalResults[4] += result6Value;
                        totalResults[5] += result7Value;
                      });

                      return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        childAspectRatio: (171 / 22),
                        children: [
                          _buildNumberBox('Tumpi jagung : ', totalResults[0]),
                          _buildNumberBox('Rumput gajah : ', totalResults[1]),
                          _buildNumberBox('Ampas tebu : ', totalResults[2]),
                          _buildNumberBox('Molases : ', totalResults[3]),
                          _buildNumberBox('Rumput lapang : ', totalResults[4]),
                          _buildNumberBox('Bekatul : ', totalResults[5]),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
          // Scrollable content
          Positioned(
            top: 310,
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
                                  kodeDomba: data['kodeDomba'],
                                  result1: data[
                                      'bobotDomba'], // Specific weight value
                                  result2: '', // Specific age value
                                  result3: '',
                                  result4: '',
                                  result5: '',
                                  result6: '',
                                  result7: '',
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          }).toList(),
                        );
                      },
                    ),
                    SizedBox(height: 10),
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
    required String kodeDomba,
    required String result1,
    required String result2,
    required String result3,
    required String result4,
    required String result5,
    required String result6,
    required String result7,
  }) {
    double bobot = double.parse(result1);
    double result2Value = 0.15 * bobot * 0.122;
    double result3Value = 0.15 * bobot * 0.685;
    double result4Value = 0.15 * bobot * 0.027;
    double result5Value = 0.15 * bobot * 0.01;
    double result6Value = 0.15 * bobot * 0.071;
    double result7Value = 0.15 * bobot * 0.112;

    // Menambahkan nilai result ke dalam totalResults
    totalResults[0] += result2Value;
    totalResults[1] += result3Value;
    totalResults[2] += result4Value;
    totalResults[3] += result5Value;
    totalResults[4] += result6Value;
    totalResults[5] += result7Value;

    print(result7Value);
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
            width: 65,
            height: 65,
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
                kodeDomba,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bobot : $result1',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                Text(
                  'Tumpi jagung : ${result2Value.toStringAsFixed(3)}', // Menggunakan nilai hasil perhitungan dengan 3 angka dibelakang koma
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                Text(
                  'Rumput gajah : ${result3Value.toStringAsFixed(3)}', // Menggunakan nilai hasil perhitungan dengan 3 angka dibelakang koma
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                Text(
                  'Ampas tebu : ${result4Value.toStringAsFixed(3)}', // Menggunakan nilai hasil perhitungan dengan 3 angka dibelakang koma
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                Text(
                  'Molases : ${result5Value.toStringAsFixed(3)}', // Menggunakan nilai hasil perhitungan dengan 3 angka dibelakang koma
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                Text(
                  'Rumput lapang : ${result6Value.toStringAsFixed(3)}', // Menggunakan nilai hasil perhitungan dengan 3 angka dibelakang koma
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                Text(
                  'Bekatul : ${result7Value.toStringAsFixed(3)}', // Menggunakan nilai hasil perhitungan dengan 3 angka dibelakang koma
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

  Widget _buildNumberBox(String title, double value) {
    
    return Container(
      width: 171,
      height: 32,
      decoration: BoxDecoration(
        color: Color.fromRGBO(254, 203, 1, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title, // Judul kategori jenis pakan
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            value.toStringAsFixed(3), // Nilai atau jumlah pakan
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
