import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:first/screens/recordDomba/widget/buttonAddRecord.dart';
import 'package:first/screens/recordDomba/widget/topContent.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecordDomba extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
  User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('record_kawin')
            .doc(user!.uid)
            .collection('dataKawin')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> kawinSnapshot) {
          if (kawinSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          var kawinData = kawinSnapshot.data!.docs;

          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('record_bunting')
                .doc(user.uid)
                .collection('dataBunting')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> buntingSnapshot) {
              if (buntingSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              var buntingData = buntingSnapshot.data!.docs;

              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('record_beranak')
                    .doc(user.uid)
                    .collection('dataBeranak')
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> beranakSnapshot) {
                  if (beranakSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  var beranakData = beranakSnapshot.data!.docs;

                  return Stack(
                    children: [
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
                              onTap: () {},
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
                      Positioned(
                        top: 70,
                        left: 15,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Record Data Domba',
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
                        top: 120,
                        left: 18,
                        right: 18,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          height: 148,
                          width: 395,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Rekap Kondisi Domba",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(117, 117, 117, 1),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 59,
                                        width: 59,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromARGB(239, 40, 54, 42),
                                        ),
                                        child: Text(
                                          kawinData.length.toString(),
                                          style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Kawin",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(117, 117, 117, 1),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 59,
                                        width: 59,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              255, 255, 104, 104),
                                        ),
                                        child: Text(
                                          buntingData.length.toString(),
                                          style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Bunting",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(117, 117, 117, 1),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 59,
                                        width: 59,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromARGB(255, 255, 209, 60),
                                        ),
                                        child: Text(
                                          beranakData.length.toString(),
                                          style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Beranak",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(117, 117, 117, 1),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      buttonAddRecord(),
                      topContent()

                    ],
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: navigasi(),
    );
  }
}
