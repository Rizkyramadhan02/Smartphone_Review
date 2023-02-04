import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smartphone_review/app/modules/detail_review/views/detail_review_view.dart';
import 'package:smartphone_review/app/modules/profile_page/views/profile_page_view.dart';
import 'package:smartphone_review/app/modules/smartphone_add/views/smartphone_add_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: controller.openDrawer,
          child: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () => Get.toNamed('profile-page'),
              child: Icon(
                Icons.person_outline_outlined,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      key: controller.scaffoldKey,
      drawer: GestureDetector(
        onTap: controller.openDrawer,
        child: Drawer(
          elevation: 10.0,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/images/logo.png', width: 180),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () => (Get.toNamed('home')),
                      title: Text(
                        'Home',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    ListTile(
                      onTap: () => controller.createOrUpdate(),
                      title: Text(
                        'Add Smartphone',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'SMARTPHONE',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                    stream: controller.fireStore.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot document =
                                snapshot.data!.docs[index];

                            return Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    width: double.infinity,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Image.network(
                                                document['imageUrl'],
                                                fit: BoxFit.cover,
                                                cacheHeight: 150),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${document['brand']}'
                                                .toUpperCase(),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('${document['slogan']}'),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 100,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.teal[400]),
                                                  child: Text(
                                                    'Review',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () async {
                                                    Get.toNamed('detail-review',
                                                        arguments: [
                                                          '${document['brand']}',
                                                          '${document['slogan']}',
                                                          '${document['deskripsi']}',
                                                          '${document['excess']}',
                                                          '${document['imageUrl']}',
                                                          '${document['spek']}'
                                                        ]);
                                                  },
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => controller
                                                        .createOrUpdate(
                                                            document),
                                                    child: Container(
                                                      child: Icon(
                                                        Icons.edit_outlined,
                                                        color: Colors.teal,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                    child: Container(
                                                      child: Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.teal,
                                                      ),
                                                    ),
                                                    onTap: () => showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Perhatian !'),
                                                            content: Text(
                                                                "Anda Yakin Menghapus Data Ini ?"),
                                                            actions: <Widget>[
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        backgroundColor:
                                                                            Colors.redAccent),
                                                                child:
                                                                    Text("Ya"),
                                                                onPressed:
                                                                    () async {
                                                                  //Put your code here which you want to execute on Yes button click.
                                                                  await controller
                                                                      .deleteProduct(
                                                                          document
                                                                              .id);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                              ElevatedButton(
                                                                child: Text(
                                                                    "Tidak"),
                                                                onPressed: () {
                                                                  //Put your code here which you want to execute on No button click.
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ]),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            );
                          });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
