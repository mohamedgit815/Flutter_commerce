import 'dart:async';
import 'package:commerce/App/Utils/app_enums.dart';
import 'package:commerce/App/Utils/route_builder.dart';
import 'package:commerce/App/app.dart';
import 'package:commerce/Model/category_model.dart';
import 'package:commerce/Screens/Orders/main_orders_screen.dart';
  import 'package:commerce/test/test_one.dart';
import 'package:commerce/test/test_two.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class MyApp extends ConsumerWidget {
  final Widget screen;

  const MyApp({
    Key? key ,
    required this.screen
  }) : super(key: key);


  @override
  Widget build(BuildContext context , WidgetRef ref) {

    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      title: 'Commerce App' ,

      restorationScopeId: 'root' ,

      navigatorKey: App.navigator.navigatorKey ,

      onGenerateRoute: RouteGenerators.onGenerate ,


      //routes: RouteGenerators.onGenerate ,

      themeMode: !ref.watch(App.theme.themeProvider).darkTheme ? ThemeMode.dark : ThemeMode.light,

      darkTheme: App.theme.darkThemeData() ,

      theme: App.theme.lightThemeData() ,


      //home: const TestPage() ,
      //home: const MainChangePwScreen() ,
      //home: const MainRegisterScreen() ,
      //home: const MainLoginScreen() ,
      //home: const MainBottomBarScreen(userModel: user) ,
      //home: const MainCartScreen() ,
      //home: const MainProductsScreen() ,
      //home: const MainDrawerScreen() ,
      //home: const MainOrdersScreen() ,
      home: screen ,


      /// Localization
      //locale: const Locale("ar") ,
      locale: App.localization.switchLang(ref.watch(App.localization.provLang).value),

      supportedLocales: App.localization.supportedLocales() ,

      localizationsDelegates: App.localization.localizationsDelegates(),

      localeResolutionCallback: (Locale? currentLocal ,Iterable<Locale> supportedLocal){
        return App.localization.localeResolutionCallback(currentLocal, supportedLocal);
      },
    );
  }
}






final testProv = StateNotifierProvider((ref) => TestProvider());
final testProv2 = StateNotifierProvider((ref) => TestProvider());
final testvarProv = StateNotifierProvider<TestProvider , int>((ref) => TestProvider());
final testCategory = FutureProvider((ref) async => await _getData());

 Future<List<dynamic>> _getData() async {
  try{
    final Response response = await App.dio.get(url: App.strings.getAllCategory);
    final List<dynamic> dataMap = response.data['data'];

    final List<dynamic> test = response.data['data'];
    print(test);

    if(response.statusCode == 200 ) {
      return dataMap;
    } else {
      throw Exception("Error");
    }

  } on DioException catch(e) {
    throw Exception("Error");
  }

}


class TestPage extends ConsumerStatefulWidget {
  const TestPage({super.key});

  @override
  ConsumerState<TestPage> createState() => _TestPageState();
}


class _TestPageState extends ConsumerState<TestPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          const ChoiceChip(
              label: Text("data"),
              selected: true
          ),



          MaterialButton(onPressed: () async {

            //await App.payments.paypal(total: "40", context: context);

            await App.payments.stripePayments(amount: "300", currency: "USD");

          },child: const Text("Payments"),) ,






          Consumer(
            builder: (context,prov,_) {
              return Column(
                children: [
                  Text(
                      prov.watch(testvarProv.notifier).state.toString() ,
                    style: const TextStyle(color: Colors.white,fontSize: 20),
                  ),
                  MaterialButton(onPressed: (){
                    prov.watch(testvarProv.notifier).changeVar();
                  },child: const Text('Increase'),)
                ],
              );
            }
          ) ,


          Consumer(
            builder: (context,prov,_) {
              return AnimatedCrossFade(
                duration: const Duration(milliseconds: 1),
                //duration: const Duration(seconds:2),
                crossFadeState: prov.watch(testProv) == 1 ?
                CrossFadeState.showFirst
                    :
                CrossFadeState.showSecond,
                  
                  
                  firstChild: const Center(child: CircularProgressIndicator(),),
                  
                  secondChild: Center(
                    child: MaterialButton(onPressed: () {
                      prov.read(testProv.notifier).test(context);
                      prov.read(testProv.notifier).test1();
                      //Navigator.pushNamed(context, RouteGenerators.testScreen);
                    },child: const Text("saaaaaaaaaa")),
                  ),
              );
            }
          ) ,


          MaterialButton(
            onPressed: () async {
            print(ref.read(testProv.notifier).test1());
            await _getData();
          } ,
            child: Text("dddddddddddddddddddddfg")
          ),




          ref.watch(testCategory).when(
              error: (err,stack )=> Text(err.toString()),
              loading: ()=> const CircularProgressIndicator() ,
            data: (data) {
                return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                        itemBuilder: (context,i) {
                          final BaseCategoryModel model = CategoryModel.fromJson(data.elementAt(i));

                          return Text(model.name);
                        }
                    )
                );
            }
          )
        ],
      ),
    );
  }
}


class TestProvider extends StateNotifier<int> {
  TestProvider(): super(0);

  int testvar = 0;

  changeVar() {
    state++;
  }


  test(BuildContext context) async {
    try{
      state = 1;
      final Response response = await App.dio.post(url: '/test',data: {
        "name": "Nora",
        "brand": "Nora"
      });
      if(response.statusCode == 200 || response.statusCode == 201) {
        if(context.mounted) {
          App.alertWidgets.snackBar(text: LangEnum.success.name, context: context);

        }
      }
      state = 2;
    }catch(e) {
      if(context.mounted) {
        App.alertWidgets.snackBar(text: LangEnum.internet.name, context: context);

        state = 2;
      }
    }
  }



  test1() {
    print(state);
  }
}


class TestOne extends StatelessWidget {
  const TestOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(onPressed: () {
            Navigator.push(context, CupertinoPageRoute(builder: (_)=>const FetchPage()));
          },child: const Text("TestOne"),) ,


          MaterialButton(onPressed: () {
            Navigator.push(context, CupertinoPageRoute(builder: (_)=>const FetchDioPage()));
          },child: const Text("TestTwo"),) ,
        ],
      ),
    );
  }
}
