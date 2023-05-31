class Assessment {
  String? id;
  String? pupilFK;
  String? oldPupil;
// body composition
  double? currentWeight;
  double? hight;
  double? bmi;
// skin folds
  int? subscapularis;
  int? bicipital;
  int? thickness;
  int? midaxillary;
  int? suprailiac;
  int? breastplate;
  int? abdominal;
  int? thigh;
  int? calf;
// Pollock 7 skin folds
  double? fatIdeal;
  double? currentFat;
  double? leanMass;
  double? fatMass;

  Assessment(
      {this.id,
      this.currentWeight,
      this.hight,
      this.subscapularis,
      this.bicipital,
      this.thickness,
      this.midaxillary,
      this.suprailiac,
      this.breastplate,
      this.abdominal,
      this.thigh,
      this.calf,
      this.fatIdeal,
      this.currentFat,
      this.leanMass,
      this.fatMass,
      this.bmi,
      this.pupilFK,
      this.oldPupil});

  Assessment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currentWeight = double.parse(json['current_weight']);
    hight = double.parse(json['hight']);
    subscapularis = int.parse(json['subscapularis']);
    bicipital = int.parse(json['bicipital']);
    thickness = int.parse(json['thickness']);
    midaxillary = int.parse(json['midaxillary']);
    suprailiac = int.parse(json['suprailiac']);
    breastplate = int.parse(json['breastplate']);
    abdominal = int.parse(json['abdominal']);
    thigh = int.parse(json['thigh']);
    calf = int.parse(json['calf']);
    fatIdeal = double.parse(json['fat_ideal']);
    currentFat = double.parse(json['current_fat']);
    leanMass = double.parse(json['lean_mass']);
    fatMass = double.parse(json['fat_mass']);
    bmi = double.parse(json['bmi']);
    pupilFK = json['pupil_fk'];
  }

  double pollockSevenSkinFolds(
      String subscapularis,
      String thickness,
      String midaxillary,
      String suprailiac,
      String breastplate,
      String abdominal,
      String thigh,
      int old) {
    var sumSevenSkinFolds =
        double.parse(subscapularis.replaceAll(RegExp(r','), '.')) +
            double.parse(thickness.replaceAll(RegExp(r','), '.')) +
            double.parse(midaxillary.replaceAll(RegExp(r','), '.')) +
            double.parse(suprailiac.replaceAll(RegExp(r','), '.')) +
            double.parse(breastplate.replaceAll(RegExp(r','), '.')) +
            double.parse(abdominal.replaceAll(RegExp(r','), '.')) +
            double.parse(thigh.replaceAll(RegExp(r','), '.'));

    var result = ((4.95 /
                    ((1.112 -
                        (0.00043499 * sumSevenSkinFolds) +
                        (0.00000055 * (sumSevenSkinFolds * sumSevenSkinFolds)) -
                        (0.0002882 * old))) -
                4.5) *
            100)
        .toStringAsFixed(2);

    return double.parse(result.replaceAll(RegExp(r','), '.'));
  }

  double calcFatMass(double weight, double currentFat) {
    var result = ((weight * currentFat) / 100).toStringAsFixed(2);
    return double.parse(result.replaceAll(RegExp(r','), '.'));
  }

  double calcLeanMass(double weight, double fatMass) {
    var result = (weight - fatMass).toStringAsFixed(2);
    return double.parse(result.replaceAll(RegExp(r','), '.'));
  }

  String relationEntreWaistAndHip(
      double waist, double hip, String sex, int old) {
    var result = (waist / hip).toStringAsFixed(2);
    var resultDouble = double.parse(result.replaceAll(RegExp(r','), '.'));
    print(resultDouble);
    var risk = "Indeterminado";
    if (sex == "Feminino") {
      if (old > 19 && old < 30) {
        if (resultDouble < 0.71) {
          risk = "Baixo";
        }
        if (resultDouble > 0.70 && resultDouble < 0.78) {
          risk = "Moderado";
        }
        if (resultDouble > 0.77 && resultDouble < 0.83) {
          risk = "Alto";
        }
        if (resultDouble > 0.82) {
          risk = "Muito Alto";
        }
      }
      if (old > 29 && old < 40) {
        if (resultDouble < 0.72) {
          risk = "Baixo";
        }
        if (resultDouble > 0.71 && resultDouble < 0.79) {
          risk = "Moderado";
        }
        if (resultDouble > 0.78 && resultDouble < 0.85) {
          risk = "Alto";
        }
        if (resultDouble > 0.84) {
          risk = "Muito Alto";
        }
      }
      if (old > 39 && old < 50) {
        if (resultDouble < 0.73) {
          risk = "Baixo";
        }
        if (resultDouble > 0.72 && resultDouble < 0.80) {
          risk = "Moderado";
        }
        if (resultDouble > 0.79 && resultDouble < 0.88) {
          risk = "Alto";
        }
        if (resultDouble > 0.86) {
          risk = "Muito Alto";
        }
      }
      if (old > 49 && old < 60) {
        if (resultDouble < 0.74) {
          risk = "Baixo";
        }
        if (resultDouble > 0.73 && resultDouble < 0.82) {
          risk = "Moderado";
        }
        if (resultDouble > 0.81 && resultDouble < 0.89) {
          risk = "Alto";
        }
        if (resultDouble > 0.88) {
          risk = "Muito Alto";
        }
      }
    } else {
      if (old > 19 && old < 30) {
        if (resultDouble < 0.83) {
          risk = "Baixo";
        }
        if (resultDouble > 0.82 && resultDouble < 0.89) {
          risk = "Moderado";
        }
        if (resultDouble > 0.88 && resultDouble < 0.95) {
          risk = "Alto";
        }
        if (resultDouble > 0.94) {
          risk = "Muito Alto";
        }
      }
      if (old > 29 && old < 40) {
        if (resultDouble < 0.84) {
          risk = "Baixo";
        }
        if (resultDouble > 0.83 && resultDouble < 0.92) {
          risk = "Moderado";
        }
        if (resultDouble > 0.91 && resultDouble < 0.97) {
          risk = "Alto";
        }
        if (resultDouble > 0.96) {
          risk = "Muito Alto";
        }
      }
      if (old > 39 && old < 50) {
        if (resultDouble < 0.88) {
          risk = "Baixo";
        }
        if (resultDouble > 0.87 && resultDouble < 0.96) {
          risk = "Moderado";
        }
        if (resultDouble > 0.95 && resultDouble < 1.01) {
          risk = "Alto";
        }
        if (resultDouble > 1) {
          risk = "Muito Alto";
        }
      }
      if (old > 49 && old < 60) {
        if (resultDouble < 0.90) {
          risk = "Baixo";
        }
        if (resultDouble > 0.89 && resultDouble < 0.97) {
          risk = "Moderado";
        }
        if (resultDouble > 0.96 && resultDouble < 1.03) {
          risk = "Alto";
        }
        if (resultDouble > 1.02) {
          risk = "Muito Alto";
        }
      }
    }
    return "$resultDouble: $risk";
  }
}
