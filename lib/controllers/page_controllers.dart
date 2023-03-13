import 'dart:io';

import 'package:args/args.dart';

import '../extras/page_extras.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class PageController {
  static Future<void> createPage(ArgResults args) async {
    errorHandler(
      tryMethod: () async {
        if (args['name'] == null) return Utils.printWarning("[WARNING] Please use --name for page name");
        if (!(args['name'] as String).contains("_")) return Utils.printWarning("[WARNING] Please use underscore for page name");
        String name = args['name'];
        //* Create Directory
        var directory = await Directory('${Constants.basePath}${Constants.basePathApp}/modules/$name').create(recursive: true);
        var routeDirectory = await Directory('${Constants.basePath}${Constants.basePathApp}/routes').create(recursive: true);
        //* Create Files
        var viewFile = await File("${directory.path}/${name}_view.dart").create(recursive: true);
        var controllerFile = await File("${directory.path}/${name}_controller.dart").create(recursive: true);
        var bindingFile = await File("${directory.path}/${name}_binding.dart").create(recursive: true);
        var serviceFile = await File("${directory.path}/${name}_service.dart").create(recursive: true);
        var appRoutesFile = await File("${routeDirectory.path}/app_pages.dart").create(recursive: true);
        var appPageFile = await File("${routeDirectory.path}/app_routes.dart").create(recursive: true);
        //* Fill Files
        await viewFile.writeAsString(PageExtra.viewPageSnippet(name));
        await controllerFile.writeAsString(PageExtra.controllerPageSnippet(name));
        await bindingFile.writeAsString(PageExtra.bindingPageSnippet(name));
        await serviceFile.writeAsString(PageExtra.servicePageSnippet(name));
        await appRoutesFile.writeAsString(PageExtra.fillAppRoutes(name, await appRoutesFile.readAsString()));
        await appPageFile.writeAsString(PageExtra.fillAppPages(name, await appPageFile.readAsString()));
        Utils.printSuccess("$name Page Succesfully Created.");
      },
      onErr: (exception) async => Utils.printError(exception.toString()),
    );
    return;
  }
}
