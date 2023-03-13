import 'package:args/args.dart';

import '../controllers/page_controllers.dart';

class PageRoute {
  static void routes(ArgResults args) async {
    if (args.command?.name == "create_page") await PageController.createPage(args);
  }
}
