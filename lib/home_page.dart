import 'package:belajar_sqflite/create_page.dart';
import 'package:belajar_sqflite/produk_model.dart';
import 'package:belajar_sqflite/update_page.dart';
import 'package:flutter/material.dart';
import 'package:belajar_sqflite/database_instance.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseInstance? databaseInstance;

//membuat fuction untuk menampilkan data pada saat awal pertama aplikasi dijalankan
  Future initDatabase() async {
    await databaseInstance!.cekDatabase();
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return const CreatePage();
                  }))
                      //menentukan tindakan yang akan diambil ketika nilai dari Future tersebut sudah tersedia.
                      .then((value) {
                    setState(() {});
                  });
                },
                icon: const Icon(Icons.add))
          ],
          title: const Text('belajar sqflite'),
        ),
        body: databaseInstance != null
            ? FutureBuilder<List<ProdukModel>>(
                future: databaseInstance!.allData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            subtitle:
                                Text(snapshot.data![index].category ?? ''),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (builder) {
                                    return UpdatePage(
                                      produkModel: snapshot.data![index],
                                    );
                                  })).then((value) {
                                    setState(() {});
                                  });
                                },
                                icon: const Icon(Icons.edit)),
                            title: Text(snapshot.data![index].name ?? ''),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
