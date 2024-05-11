import 'dart:convert';
import 'package:commerce/App/Utils/provider_state.dart';
import 'package:commerce/App/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';


class FetchDioPage extends ConsumerStatefulWidget {
  const FetchDioPage({Key? key}) : super(key: key);

  @override
  ConsumerState<FetchDioPage> createState() => _FetchPageState();
}


class _FetchPageState extends ConsumerState<FetchDioPage> with _MobileFetchScreen {
  @override
  void initState() {
    super.initState();
    ref
        .read(_fetchDataProv)
        .fetchData(url: _url(), limit: _limit, page: _page++);

    _scrollController.addListener(() {
      ref.read(_mainState).equalValueInteger(_scrollController.offset.toInt());

      if (
      _scrollController.position.maxScrollExtent
          ==
          _scrollController.offset
      ) {
        ref
            .read(_fetchDataProv)
            .fetchData(url: _url(), limit: _limit, page: _page++);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    _loadMore = false;
  }

  @override
  Widget build(BuildContext context) {
    if (_loadMore) {
      ref
          .read(_fetchDataProv)
          .fetchData(url: _url(), limit: _limit, page: _page++);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination"),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            _loadMore = false;
            Navigator.maybePop(context);
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          _loadMore = false;
          return true;
        },
        child: Consumer(builder: (context, prov, _) {
          return RefreshIndicator(
            onRefresh: () async {
              _loadMore = true;
              _page = 1;
              _limit = 10;
              setState(() {});

              return ref.read(_fetchDataProv).refreshData(_page);
            },
            child: Consumer(builder: (context, provider, _) {
              return App.text.condition(
                  state: provider.watch(_fetchDataProv).dataList.isNotEmpty,


                  first: Consumer(builder: (context, providerPhysics, _) {
                    return ListView.builder(
                        physics:
                        providerPhysics.watch(_mainState).integer == 0
                            ? const ScrollPhysics()
                            : const BouncingScrollPhysics(),
                        itemCount:
                        provider.read(_fetchDataProv).dataList.length,
                        controller: _scrollController,
                        key: const PageStorageKey<String>(
                            "FetchPageKeyScreen"),
                        itemBuilder: (BuildContext context, int i) {
                          final FetchDioData prov =
                          provider.read(_fetchDataProv);

                          final FetchDioModel model = FetchDioModel.fromJson(
                              prov.dataList.elementAt(i));

                          int index = i;

                          if (prov.hasMore) {
                            index = i + 1;
                          } else {
                            index = i;
                          }

                          if (index < prov.dataList.length) {
                            return ListTile(
                              leading: CircleAvatar(
                                  child: Text(model.id.toString())),
                              key: ValueKey<int>(model.id),
                              title: Text(model.title),
                              subtitle: Text(model.body),
                            );
                          } else {
                            return Visibility(
                                visible: !prov.hasMore ? false : true,
                                child: const Center(
                                    child: CircularProgressIndicator()));
                          }
                        });
                  }),



                  second: const Center(child: CircularProgressIndicator()));

            }
            ),
          );
        }),
      ),
    );
  }
}


mixin _MobileFetchScreen {
  int _limit = 15;
  int _page = 1;
  bool _loadMore = false;

  String _url() {
    return 'https://jsonplaceholder.typicode.com/posts?_limit=$_limit&_page=$_page';
  }

  final _fetchDataProv =
  ChangeNotifierProvider<FetchDioData>((ref) => FetchDioData());

  final _mainState = ChangeNotifierProvider<IntegerProvider>((ref) => IntegerProvider());

  final ScrollController _scrollController = ScrollController();
}


class FetchDioData extends ChangeNotifier {
  List<dynamic> dataList = [];
  bool hasMore = true;


  Future<void> fetchData({ required String url , required int limit,required int page }) async {
    final Response response = await Dio().getUri(Uri.parse(url));
    final List<dynamic> data = await response.data;


    if(response.statusCode == 200 ) {

      if(response.data.length! <= 2) {
        hasMore = false;
      } else {
        hasMore = true;
      }

      dataList.addAll(data.map((e) => e).toList());

      notifyListeners();

    }
  }


  Future<void> fetchDataRandom({ required String url , required int limit,required int page }) async {
    final Response response = await Dio().getUri(Uri.parse(url));
    final Map<String,dynamic> map = await response.data;
    final List<dynamic> data = map['data'];



    if(response.statusCode == 200 ) {

      if(dataList.length < limit) {
        hasMore = false;
      } else {
        hasMore = true;
      }

      dataList.addAll(data.map((e) => e).toList());

      notifyListeners();

    }
  }


  Future<void> refreshData(int page) async {
    hasMore = false;
    page = 1;
    dataList.clear();
    notifyListeners();
  }

}


class FetchDioModel {
  final String title, body;
  final int id;

  const FetchDioModel(
      { required this.title, required this.body, required this.id });

  factory FetchDioModel.fromJson(Map<String, dynamic>json) {
    return FetchDioModel(
        title: json['title'],
        body: json['body'],
        id: json['id']
    );
  }
}