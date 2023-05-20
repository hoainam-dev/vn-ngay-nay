import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_cuoi_ki/models/categorie_model.dart';


class CategoryService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Category> categories = [];

  //get collection category and convert to list
  Future<List<Category>> retrieveCategory() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("category").get();
    return snapshot.docs
        .map((docSnapshot) => Category.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  //get category
  Future<void> getCategories() async {
    var retrieveCategoryList = await retrieveCategory();
    retrieveCategoryList.forEach((element) {
        if(element.categorieSlug=="Home"){
          Category category1 = Category(
            categoryId: element.categoryId,
            categorieSlug: element.categorieSlug,
            categorieName: element.categorieName,
          );
          categories.add(category1);
          print("get Category oke!");
        }
    });
    retrieveCategoryList.forEach((element) {
      if(element.categorieSlug!="Home"){
        Category category2 = Category(
          categoryId: element.categoryId,
          categorieSlug: element.categorieSlug,
          categorieName: element.categorieName,
        );
        categories.add(category2);
        print("get Category oke!");
      }
    });
  }
}