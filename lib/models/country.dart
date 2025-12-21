class CountryModel {
  final String isoCode; // e.g. JP, US
  final String name;
  final String? continent;

  CountryModel({required this.isoCode, required this.name, this.continent});

  Map<String, dynamic> toMap() => {
        'isoCode': isoCode,
        'name': name,
        'continent': continent,
      };
}
