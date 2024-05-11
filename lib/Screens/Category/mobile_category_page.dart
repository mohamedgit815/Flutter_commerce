import 'package:commerce/App/app.dart';
import 'package:commerce/Screens/Category/init_category.dart';
import 'package:flutter/material.dart';


class MobileCategoryPage extends StatefulWidget  {
  final InitCategory init;

  const MobileCategoryPage({Key? key , required this.init}) : super(key: key);

  @override
  State<MobileCategoryPage> createState() => _MobileCategoryPageState();
}

class _MobileCategoryPageState extends State<MobileCategoryPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: NestedScrollView(

        headerSliverBuilder: (context,i)=>[
          SliverAppBar(
            floating: true,
            snap: true,
            centerTitle: true,
            title: App.text.text('Health',context)
          )
        ],

        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: 24,
            itemBuilder: (BuildContext context, int i){
              return Container(
                margin: const EdgeInsets.all(5.0),
                color: Colors.red,
              );
            }
        ),
      ),
    );
  }
}
