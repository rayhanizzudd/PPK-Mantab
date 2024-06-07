import 'package:first/screens/navigasi/navigasi.dart';
import 'package:first/screens/penjadwalan/widget/kalender.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Penjadwalan extends StatefulWidget {
  @override
  _PenjadwalanState createState() => _PenjadwalanState();
}

// ignore: must_be_immutable
class _PenjadwalanState extends State<Penjadwalan> {
  String selectedDay = ''; // Menyimpan hari yang dipilih

  void changeSelectedDay(String day) {
    setState(() {
      selectedDay =
          day; // Ubah nilai selectedDay sesuai dengan tombol yang diklik
    });
  }

  void getData(String hari) {
    selectedDay = hari; // Simpan hari yang dipilih oleh pengguna
    FirebaseFirestore.instance
        .collection('penjadwalan')
        .where('hari', isEqualTo: selectedDay)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var jadwalList = querySnapshot.docs[0].reference.collection('jadwal');
        jadwalList.get().then((jadwalSnapshot) {
          var jadwalData = jadwalSnapshot.docs;
          jadwalData.sort((a, b) => a['jam'].compareTo(b['jam']));

          // Lakukan proses data sesuai kebutuhan
          for (var jadwal in jadwalData) {
            var jam = jadwal['jam'];
            var kegiatan = jadwal['kegiatan'];
            print('Jam: $jam, Kegiatan: $kegiatan');
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(

        children: [
          // Bg Batik
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

          kalender(),

          //Title and button
          Positioned(
      top: 220,
      left: 15,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Tombol
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  changeSelectedDay('senin');
                  getData('senin');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Atur radius sesuai keinginan
                    side: BorderSide(
                        color: Color.fromRGBO(
                            104, 119, 68, 1)), // Atur border dengan warna hijau
                  ),
                  minimumSize: Size(18, 90), // Atur ukuran minimum tombol
                  padding: EdgeInsets.symmetric(
                      horizontal: 10), // Atur padding tombol
                  textStyle: TextStyle(fontSize: 12), // Atur gaya teks tombol
                  backgroundColor:
                      Colors.white, // Atur warna latar belakang menjadi putih
                ),
                child: Text('Sen',
                    style: TextStyle(color: Color.fromRGBO(104, 119, 68, 1))),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  changeSelectedDay('selasa');
                  getData('selasa');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Atur radius sesuai keinginan
                    side: BorderSide(
                        color: Color.fromRGBO(
                            104, 119, 68, 1)), // Atur border dengan warna hijau
                  ),
                  minimumSize: Size(18, 90), // Atur ukuran minimum tombol
                  padding: EdgeInsets.symmetric(
                      horizontal: 10), // Atur padding tombol
                  textStyle: TextStyle(fontSize: 12), // Atur gaya teks tombol
                  backgroundColor:
                      Colors.white, // Atur warna latar belakang menjadi putih
                ),
                child: Text('Sel',
                    style: TextStyle(color: Color.fromRGBO(104, 119, 68, 1))),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  changeSelectedDay('rabu');
                  getData('rabu');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Atur radius sesuai keinginan
                    side: BorderSide(
                        color: Color.fromRGBO(
                            104, 119, 68, 1)), // Atur border dengan warna hijau
                  ),
                  minimumSize: Size(18, 90), // Atur ukuran minimum tombol
                  padding: EdgeInsets.symmetric(
                      horizontal: 10), // Atur padding tombol
                  textStyle: TextStyle(fontSize: 12), // Atur gaya teks tombol
                  backgroundColor:
                      Colors.white, // Atur warna latar belakang menjadi putih
                ),
                child: Text('Rab',
                    style: TextStyle(color: Color.fromRGBO(104, 119, 68, 1))),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  changeSelectedDay('kamis');
                  getData('kamis');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Atur radius sesuai keinginan
                    side: BorderSide(
                        color: Color.fromRGBO(
                            104, 119, 68, 1)), // Atur border dengan warna hijau
                  ),
                  minimumSize: Size(18, 90), // Atur ukuran minimum tombol
                  padding: EdgeInsets.symmetric(
                      horizontal: 10), // Atur padding tombol
                  textStyle: TextStyle(fontSize: 12), // Atur gaya teks tombol
                  backgroundColor:
                      Colors.white, // Atur warna latar belakang menjadi putih
                ),
                child: Text('Kam',
                    style: TextStyle(color: Color.fromRGBO(104, 119, 68, 1))),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  changeSelectedDay('jumat');
                  getData('jumat');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Atur radius sesuai keinginan
                    side: BorderSide(
                        color: Color.fromRGBO(
                            104, 119, 68, 1)), // Atur border dengan warna hijau
                  ),
                  minimumSize: Size(18, 90), // Atur ukuran minimum tombol
                  padding: EdgeInsets.symmetric(
                      horizontal: 10), // Atur padding tombol
                  textStyle: TextStyle(fontSize: 12), // Atur gaya teks tombol
                  backgroundColor:
                      Colors.white, // Atur warna latar belakang menjadi putih
                ),
                child: Text('Jum',
                    style: TextStyle(color: Color.fromRGBO(104, 119, 68, 1))),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  changeSelectedDay('sabtu');
                  getData('sabtu');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Atur radius sesuai keinginan
                    side: BorderSide(
                        color: Color.fromRGBO(
                            104, 119, 68, 1)), // Atur border dengan warna hijau
                  ),
                  minimumSize: Size(18, 90), // Atur ukuran minimum tombol
                  padding: EdgeInsets.symmetric(
                      horizontal: 10), // Atur padding tombol
                  textStyle: TextStyle(fontSize: 12), // Atur gaya teks tombol
                  backgroundColor:
                      Colors.white, // Atur warna latar belakang menjadi putih
                ),
                child: Text('Sab',
                    style: TextStyle(color: Color.fromRGBO(104, 119, 68, 1))),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  changeSelectedDay('minggu');
                  getData('minggu');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Atur radius sesuai keinginan
                    side: BorderSide(
                        color: Color.fromRGBO(
                            104, 119, 68, 1)), // Atur border dengan warna hijau
                  ),
                  minimumSize: Size(18, 90), // Atur ukuran minimum tombol
                  padding: EdgeInsets.symmetric(
                      horizontal: 10), // Atur padding tombol
                  textStyle: TextStyle(fontSize: 12), // Atur gaya teks tombol
                  backgroundColor:
                      Colors.white, // Atur warna latar belakang menjadi putih
                ),
                child: Text('Min',
                    style: TextStyle(color: Color.fromRGBO(104, 119, 68, 1))),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    ),

          Positioned(
            top: 340,
            left: 20,
            right: 20,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Spasi antara kotak nomor dan judul
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Waktu        Kegiatan',
                          style: TextStyle(
                            fontSize: 16,
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
            ),
          ),

          Positioned(
            top: 400,
            left: -15,
            right: -15,
            bottom: 50,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    // Display items based on Firestore data
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('penjadwalan')
                          .where('hari', isEqualTo: selectedDay)
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Text(selectedDay);
                          } else {
                            var jadwalList = snapshot.data!.docs[0].reference
                                .collection('jadwal');
                            return StreamBuilder(
                              stream: jadwalList.orderBy('jam').snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> jadwalSnapshot) {
                                if (jadwalSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else {
                                  var jadwalData = jadwalSnapshot.data!.docs;
                                  return Column(
                                    children: jadwalData.map((jadwal) {
                                      var jam = jadwal['jam'];
                                      var kegiatan = jadwal['kegiatan'];
                                      return _buildItem(
                                        time: jam,
                                        result1: kegiatan,
                                      );
                                    }).toList(),
                                  );
                                }
                              },
                            );
                          }
                        }
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
    required String result1,
    required int time, 
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: EdgeInsets.only(bottom: 5),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$time        $result1',
                  style: TextStyle(
                    fontSize: 16,
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
}

