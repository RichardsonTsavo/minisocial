class Utils {
  static String formatTime(DateTime date) {
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 60) {
      return "há ${diff.inMinutes} min";
    }

    if (diff.inHours < 24) {
      return "há ${diff.inHours} h";
    }

    return "há ${diff.inDays} dias";
  }
}
