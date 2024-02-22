class Hotel {
  final String name;
  final String about;
  final String location;
  final String nightPrice;
  final int stars;
  final int id;
  final List<String> photos;

  Hotel({
    required this.stars,
    required this.name,
    required this.id,
    required this.photos,
    required this.location,
    required this.about,
    required this.nightPrice,
  });
}
