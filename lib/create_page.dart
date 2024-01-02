import 'package:belajar_sqflite/database_instance.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameProdukController = TextEditingController();
  TextEditingController categoryProdukController = TextEditingController();
  @override
  void initState() {
    databaseInstance.cekDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('tambah data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nama Produk'),
            TextField(
              controller: nameProdukController,
            ),
            const SizedBox(height: 20),
            const Text('Kategori Produk'),
            TextField(
              controller: categoryProdukController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  await databaseInstance.insert({
                    'name': nameProdukController.text,
                    'category': categoryProdukController.text,
                    'create_at': DateTime.now().toString(),
                    'update_at': DateTime.now().toString(),
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                child: const Text('Submit'))
          ],
        ),
      ),
    );
  }
}
