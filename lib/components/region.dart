class Region {
  late String name;
  late String label;
  late String description;
  late String mainImagePath;
  late List<String> imagePaths;

  Region({this.label = "", required this.name, required this.description, required this.mainImagePath, required this.imagePaths});
}