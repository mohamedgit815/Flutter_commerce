import 'package:commerce/App/app.dart';
import 'package:commerce/Model/search_place_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchLocationsPage extends ConsumerStatefulWidget {
  const SearchLocationsPage({super.key});

  @override
  ConsumerState<SearchLocationsPage> createState() => _SearchPlacePageState();
}

class _SearchPlacePageState extends ConsumerState<SearchLocationsPage> with _SearchPlace_ {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await searchPlace();
    });
    fetchProv = FutureProvider<List<PlacesModel>>((ref) async => await searchPlace());
  }

  @override
  Widget build(BuildContext context) {
    final Color whiteBlack = App.theme.conditionTheme(
    context: context, light: App.color.helperBlack, dark: App.color.helperWhite);

    return Scaffold(
      appBar: AppBar(
        title: App.text.text("Search",context,fontSize: 24.0),
        leading: const BackButton(),
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: controller ,

              onSubmitted: (v) {
                search(context: context, ref: ref);
              } ,

              style: TextStyle(color: whiteBlack,fontSize: 20.0) ,

              cursorColor: whiteBlack ,

              decoration: InputDecoration(
                hintText: 'Search Place' ,
                prefixIcon: const Icon(Icons.location_city) ,
                border: outlineInputBorder(context) ,
                focusedBorder: outlineInputBorder(context) ,
                enabledBorder: outlineInputBorder(context) ,
                errorBorder: outlineInputBorder(context) ,
                disabledBorder: outlineInputBorder(context) ,
                contentPadding: const EdgeInsets.all(8.0),
                suffixIcon: IconButton(onPressed: () {
                  search(context: context, ref: ref);
                }, icon: const Icon(Icons.search))
              ) ,
            ),
          ) ,

          Expanded(
              child: Consumer(
                  builder: (context,prov,_) {
                    return prov.watch(fetchProv).when(

                        error: (err,stack) => App.text.text(err.toString(),context) ,

                        loading: () => loadingSearch(color: whiteBlack) ,

                        data: (List<PlacesModel> data) {
                          return App.packageWidgets.condition(
                            duration: const Duration(milliseconds: 200),
                            condition: data.isEmpty ,

                            builder: (_) {
                              return Center(
                                  child: App.text.text("No Data", context,
                                    fontSize: 24.0
                                  )
                              );
                            } ,

                            fallback: (_) {
                              return ListView.builder(
                                  itemCount: data.length ,
                                  itemBuilder: (BuildContext context, int index) {
                                    final PlacesModel model = data.elementAt(index);
                                    return Container(
                                        margin: const EdgeInsets.all(8.0) ,
                                        child: ListTile(

                                          title: App.text.text(model.name,context,color: whiteBlack),

                                          subtitle: model.district == null || model.district!.isEmpty ?
                                          App.text.text("${model.country} ${model.countryCode}",context,color: whiteBlack)
                                              :
                                          App.text.text(model.district.toString(),context,color: whiteBlack),

                                          onTap: () {
                                            final LatLng latLng = LatLng(model.coorLat, model.coorLng);
                                            Navigator.of(context).maybePop<LatLng>(latLng);
                                          },

                                        )
                                    );
                                  });
                            }
                        );
                        }
                    );
                  }
              ))

        ],
      ),
    );
  }
}


mixin _SearchPlace_ {

  final TextEditingController controller = TextEditingController();
  late FutureProvider<List<PlacesModel>> fetchProv;

  Future<List<PlacesModel>> searchPlace() async {
    return await Dio().getUri(Uri.parse("https://photon.komoot.io/api/?q=${controller.text.toLowerCase()}&limit=7&lang=en"),
        options: Options(responseType: ResponseType.json)).then((value) {
      final List<dynamic> data = value.data['features'];
      final List<PlacesModel> valueData = data.map((e) => PlacesModel.fromJson(e)).toList();
      return valueData;
    }).catchError((e) {
      throw Exception("No Data");
    });
  }

  void search({required BuildContext context , required WidgetRef ref}) {
    ref.refresh(fetchProv);
    FocusScope.of(context).unfocus();
  }

  OutlineInputBorder outlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
        borderSide: BorderSide(
            color: App.theme.conditionTheme(
                context: context ,
                light: App.color.helperBlack ,
                dark: App.color.helperWhite
            )
        )
    );
  }

  Widget loadingSearch({required Color color}) {
    return ListView.builder(
        itemCount: 7 ,
        itemBuilder: (context, index) {
          return App.packageWidgets.shimmer(
              child: Container(
                  margin: const EdgeInsets.all(8.0) ,
                  child: App.text.text("Loading", context,fontSize: 20.0,color: color)
              ));
        });
  }
}