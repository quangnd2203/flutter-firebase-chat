import 'dart:async';
import 'package:get/get.dart';
import '../../resources/resources.dart';
import '../message/_binding.dart';
import '../ui.dart';

class NavigationController extends BaseController {

  RxList<TestModel> raw = <TestModel>[].obs;

  RxInt index = 0.obs;

  List<Bindings> get childrenBindings => <Bindings>[
    MessageBinding(),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    // ignore: avoid_function_literals_in_foreach_calls
    childrenBindings.forEach((Bindings element) => element.dependencies());
  }

}
