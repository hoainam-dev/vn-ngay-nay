import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_cuoi_ki/helper/Notifications.dart';
import 'package:do_an_cuoi_ki/views/Home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CreateCategories extends StatefulWidget {
  const CreateCategories({Key? key}) : super(key: key);

  @override
  State<CreateCategories> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategories> {
  // text fields' controllers
  final TextEditingController _categorieSlug = TextEditingController();
  final TextEditingController _categorieName = TextEditingController();

  TextEditingController searchController = new TextEditingController();


  final CollectionReference _category =
  FirebaseFirestore.instance.collection('category');

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Notifications.initialize(flutterLocalNotificationsPlugin);
  }

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _categorieSlug.text = documentSnapshot['name'];
      _categorieName.text = documentSnapshot['price'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _categorieSlug,
                  decoration: const InputDecoration(labelText: 'SLug'),
                ),
                TextField(
                  controller: _categorieName,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? slug = _categorieSlug.text;
                    final String? name = _categorieName.text;
                    if (slug != null && name != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _category.add({"categorieSlug": slug, "categorieName": name});
                        Notifications.showBogTextNotification(
                            title: "VN Ngày nay",
                            body: "Tạo thể loại thành công!",
                            fln: flutterLocalNotificationsPlugin);
                      }

                      if (action == 'update') {
                        // Update the product
                        await _category
                            .doc(documentSnapshot!.id)
                            .update({"categorieSlug": slug, "categorieName": name});
                      }
                      // Clear the text fields
                      _categorieSlug.text = '';
                      _categorieName.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteCategory(String categoryId) async {
    await _category.doc(categoryId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a student')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0), color: Colors.white),
      child: TextField(
        controller: searchController,
        onTap: () {},
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xffe0e0e0),
              size: 30,
            ),
            hintText: 'Nhập từ khóa',
            hintStyle: TextStyle(color: Color(0xffe0e0e0), fontSize: 18),
            suffixIcon: Icon(Icons.area_chart, color: Color(0xffd43c3b))),
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    ),
    backgroundColor: Color(0xffd43c3b),
    ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _category.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['categorieSlug']),
                    subtitle: Text(documentSnapshot['categorieName']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                              {_createOrUpdate(documentSnapshot)}),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                              {_deleteCategory(documentSnapshot.id)}),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
