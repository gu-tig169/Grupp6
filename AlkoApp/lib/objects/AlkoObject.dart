//Ett helt AlkoObject, from & to Json

class AlkoObject {
  var idDrink;
  var strDrink;
  var strDrinkAlternate;
  var strDrinkES;
  var strDrinkDE;
  var strDrinkFR;
  var strDrinkZHHANS;
  var strDrinkZHHANT;
  var strTags;
  var strVideo;
  var strCategory;
  var strIBA;
  var strAlcoholic;
  var strGlass;
  var strInstructions;
  var strInstructionsES;
  var strInstructionsDE;
  var strInstructionsFR;
  var strInstructionsZHHANS;
  var strInstructionsZHHANT;
  var strDrinkThumb;
  var strIngredient1;
  var strIngredient2;
  var strIngredient3;
  var strIngredient4;
  var strIngredient5;
  var strIngredient6;
  var strIngredient7;
  var strIngredient8;
  var strIngredient9;
  var strIngredient10;
  var strIngredient11;
  var strIngredient12;
  var strIngredient13;
  var strIngredient14;
  var strIngredient15;
  var strMeasure1;
  var strMeasure2;
  var strMeasure3;
  var strMeasure4;
  var strMeasure5;
  var strMeasure6;
  var strMeasure7;
  var strMeasure8;
  var strMeasure9;
  var strMeasure10;
  var strMeasure11;
  var strMeasure12;
  var strMeasure13;
  var strMeasure14;
  var strMeasure15;
  var strImageSource;
  var strImageAttribution;
  var strCreativeCommonsConfirmed;
  var dateModified;
  bool isFavorite = false;

  String get getStrDrink => strDrink;

  bool get getIsFavorite => isFavorite;

  AlkoObject(
      {this.idDrink,
      this.strDrink,
      this.strDrinkAlternate,
      this.strDrinkES,
      this.strDrinkDE,
      this.strDrinkFR,
      this.strDrinkZHHANS,
      this.strDrinkZHHANT,
      this.strTags,
      this.strVideo,
      this.strCategory,
      this.strIBA,
      this.strAlcoholic,
      this.strGlass,
      this.strInstructions,
      this.strInstructionsES,
      this.strInstructionsDE,
      this.strInstructionsFR,
      this.strInstructionsZHHANS,
      this.strInstructionsZHHANT,
      this.strDrinkThumb,
      this.strIngredient1,
      this.strIngredient2,
      this.strIngredient3,
      this.strIngredient4,
      this.strIngredient5,
      this.strIngredient6,
      this.strIngredient7,
      this.strIngredient8,
      this.strIngredient9,
      this.strIngredient10,
      this.strIngredient11,
      this.strIngredient12,
      this.strIngredient13,
      this.strIngredient14,
      this.strIngredient15,
      this.strMeasure1,
      this.strMeasure2,
      this.strMeasure3,
      this.strMeasure4,
      this.strMeasure5,
      this.strMeasure6,
      this.strMeasure7,
      this.strMeasure8,
      this.strMeasure9,
      this.strMeasure10,
      this.strMeasure11,
      this.strMeasure12,
      this.strMeasure13,
      this.strMeasure14,
      this.strMeasure15,
      this.strImageSource,
      this.strImageAttribution,
      this.strCreativeCommonsConfirmed,
      this.dateModified,
      this.isFavorite = false});

