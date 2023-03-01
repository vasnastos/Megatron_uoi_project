class Dataset {
  String pitch;
  String roll;
  String rtoe;
  String rheel;
  String ltoe;
  String lheel;
  String rhipx;
  String rhipy;
  String lhipx;
  String lhipy;
  static final columns = [
    "Pitch",
    "Roll",
    "RToe",
    "RHeel",
    "LToe",
    "LHeel",
    "RHipX",
    "RHipY",
    "LHipX",
    "LHipY"
  ];

  Dataset({
    required this.pitch,
    required this.roll,
    required this.rtoe,
    required this.rheel,
    required this.ltoe,
    required this.lheel,
    required this.rhipx,
    required this.rhipy,
    required this.lhipx,
    required this.lhipy,
  }
      // this.pitch,
      // this.roll,
      // this.rtoe,
      // this.rheel,
      // this.ltoe,
      // this.lheel,
      // this.rhipx,
      // this.rhipy,
      // this.lhipx,
      // this.lhipy,
      );

  // factory Dataset.fromMap(Map<String, dynamic> data) {
  //   return Dataset(
  //     data['Pitch'],
  //     data['Roll'],
  //     data['RToe'],
  //     data['RHeel'],
  //     data['LToe'],
  //     data['LHeel'],
  //     data['RHipX'],
  //     data['RHipY'],
  //     data['LHipX'],
  //     data['LHipY'],
  //   );
  // }

  factory Dataset.fromJson(Map<String, dynamic> json) {
    return Dataset(
      pitch: json['Pitch'] as String,
      roll: json['Roll'] as String,
      rtoe: json['RToe'] as String,
      rheel: json['RHeel'] as String,
      ltoe: json['LToe'] as String,
      lheel: json['LHeel'] as String,
      rhipx: json['RHipX'] as String,
      rhipy: json['RHipY'] as String,
      lhipx: json['LHipX'] as String,
      lhipy: json['LHipY'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        "Pitch": pitch,
        "Roll": roll,
        "RToe": rtoe,
        "RHeel": rheel,
        "LToe": ltoe,
        "RHipX": rhipx,
        "RHipY": rhipy,
        "LHipX": lhipx,
        "LHipY": lhipy,
      };

  String printData() {
    return "Pitch: $pitch\nRoll: $roll\nRToe: $rtoe\nRheel: $rheel\nLToe: $ltoe\nLHeel: $lheel\nRHipX: $rhipx\nRHipY: $rhipy\nLHipX: $lhipx\nLHipY: $lhipy";
  }
}
