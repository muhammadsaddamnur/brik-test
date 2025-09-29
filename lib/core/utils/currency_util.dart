class CurrencyUtil {
  static const String currency = 'Rp';

  static String formatCurrency(int amount) {
    /// Add comma separator
    final formattedAmount = amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );

    return '$currency $formattedAmount';
  }
}
