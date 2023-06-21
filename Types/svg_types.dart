enum SvgLogoTypes {
  logo('logo'),
  headerlogo('logo_white');

  final String name;
  const SvgLogoTypes(this.name);
}

extension SvgLogoTypesExtension on SvgLogoTypes {
  String get fullPath => '$path$name.svg';
  static String path = 'assets/logo/';
}
