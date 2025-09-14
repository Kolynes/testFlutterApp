class ServiceDTO {
  final String name;
  final String businessName;

  ServiceDTO({
    required this.name,
    required this.businessName,
  });

  factory ServiceDTO.fromJson(Map<dynamic, dynamic> json) {
    return ServiceDTO(
      name: json['service_name'],
      businessName: json['business_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_name': name,
      'business_name': businessName,
    };
  }
}