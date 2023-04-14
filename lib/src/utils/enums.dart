enum TextType { number, plainText, email, url }

extension ParseTextType on TextType {
  static TextType parse(String value) {
    switch (value) {
      case 'EMAIL':
        return TextType.email;

      case 'NUMBER':
        return TextType.number;

      case 'URL':
        return TextType.number;

      case 'PLAIN_TEXT':
        return TextType.plainText;

      default:
        throw ArgumentError('invalid enum value $value');
    }
  }
}
