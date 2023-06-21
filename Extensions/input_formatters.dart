//IBAN
extension InputFormaterText on MaskTextInputFormatter {
  static MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: "TR #### #### #### #### #### #### ",
    filter: {"#": RegExp(r'[0-9]')},
    initialText: 'test',
  );
}
