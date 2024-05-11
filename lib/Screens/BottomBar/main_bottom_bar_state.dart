

import 'package:commerce/App/Utils/provider_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseBottomBarState {
  final ProviderListenable<BottomBarProvider> bottomProv = ChangeNotifierProvider<BottomBarProvider>((ref) => BottomBarProvider());
}

class BottomBarState extends BaseBottomBarState {}