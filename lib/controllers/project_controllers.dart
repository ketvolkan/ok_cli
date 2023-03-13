import 'package:args/args.dart';
import 'package:process_run/shell.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class ProjectController {
  static Future<void> createApp(ArgResults args) async {
    errorHandler(
      tryMethod: () async {
        if (args['name'] == null) return Utils.printWarning("[WARNING] Please use --name for project name");
        if (args['org'] == null) return Utils.printWarning("[WARNING] Please use --org for package name ex: com.ket.oz");
        var shell = Shell();
        await shell.run("flutter create --org ${args['org']} ${args['name']}");
      },
      onErr: (exception) async => Utils.printError(exception.toString()),
    );
    return;
  }

  static Future<void> initApp(ArgResults args) async {
    errorHandler(
      tryMethod: () async {
        var shell = Shell();
        await shell.run("git clone ${Constants.appRepo} ${args['name'] ?? ""}");
        await shell.run("flutter pub run change_app_package_name:main ${args['org'] ?? ""}");
      },
      onErr: (exception) async => Utils.printError(exception.toString()),
    );
    return;
  }

  static Future<void> buildForAndroid(ArgResults args) async {
    errorHandler(
      tryMethod: () async {
        var shell = Shell();
        await shell.run("flutter build apk --no-tree-shake-icons");
        await shell.run("flutter build appbundle --no-tree-shake-icons");
        await shell.run("open build/app/outputs/");
      },
      onErr: (exception) async => Utils.printError(exception.toString()),
    );
    return;
  }

  static Future<void> locales(ArgResults args) async {
    errorHandler(
      tryMethod: () async {
        var shell = Shell();
        await shell.run("cd utilities");
        await shell.run("dart translate.dart");
        await shell.run("cd ../");
        await shell.run("get generate locales assets/locales");
      },
      onErr: (exception) async => Utils.printError(exception.toString()),
    );
    return;
  }
}
