/// One ward/unit row in the occupancy list (source: `GetCurrentBedStatusData`).
class WardOccupancy {
  final String unitId;
  final String nameEn;
  final String nameAr;
  final int bedFull;
  final int bedEmpty;

  const WardOccupancy({
    required this.unitId,
    required this.nameEn,
    required this.nameAr,
    required this.bedFull,
    required this.bedEmpty,
  });

  int get total => bedFull + bedEmpty;

  String name(bool isArabic) => isArabic ? nameAr : nameEn;
}
