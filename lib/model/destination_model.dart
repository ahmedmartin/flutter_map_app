class Destination_mode {
  String? _country;
  String? _name;
  String? _lat;
  String? _lng;

  Destination_mode({String? country, String? name, String? lat, String? lng}) {
    if (country != null) {
      this._country = country;
    }
    if (name != null) {
      this._name = name;
    }
    if (lat != null) {
      this._lat = lat;
    }
    if (lng != null) {
      this._lng = lng;
    }
  }

  String? get country => _country;
  set country(String? country) => _country = country;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get lat => _lat;
  set lat(String? lat) => _lat = lat;
  String? get lng => _lng;
  set lng(String? lng) => _lng = lng;

  Destination_mode.fromJson(Map<String, dynamic> json) {
    _country = json['country'];
    _name = json['name'];
    _lat = json['lat'];
    _lng = json['lng'];
    if(_lat==null||_lng==null) {
      _lat = json['Latitude'];
      _lng = json['Longitude'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this._country;
    data['name'] = this._name;
    data['lat'] = this._lat;
    data['lng'] = this._lng;
    return data;
  }
}
