import 'package:args/args.dart';

import 'routes/page_routes.dart';
import 'routes/project_routes.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addCommand('create_page')
    ..addCommand("create")
    ..addCommand("init")
    ..addCommand("build_android")
    ..addCommand("locales")
    ..addCommand("init_setting")
    ..addCommand("test")
    ..addOption("org")
    ..addOption("name");
  final args = parser.parse(arguments);
  PageRoute.routes(args);
  ProjectRoute.routes(args);
}
