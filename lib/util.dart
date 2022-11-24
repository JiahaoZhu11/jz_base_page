import 'package:characters/characters.dart';

extension FixAutoLines on String {
  String cancelAutoLines() {
    return Characters(this).join('\u{200B}');
  }
}
