import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class topContent extends StatefulWidget {
  const topContent({Key? key}) : super(key: key);

  @override
  _topContentState createState() => _topContentState();
}

class _topContentState extends State<topContent> {
  final TextEditingController _kodeDombaController = TextEditingController();
  String? _kodeDombaInput;
  Map<String, dynamic>? _kodeDombaData;
  List<Map<String, dynamic>>? _dataKawin;
  List<Map<String, dynamic>>? _dataBunting;
  List<Map<String, dynamic>>? _dataBeranak;

  @override
  Widget build(BuildContext context) {
    double borderWidth = 2.0; // Lebar border
    double totalBorderWidth = borderWidth * 2;
    return Positioned(
      top: 500,
      left: -15,
      right: -15,
      bottom: 50,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(0),
                // Tambahkan padding untuk mengimbangi border
                padding: EdgeInsets.all(totalBorderWidth + 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: borderWidth),
                ),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text(
                        'Cari domba',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 50,
                          width: 220, // Atur tinggi container
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
                                  controller: _kodeDombaController,
                                  decoration: InputDecoration(
                                      hintText: 'Kode',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      isDense: true,
                                      alignLabelWithHint: true,
                                      hintStyle: TextStyle(
                                          color: Color.fromRGBO(
                                              117, 117, 117, 100))),
                                  onChanged: (value) {
                                    setState(() {
                                      _kodeDombaInput = value.trim();
                                    });
                                  },
                                  textAlign: TextAlign
                                      .left, // Teks dalam TextField menjadi rata kiri
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        ElevatedButton(
                          onPressed: () {
                            _searchDomba();
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(110, 60)), // Ukuran minimum tombol
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.all(12)), // Padding tombol
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(0, 163, 255, 1)),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Atur border radius di sini
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(
                                15), // Memberikan elevasi
                            shadowColor: MaterialStateProperty.all<Color>(
                                Colors.black.withOpacity(1)),
                          ),
                          child: Text(
                            'Cari',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16 // Ubah warna teks menjadi putih
                                ),
                          ),
                        ),
                      ],
                    ),

                    Positioned(
                      top: 0,
                      left: 20,
                      right: 20,
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              childAspectRatio: (88 / 22),
                              children: [
                                _buildNumberBox(
                                    'Kode Domba ',
                                    _kodeDombaData?['kodeDomba'] ?? '',
                                    'lib/images/tag.png'),
                                _buildNumberBox(
                                    'Bobot (kg) : ',
                                    _kodeDombaData?['bobotDomba'] ?? '',
                                    'lib/images/scale.png'),
                                _buildNumberBox(
                                    'Umur (Bulan) : ',
                                    _kodeDombaData?['umurDomba'] ?? '',
                                    'lib/images/age.png'),
                                _buildNumberBox(
                                    '',
                                    _kodeDombaData?['jenisKelamin'] ?? '',
                                    'lib/images/gen.png'),
                              ],
                            ),
                            SizedBox(height: 20)
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'Domba Kawin',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Tabel data kawin
                    if (_dataKawin != null && _dataKawin!.isNotEmpty)
                      Table(
                        border: TableBorder.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: borderWidth,
                        ),
                        children: [
                          TableRow(children: [
                            _buildTableHeader(
                                'Tanggal', Color.fromARGB(239, 40, 54, 42)),
                            _buildTableHeader('Urutan Kawin',
                                Color.fromARGB(239, 40, 54, 42)),
                          ]),
                          if (_dataKawin != null)
                            ..._dataKawin!.map((data) => TableRow(children: [
                                  _buildTableText(
                                      _formatDate(data['tanggalKawin']),
                                      Colors.white),
                                  _buildTableText(
                                      data['urutanKawin'].toString(),
                                      Colors.white),
                                ])),
                        ],
                      ),
                    if (_dataKawin != null && _dataKawin!.isEmpty)
                      Text(
                        'Tidak ada data',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    SizedBox(height: 20), // Spacer antara dua tabel
                    // Tabel kedua
                    Text(
                      'Domba Bunting',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (_dataBunting != null && _dataBunting!.isNotEmpty)
                    Table(
                      border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: borderWidth,
                      ),
                      children: [
                        TableRow(children: [
                          _buildTableHeader(
                              'Tanggal', Color.fromARGB(255, 255, 104, 104)),
                          _buildTableHeader('Urutan Bunting',
                              Color.fromARGB(255, 255, 104, 104)),
                        ]),
                        if (_dataBunting != null)
                          ..._dataBunting!.map((data) => TableRow(children: [
                                _buildTableText(
                                    _formatDate(data['tanggalBunting']),
                                    Colors.white),
                                _buildTableText(
                                    data['urutanBunting'].toString(),
                                    Colors.white),
                              ])),
                      ],
                    ),
                    if (_dataBunting != null && _dataBunting!.isEmpty)
                      Text(
                        'Tidak ada data',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    
                    SizedBox(height: 20), // Spacer antara dua tabel
                    // Tabel ketiga
                    Text(
                      'Domba Beranak',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (_dataBeranak != null && _dataBeranak!.isNotEmpty)
                    Table(
                      border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: borderWidth,
                      ),
                      children: [
                        TableRow(children: [
                          _buildTableHeader(
                              'Tanggal', Color.fromARGB(255, 255, 209, 60)),
                          _buildTableHeader('Urutan Beranak',
                              Color.fromARGB(255, 255, 209, 60)),
                          _buildTableHeader(
                              'Jumlah Anak', Color.fromARGB(255, 255, 209, 60)),
                        ]),
                        if (_dataBeranak != null)
                          ..._dataBeranak!.map((data) => TableRow(children: [
                                _buildTableText(
                                    _formatDate(data['tanggalBeranak']),
                                    Colors.white),
                                _buildTableText(
                                    data['urutanBeranak'].toString(),
                                    Colors.white),
                                _buildTableText(data['jumlahAnak'].toString(),
                                    Colors.white),
                              ])),
                      ],
                    ),
                    if (_dataBeranak != null && _dataBeranak!.isEmpty)
                      Text(
                        'Tidak ada data',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildTableHeader(String text, Color tableHeader) {
    return TableCell(
      child: Container(
        padding: EdgeInsets.all(10.0),
        color: tableHeader, // Menambahkan warna latar belakang
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: const Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.w400,
          ), // Menambahkan warna teks
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildTableText(String text, Color backgroundColor) {
    return TableCell(
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: backgroundColor, // Menambahkan warna latar belakang
        child: FractionallySizedBox(
          widthFactor: 1.0,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14, color: Colors.black), // Menambahkan warna teks
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Future<void> _searchDomba() async {
    final kodeDombaInput = _kodeDombaInput;

    if (kodeDombaInput != null && kodeDombaInput.isNotEmpty) {
      final User? user = FirebaseAuth.instance.currentUser;
      final CollectionReference dataDombaCollection = FirebaseFirestore.instance
          .collection('domba')
          .doc(user!.uid)
          .collection('dataDomba');

      final snapshot = await dataDombaCollection
          .where('kodeDomba', isEqualTo: kodeDombaInput)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final dataDomba = snapshot.docs.first.data();
        setState(() {
          _kodeDombaData = dataDomba as Map<String, dynamic>?;
        });
        // Ambil data kawin dari subcollection
        await _fetchDataKawin(user.uid, kodeDombaInput);
        // Ambil data bunting dari subcollection
        await _fetchDataBunting(user.uid, kodeDombaInput);
        // Ambil data beranak dari subcollection
        await _fetchDataBeranak(user.uid, kodeDombaInput);
      } else {
        setState(() {
          _kodeDombaData = null;
          _dataKawin = null;
          _dataBunting = null;
          _dataBeranak = null;
        });
      }
    } else {
      setState(() {
        _kodeDombaData = null;
        _dataKawin = null;
        _dataBunting = null;
        _dataBeranak = null;
      });
    }
  }

  Future<void> _fetchDataKawin(String userId, String kodeDomba) async {
    final User? user = FirebaseAuth.instance.currentUser;

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('record_kawin')
        .doc(user!.uid)
        .collection('dataKawin')
        .where('kodeDomba',
            isEqualTo: kodeDomba) // Filter berdasarkan kodeDomba yang sesuai
        .get();

    if (snapshot.docs.isNotEmpty) {
      final List<Map<String, dynamic>> dataKawin = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      // Atur urutan kawin berdasarkan penambahan data
      for (int i = 0; i < dataKawin.length; i++) {
        dataKawin[i]['urutanKawin'] = i + 1;
      }

      setState(() {
        _dataKawin = dataKawin;
      });
    } else {
      setState(() {
        _dataKawin = [];
      });
    }
  }

  Future<void> _fetchDataBunting(String userId, String kodeDomba) async {
    final User? user = FirebaseAuth.instance.currentUser;

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('record_bunting')
        .doc(user!.uid)
        .collection('dataBunting')
        .where('kodeDomba',
            isEqualTo: kodeDomba) // Filter berdasarkan kodeDomba yang sesuai
        .get();

    if (snapshot.docs.isNotEmpty) {
      final List<Map<String, dynamic>> dataBunting = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      // Atur urutan bunting berdasarkan penambahan data
      for (int i = 0; i < dataBunting.length; i++) {
        dataBunting[i]['urutanBunting'] = i + 1;
      }

      setState(() {
        _dataBunting = dataBunting;
      });
    } else {
      setState(() {
        _dataBunting = [];
      });
    }
  }

  Future<void> _fetchDataBeranak(String userId, String kodeDomba) async {
    final User? user = FirebaseAuth.instance.currentUser;

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('record_beranak')
        .doc(user!.uid)
        .collection('dataBeranak')
        .where('kodeDomba',
            isEqualTo: kodeDomba) // Filter berdasarkan kodeDomba yang sesuai
        .get();

    if (snapshot.docs.isNotEmpty) {
      final List<Map<String, dynamic>> dataBeranak = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      for (int i = 0; i < dataBeranak.length; i++) {
        dataBeranak[i]['jumlahAnak'] = i + 1;
      }
      setState(() {
        _dataBeranak = dataBeranak;
      });
    } else {
      setState(() {
        _dataBeranak = [];
      });
    }
  }

  String _formatDate(Timestamp timestamp) {
    // Mengubah Timestamp menjadi DateTime
    final dateTime = timestamp.toDate();
    // Mengambil tanggal dengan format tertentu (tanggal/bulan/tahun)
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  Widget _buildNumberBox(String title, String value, String image) {
    String jenisKelaminText =
        ''; // Variabel untuk menyimpan teks jenis kelamin yang akan ditampilkan

    // Logika untuk menentukan teks jenis kelamin
    if (value == 'MJdiCLP726Un0p4A8vu2') {
      jenisKelaminText = 'Jantan';
    } else if (value == 'SQ7e1oe2XtoQCQRYOQXe') {
      jenisKelaminText = 'Betina';
    } else {
      jenisKelaminText =
          value; // Jika tidak sesuai dengan kriteria di atas, tampilkan nilai langsung
    }

    return Container(
      width: 171,
      height: 32,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            margin: EdgeInsets.all(5),
            child: Image.asset(
              image,
              width: 32,
              height: 32,
            ),
          ),
          SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 5),
          Text(
            jenisKelaminText, // Gunakan variabel jenisKelaminText sebagai nilai teks jenis kelamin
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
