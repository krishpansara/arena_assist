class RideOption {
  final String provider;
  final double price;
  final int eta;
  final String tag;

  RideOption({
    required this.provider,
    required this.price,
    required this.eta,
    this.tag = '',
  });

  factory RideOption.fromJson(Map<String, dynamic> json) {
    return RideOption(
      provider: json['provider'] as String,
      price: (json['price'] as num).toDouble(),
      eta: json['eta'] as int,
      tag: json['tag'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'price': price,
      'eta': eta,
      'tag': tag,
    };
  }
}

class RideEstimationResponse {
  final double distanceKm;
  final int estimatedTimeMin;
  final List<RideOption> rides;

  RideEstimationResponse({
    required this.distanceKm,
    required this.estimatedTimeMin,
    required this.rides,
  });

  factory RideEstimationResponse.fromJson(Map<String, dynamic> json) {
    return RideEstimationResponse(
      distanceKm: (json['distance_km'] as num).toDouble(),
      estimatedTimeMin: json['estimated_time_min'] as int,
      rides: (json['rides'] as List<dynamic>)
          .map((e) => RideOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance_km': distanceKm,
      'estimated_time_min': estimatedTimeMin,
      'rides': rides.map((e) => e.toJson()).toList(),
    };
  }
}
