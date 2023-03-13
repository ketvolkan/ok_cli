extension StringExtension on String {
  String get capitalize {
    String captializedText = "";
    List<String> splitList = split(" ");
    for (var splitText in splitList) {
      captializedText += "${splitText[0].toUpperCase()}${splitText.substring(1).toLowerCase()} ";
    }
    return captializedText;
  }

  String get pageNameCapitalized {
    return replaceAll("_", " ").capitalize.replaceAll(" ", "");
  }

  String get pageNameToUppercase {
    return replaceAll("_", "").toUpperCase();
  }
}
