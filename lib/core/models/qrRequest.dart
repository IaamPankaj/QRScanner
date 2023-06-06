class QRRequest {
  String? location;
  String? locationCode;
  String? lat;
  String? long;
  String? auth;
  String? id;

  QRRequest(
      {this.location,
      this.locationCode,
      this.lat,
      this.long,
      this.auth,
      this.id});

  QRRequest.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    locationCode = json['locationCode'];
    lat = json['lat'];
    long = json['long'];
    auth = json['auth'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    data['locationCode'] = locationCode;
    data['lat'] = lat;
    data['long'] = long;
    data['auth'] = auth;
    data['id'] = id;

    return data;
  }
}
