enum TextFamily {
  delius('delius'),
  lato('lato'),
  merriweather('merriweather'),
  montserrat('montserrat'),
  nunito('nunito'),
  openSans('openSans'),
  pacifico('pacifico'),
  playfairDisplay('playfairDisplay'),
  poppins('poppins'),
  roboto('roboto');

  final String name;
  const TextFamily(this.name);

  @override
  String toString() => name;
}
