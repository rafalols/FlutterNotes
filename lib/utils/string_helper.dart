
class StringHelper {

  static String nullIfEmpty(String text) {
    if (text == null || text.isEmpty) {
      return null;
    } else {
      return text;
    }
  }

}