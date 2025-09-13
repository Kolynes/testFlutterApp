class BusinessDTO {
  final String name;
  final String businessLocation;
  final String contactNumber;

  BusinessDTO({
    required this.name,
    required this.businessLocation,
    required this.contactNumber,
  });

  factory BusinessDTO.fromJson(Map<String, dynamic> json) {
    return BusinessDTO(
      name: json['biz_name'],
      businessLocation: json['bss_location'],
      contactNumber: json['contct_no'],
    );
  }
}