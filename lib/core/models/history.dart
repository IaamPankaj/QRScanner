class History {
  String? location;
  String? locationCode;
  String? lat;
  String? long;
  bool? status;
  String? auth;
  String? userId;
  String? createdAt;
  String? distance;
  String? floor;

  History({
    this.location,
    this.locationCode,
    this.lat,
    this.long,
    this.status,
    this.auth,
    this.userId,
    this.createdAt,
    this.distance = '',
    this.floor,
  });

  History.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    locationCode = json['location_code'];
    lat = json['lat'];
    long = json['long'];
    status = json['status'];
    auth = json['auth'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    distance = json['distance'];
    floor = json['floor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    data['location_code'] = locationCode;
    data['lat'] = lat;
    data['long'] = long;
    data['status'] = status;
    data['auth'] = auth;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['distance'] = distance;
    data['floor'] = floor;
    return data;
  }
}
