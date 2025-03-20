String formatCount(int count) {
  if (count >= 1000000) {
    return '${(count / 1000000).toStringAsFixed(1)}M'; // للملايين
  } else if (count >= 1000) {
    return '${(count / 1000).toStringAsFixed(1)}K'; // للألف
  } else {
    return count.toString(); // للأرقام الأقل من الألف
  }
}
