import '../utils/enums.dart';
import '../utils/string_extensions.dart';

class PageExtra {
  static String viewPageSnippet(String pageName) {
    String fillContent = "";
    fillContent += "import 'dart:io';";
    fillContent += "import 'package:flutter/material.dart';";
    fillContent += "import 'package:flutter/services.dart';";
    fillContent += "import 'package:get/get.dart';";
    fillContent += "import '${pageName}_controller.dart';";
    fillContent += 'class ${pageName.pageNameCapitalized}View extends GetView<${pageName.pageNameCapitalized}Controller>{';
    fillContent += "const ${pageName.pageNameCapitalized}View({Key? key}) : super(key: key);";
    fillContent += "@override Widget build(BuildContext context) {";
    fillContent += "return SizedBox();";
    fillContent += "}";
    fillContent += '}';
    return fillContent;
  }

  static String controllerPageSnippet(String pageName) {
    String fillContent = "";
    fillContent += "import 'package:get/get.dart';";
    fillContent += "import '../../../../../../core/utils/getx_extensions.dart';";
    fillContent += "enum ${pageName.pageNameCapitalized}State { Initial, Busy, Error, Loaded }";
    fillContent += 'class ${pageName.pageNameCapitalized}Controller extends GetxController{';
    fillContent += "final Rx<${pageName.pageNameCapitalized}State> _state = ${pageName.pageNameCapitalized}State.Initial.obs;";
    fillContent += "${pageName.pageNameCapitalized}State get state => _state.value;";
    fillContent += "set state(${pageName.pageNameCapitalized}State val) => _state.value = val;";
    fillContent += "@override void onInit() {";
    fillContent += "ever(_state, (${pageName.pageNameCapitalized}State value) {";
    fillContent += "switch (value) {";
    fillContent += "case ${pageName.pageNameCapitalized}State.Busy:";
    fillContent += "Get.showProgressDialog();break;";
    fillContent += "case ${pageName.pageNameCapitalized}State.Loaded:";
    fillContent += "if (!Get.isOverlaysClosed) Get.back();break;";
    fillContent += "case ${pageName.pageNameCapitalized}State.Error:";
    fillContent += "if (!Get.isOverlaysClosed) Get.back();break;";
    fillContent += "default:}});super.onInit();}";
    fillContent += "}";
    return fillContent;
  }

  static String bindingPageSnippet(String pageName) {
    String fillContent = "";
    fillContent += "import 'package:get/get.dart';";
    fillContent += "import '${pageName}_controller.dart';";
    fillContent += "import '${pageName}_service.dart';";
    fillContent += "class ${pageName.pageNameCapitalized}Binding implements Bindings{";
    fillContent += "@override void dependencies() { ";
    fillContent += "Get.lazyPut(() => ${pageName.pageNameCapitalized}Service());";
    fillContent += "Get.lazyPut(() => ${pageName.pageNameCapitalized}Controller());}}";
    return fillContent;
  }

  static String servicePageSnippet(String pageName) {
    String fillContent = "";
    fillContent += "import 'package:get/get.dart';";
    fillContent += 'class ${pageName.pageNameCapitalized}Service extends GetxService{';
    fillContent += "}";
    return fillContent;
  }

  static String fillAppRoutes(String pageName, String file) {
    file = file.replaceAll("\n", "");
    String fillContent = "";
    if (file.contains("AppRoutes")) {
      fillContent = file.substring(0, file.length - 1);
    } else {
      fillContent = "class AppRoutes {";
    }
    String pageNameWithUpperCase = pageName.pageNameToUppercase;
    fillContent += 'static const String $pageNameWithUpperCase ="/$pageName";}';
    return fillContent;
  }

  static String fillAppPages(String pageName, String file) {
    file = file.replaceAll("\n", "");
    String fillContent = "";
    if (file.contains("AppPages")) {
      Map<PageSplitType, String> splits = {
        PageSplitType.imports: file.split("class")[0],
        PageSplitType.content: "class${file.split("class")[1]}",
      };
      fillContent += (splits[PageSplitType.imports] as String);
      fillContent += "import '../modules/$pageName/${pageName}_binding.dart';";
      fillContent += "import '../modules/$pageName/${pageName}_view.dart';";
      fillContent += (splits[PageSplitType.content] as String).substring(0, (splits[PageSplitType.content] as String).length - 3);
    } else {
      fillContent += "import 'app_pages.dart';";
      fillContent += "import 'package:get/get.dart';";
      fillContent += "import '../modules/$pageName/${pageName}_binding.dart';";
      fillContent += "import '../modules/$pageName/${pageName}_view.dart';";
      fillContent += "class AppPages {static var PAGES = [";
    }
    String pageNameWithUpperCase = pageName.pageNameToUppercase;
    String pageNameWithFirstCharUpperCase = pageName.pageNameCapitalized;
    fillContent += 'GetPage(';
    fillContent += 'name: AppRoutes.$pageNameWithUpperCase,';
    fillContent += 'page: () => const ${pageNameWithFirstCharUpperCase}View(),';
    fillContent += 'binding: ${pageNameWithFirstCharUpperCase}Binding(),';
    fillContent += 'transition: Transition.noTransition,),';
    fillContent += '];}';
    return fillContent;
  }
}
