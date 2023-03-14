import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:process_run/shell.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class ProjectController {
  static Future<void> createApp(ArgResults args) async {
    errorHandler(
      tryMethod: () async {
        if (args['name'] == null) return Utils.printWarning("Please use --name for project name");
        if (args['org'] == null) return Utils.printWarning("Please use --org for package name ex: com.ket.oz");
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

  static Future<void> initSettings(ArgResults args) async {
    errorHandler(
      tryMethod: () async {
        var shell = Shell();
        await shell.run("flutter pub global activate get_cli");
      },
      onErr: (exception) async => Utils.printError(exception.toString()),
    );
    return;
  }

  static Future<void> test(ArgResults args) async {
    errorHandler(
      tryMethod: () async {
        Utils.printWarning("Uyari Örnek");
        Utils.printInfo("Logger Paketini Dahil Etmek İster misiniz?(y/n)");
        var line = stdin.readLineSync(encoding: utf8);
        if (line?.toUpperCase() == "y".toUpperCase()) {
          Utils.printSuccess("Logger Paketi Eklendi");
        } else if (line?.toUpperCase() == "n".toUpperCase()) {
          Utils.printWarning("Logger Paketi Eklenmedi");
        } else {
          Utils.printError("Geçersiz Karakter Girişi");
        }
      },
      onErr: (exception) async => Utils.printError(exception.toString()),
    );
    return;
  }
}