  AlkoObject.fromJson(Map<dynamic, dynamic> json) {
    idDrink = json['idDrink'];
    strDrink = json['strDrink'];
    strDrinkAlternate = json['strDrinkAlternate'];
    strDrinkES = json['strDrinkES'];
    strDrinkDE = json['strDrinkDE'];
    strDrinkFR = json['strDrinkFR'];
    strDrinkZHHANS = json['strDrinkZH-HANS'];
    strDrinkZHHANT = json['strDrinkZH-HANT'];
    strTags = json['strTags'];
    strVideo = json['strVideo'];
    strCategory = json['strCategory'];
    strIBA = json['strIBA'];
    strAlcoholic = json['strAlcoholic'];
    strGlass = json['strGlass'];
    strInstructions = json['strInstructions'];
    strInstructionsES = json['strInstructionsES'];
    strInstructionsDE = json['strInstructionsDE'];
    strInstructionsFR = json['strInstructionsFR'];
    strInstructionsZHHANS = json['strInstructionsZH-HANS'];
    strInstructionsZHHANT = json['strInstructionsZH-HANT'];
    strDrinkThumb = json['strDrinkThumb'];
    strIngredient1 = json['strIngredient1'];
    strIngredient2 = json['strIngredient2'];
    strIngredient3 = json['strIngredient3'];
    strIngredient4 = json['strIngredient4'];
    strIngredient5 = json['strIngredient5'];
    strIngredient6 = json['strIngredient6'];
    strIngredient7 = json['strIngredient7'];
    strIngredient8 = json['strIngredient8'];
    strIngredient9 = json['strIngredient9'];
    strIngredient10 = json['strIngredient10'];
    strIngredient11 = json['strIngredient11'];
    strIngredient12 = json['strIngredient12'];
    strIngredient13 = json['strIngredient13'];
    strIngredient14 = json['strIngredient14'];
    strIngredient15 = json['strIngredient15'];
    strMeasure1 = json['strMeasure1'];
    strMeasure2 = json['strMeasure2'];
    strMeasure3 = json['strMeasure3'];
    strMeasure4 = json['strMeasure4'];
    strMeasure5 = json['strMeasure5'];
    strMeasure6 = json['strMeasure6'];
    strMeasure7 = json['strMeasure7'];
    strMeasure8 = json['strMeasure8'];
    strMeasure9 = json['strMeasure9'];
    strMeasure10 = json['strMeasure10'];
    strMeasure11 = json['strMeasure11'];
    strMeasure12 = json['strMeasure12'];
    strMeasure13 = json['strMeasure13'];
    strMeasure14 = json['strMeasure14'];
    strMeasure15 = json['strMeasure15'];
    strImageSource = json['strImageSource'];
    strImageAttribution = json['strImageAttribution'];
    strCreativeCommonsConfirmed = json['strCreativeCommonsConfirmed'];
    dateModified = json['dateModified'];
    isFavorite = false;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['idDrink'] = this.idDrink;
    data['strDrink'] = this.strDrink;
    data['strDrinkAlternate'] = this.strDrinkAlternate;
    data['strDrinkES'] = this.strDrinkES;
    data['strDrinkDE'] = this.strDrinkDE;
    data['strDrinkFR'] = this.strDrinkFR;
    data['strDrinkZH-HANS'] = this.strDrinkZHHANS;
    data['strDrinkZH-HANT'] = this.strDrinkZHHANT;
    data['strTags'] = this.strTags;
    data['strVideo'] = this.strVideo;
    data['strCategory'] = this.strCategory;
    data['strIBA'] = this.strIBA;
    data['strAlcoholic'] = this.strAlcoholic;
    data['strGlass'] = this.strGlass;
    data['strInstructions'] = this.strInstructions;
    data['strInstructionsES'] = this.strInstructionsES;
    data['strInstructionsDE'] = this.strInstructionsDE;
    data['strInstructionsFR'] = this.strInstructionsFR;
    data['strInstructionsZH-HANS'] = this.strInstructionsZHHANS;
    data['strInstructionsZH-HANT'] = this.strInstructionsZHHANT;
    data['strDrinkThumb'] = this.strDrinkThumb;
    data['strIngredient1'] = this.strIngredient1;
    data['strIngredient2'] = this.strIngredient2;
    data['strIngredient3'] = this.strIngredient3;
    data['strIngredient4'] = this.strIngredient4;
    data['strIngredient5'] = this.strIngredient5;
    data['strIngredient6'] = this.strIngredient6;
    data['strIngredient7'] = this.strIngredient7;
    data['strIngredient8'] = this.strIngredient8;
    data['strIngredient9'] = this.strIngredient9;
    data['strIngredient10'] = this.strIngredient10;
    data['strIngredient11'] = this.strIngredient11;
    data['strIngredient12'] = this.strIngredient12;
    data['strIngredient13'] = this.strIngredient13;
    data['strIngredient14'] = this.strIngredient14;
    data['strIngredient15'] = this.strIngredient15;
    data['strMeasure1'] = this.strMeasure1;
    data['strMeasure2'] = this.strMeasure2;
    data['strMeasure3'] = this.strMeasure3;
    data['strMeasure4'] = this.strMeasure4;
    data['strMeasure5'] = this.strMeasure5;
    data['strMeasure6'] = this.strMeasure6;
    data['strMeasure7'] = this.strMeasure7;
    data['strMeasure8'] = this.strMeasure8;
    data['strMeasure9'] = this.strMeasure9;
    data['strMeasure10'] = this.strMeasure10;
    data['strMeasure11'] = this.strMeasure11;
    data['strMeasure12'] = this.strMeasure12;
    data['strMeasure13'] = this.strMeasure13;
    data['strMeasure14'] = this.strMeasure14;
    data['strMeasure15'] = this.strMeasure15;
    data['strImageSource'] = this.strImageSource;
    data['strImageAttribution'] = this.strImageAttribution;
    data['strCreativeCommonsConfirmed'] = this.strCreativeCommonsConfirmed;
    data['dateModified'] = this.dateModified;
    return data;
  }

  @override
  String toString() {
    return "${this.strDrink}";
  }
}
