class MaskedPhone {
  final String _countryCode;
  final String _phoneNo;

  MaskedPhone(this._countryCode, this._phoneNo);

  String get countryCode => _countryCode;
  String get phoneNo => _phoneNo;

  @override
  String toString() {
    if (_phoneNo.length >= 10) {
      return '${_countryCode}-XXXXXXX${_phoneNo.substring(7, 10)}';
    } else {
      throw ArgumentError('Phone number should be at least 10 digits long.');
    }
  }
}