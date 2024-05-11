import 'package:commerce/App/app.dart';
import 'package:commerce/Model/product_model.dart';
import 'package:flutter/material.dart';

class ProductSearchScreen extends SearchDelegate {
  final List<BaseProductModel> dataSearch = [];
  // late String name, content, createdAt, updatedAt, image, category, id;
  // late int price;

  // ProductSearchScreen() {
  //   App.dio.get(url: '${App.strings.searchProduct}/$query')
  //       .then((value) async {
  //         if(value.statusCode == 200) {
  //           print("-------------------------------------------------");
  //           print(value.data['data']);
  //           print("-------------------------------------------------");
  //           dataSearch.addAll(value.data);
  //         }
  //       }).catchError((e){
  //
  //       });
  // }


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = '';
      }, icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, 0);
    }, icon: Icon(Icons.adaptive.arrow_back));
  }



  @override
  Widget buildResults(BuildContext context) {
    // BaseProductModel model = ProductModel(
    //     id: id,
    //     content: content,
    //     name: name,
    //     image: image,
    //     category: category,
    //     createdAt: createdAt ,
    //     updatedAt: updatedAt ,
    //     price: price
    // );

    return App.text.text("${dataSearch.length}", context,color: Colors.white,fontSize: 50.0);
  }



  @override
  Widget buildSuggestions(BuildContext context) {

    App.dio.get(url: '${App.strings.searchProduct}/$query')
        .then((value) async {
      final List<dynamic> body = await value.data['data'];

      if(value.statusCode == 200) {
        final List<BaseProductModel> data
        = body.map((e) => ProductModel.fromJson(e)).toList();

        if(query.isNotEmpty) {
          dataSearch.clear();
        }
        dataSearch.addAll(data);
      }
    }).catchError((_){
     // App.alertWidgets.snackBar(text: "check your Inter", context: context);
    });



    final List<BaseProductModel> searchData = dataSearch
        .where((element) {
      return element.name.toLowerCase().contains(query.toLowerCase());
    })
        .toList();


    return ListView.builder(
        itemCount: query.isNotEmpty ? searchData.length : dataSearch.length ,
        itemBuilder: (BuildContext context, int i) {
          final BaseProductModel data = dataSearch.elementAt(i);
          final BaseProductModel search = searchData.elementAt(i);

          return ListTile(
            leading: query.isNotEmpty ?
            Image.network("${App.strings.mainUrl}/${search.image}", fit: BoxFit.cover)
                :
            Image.network("${App.strings.mainUrl}/${data.image}", fit: BoxFit.cover) ,

            title: query.isNotEmpty ? Text(search.name.toString()) :Text(data.name.toString()),
            subtitle: query.isNotEmpty ? Text(search.price.toString()) : Text(data.price.toString()),
            onTap: () {

            },
          );
        });
  }
}
