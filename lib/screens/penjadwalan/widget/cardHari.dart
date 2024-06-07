import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class cardHari extends StatelessWidget {
  const cardHari({
    super.key,
  });

  void getData(String hari) {
    FirebaseFirestore.instance
        .collection('penjadwalan')
        .where('hari', isEqualTo: hari)
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
    return Positioned(
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
    );
  }
}

