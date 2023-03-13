import 'package:args/args.dart';

import '../controllers/project_controllers.dart';

class ProjectRoute {
  static void routes(ArgResults args) async {
    if (args.command?.name == "create") await ProjectController.createApp(args);
    if (args.command?.name == "init") await ProjectController.initApp(args);
    if (args.command?.name == "build_android") await ProjectController.buildForAndroid(args);
    if (args.command?.name == "locales") await ProjectController.locales(args);
  }
}
