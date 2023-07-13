class USDAFdcId {
  String? foodClass;
  String? description;
  List<FoodNutrients>? foodNutrients;
  List<FoodAttributes>? foodAttributes;
  String? foodCode;
  String? startDate;
  String? endDate;
  WweiaFoodCategory? wweiaFoodCategory;
  int? fdcId;
  String? dataType;
  List<FoodPortions>? foodPortions;
  String? publicationDate;
  List<InputFoods>? inputFoods;
  String? discontinuedDate;
  List<dynamic>? foodComponents;
  String? modifiedDate;
  String? availableDate;
  String? brandOwner;
  String? brandName;
  String? dataSource;
  String? brandedFoodCategory;
  String? gtinUpc;
  String? ingredients;
  String? marketCountry;
  double? servingSize;
  String? servingSizeUnit;
  String? packageWeight;
  List<FoodUpdateLog>? foodUpdateLog;
  LabelNutrients? labelNutrients;

  USDAFdcId(
      {this.foodClass,
      this.description,
      this.foodNutrients,
      this.foodAttributes,
      this.foodCode,
      this.startDate,
      this.endDate,
      this.wweiaFoodCategory,
      this.fdcId,
      this.dataType,
      this.foodPortions,
      this.publicationDate,
      this.inputFoods,
      this.modifiedDate,
      this.availableDate,
      this.brandOwner,
      this.brandName,
      this.dataSource,
      this.brandedFoodCategory,
      this.gtinUpc,
      this.ingredients,
      this.marketCountry,
      this.servingSize,
      this.servingSizeUnit,
      this.packageWeight,
      this.foodUpdateLog,
      this.labelNutrients});

  USDAFdcId.fromJson(Map<String, dynamic> json) {
    foodClass = json['foodClass'];
    description = json['description'];
    if (json['foodNutrients'] != null) {
      foodNutrients = <FoodNutrients>[];
      json['foodNutrients'].forEach((v) {
        foodNutrients!.add(FoodNutrients.fromJson(v));
      });
    }
    if (json['foodAttributes'] != null) {
      foodAttributes = <FoodAttributes>[];
      json['foodAttributes'].forEach((v) {
        foodAttributes!.add(FoodAttributes.fromJson(v));
      });
    }
    foodCode = json['foodCode'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    wweiaFoodCategory = json['wweiaFoodCategory'] != null
        ? WweiaFoodCategory.fromJson(json['wweiaFoodCategory'])
        : null;
    fdcId = json['fdcId'];
    dataType = json['dataType'];
    if (json['foodPortions'] != null) {
      foodPortions = <FoodPortions>[];
      json['foodPortions'].forEach((v) {
        foodPortions!.add(FoodPortions.fromJson(v));
      });
    }
    publicationDate = json['publicationDate'];
    if (json['inputFoods'] != null) {
      inputFoods = <InputFoods>[];
      json['inputFoods'].forEach((v) {
        inputFoods!.add(InputFoods.fromJson(v));
      });
    }

    modifiedDate = json['modifiedDate'];
    availableDate = json['availableDate'];
    brandOwner = json['brandOwner'];
    brandName = json['brandName'];
    dataSource = json['dataSource'];
    brandedFoodCategory = json['brandedFoodCategory'];
    gtinUpc = json['gtinUpc'];
    ingredients = json['ingredients'];
    marketCountry = json['marketCountry'];
    servingSize = (json['servingSize'] ?? 100).toDouble();
    servingSizeUnit = json['servingSizeUnit'];
    packageWeight = json['packageWeight'];
    if (json['foodUpdateLog'] != null) {
      foodUpdateLog = <FoodUpdateLog>[];
      json['foodUpdateLog'].forEach((v) {
        foodUpdateLog!.add(FoodUpdateLog.fromJson(v));
      });
    }
    labelNutrients = json['labelNutrients'] != null
        ? LabelNutrients.fromJson(json['labelNutrients'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['foodClass'] = foodClass;
    data['description'] = description;
    if (foodNutrients != null) {
      data['foodNutrients'] = foodNutrients!.map((v) => v.toJson()).toList();
    }
    if (foodAttributes != null) {
      data['foodAttributes'] = foodAttributes!.map((v) => v.toJson()).toList();
    }
    data['foodCode'] = foodCode;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    if (wweiaFoodCategory != null) {
      data['wweiaFoodCategory'] = wweiaFoodCategory!.toJson();
    }
    data['fdcId'] = fdcId;
    data['dataType'] = dataType;
    if (foodPortions != null) {
      data['foodPortions'] = foodPortions!.map((v) => v.toJson()).toList();
    }
    data['publicationDate'] = publicationDate;
    if (inputFoods != null) {
      data['inputFoods'] = inputFoods!.map((v) => v.toJson()).toList();
    }

    data['modifiedDate'] = modifiedDate;
    data['availableDate'] = availableDate;
    data['brandOwner'] = brandOwner;
    data['brandName'] = brandName;
    data['dataSource'] = dataSource;
    data['brandedFoodCategory'] = brandedFoodCategory;
    data['gtinUpc'] = gtinUpc;
    data['ingredients'] = ingredients;
    data['marketCountry'] = marketCountry;
    data['servingSize'] = servingSize;
    data['servingSizeUnit'] = servingSizeUnit;
    data['packageWeight'] = packageWeight;
    if (foodUpdateLog != null) {
      data['foodUpdateLog'] = foodUpdateLog!.map((v) => v.toJson()).toList();
    }
    if (labelNutrients != null) {
      data['labelNutrients'] = labelNutrients!.toJson();
    }
    return data;
  }
}

class FoodUpdateLog {
  String? discontinuedDate;
  List<FoodAttributes>? foodAttributes;
  int? fdcId;
  String? description;
  String? publicationDate;
  String? dataType;
  String? foodClass;
  String? modifiedDate;
  String? availableDate;
  String? brandOwner;
  String? brandName;
  String? dataSource;
  String? brandedFoodCategory;
  String? gtinUpc;
  String? ingredients;
  String? marketCountry;
  double? servingSize;
  String? servingSizeUnit;
  String? packageWeight;
  String? subbrandName;
  String? notaSignificantSourceOf;
  String? householdServingFullText;

  FoodUpdateLog(
      {this.discontinuedDate,
      this.foodAttributes,
      this.fdcId,
      this.description,
      this.publicationDate,
      this.dataType,
      this.foodClass,
      this.modifiedDate,
      this.availableDate,
      this.brandOwner,
      this.brandName,
      this.dataSource,
      this.brandedFoodCategory,
      this.gtinUpc,
      this.ingredients,
      this.marketCountry,
      this.servingSize,
      this.servingSizeUnit,
      this.packageWeight,
      this.subbrandName,
      this.notaSignificantSourceOf,
      this.householdServingFullText});

  FoodUpdateLog.fromJson(Map<String, dynamic> json) {
    discontinuedDate = json['discontinuedDate'];
    if (json['foodAttributes'] != null) {
      foodAttributes = <FoodAttributes>[];
      json['foodAttributes'].forEach((v) {
        foodAttributes!.add(FoodAttributes.fromJson(v));
      });
    }
    fdcId = json['fdcId'];
    description = json['description'];
    publicationDate = json['publicationDate'];
    dataType = json['dataType'];
    foodClass = json['foodClass'];
    modifiedDate = json['modifiedDate'];
    availableDate = json['availableDate'];
    brandOwner = json['brandOwner'];
    brandName = json['brandName'];
    dataSource = json['dataSource'];
    brandedFoodCategory = json['brandedFoodCategory'];
    gtinUpc = json['gtinUpc'];
    ingredients = json['ingredients'];
    marketCountry = json['marketCountry'];
    servingSize = (json['servingSize'] ?? 100).toDouble();
    servingSizeUnit = json['servingSizeUnit'];
    packageWeight = json['packageWeight'];
    subbrandName = json['subbrandName'];
    notaSignificantSourceOf = json['notaSignificantSourceOf'];
    householdServingFullText = json['householdServingFullText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['discontinuedDate'] = discontinuedDate;
    if (foodAttributes != null) {
      data['foodAttributes'] = foodAttributes!.map((v) => v.toJson()).toList();
    }
    data['fdcId'] = fdcId;
    data['description'] = description;
    data['publicationDate'] = publicationDate;
    data['dataType'] = dataType;
    data['foodClass'] = foodClass;
    data['modifiedDate'] = modifiedDate;
    data['availableDate'] = availableDate;
    data['brandOwner'] = brandOwner;
    data['brandName'] = brandName;
    data['dataSource'] = dataSource;
    data['brandedFoodCategory'] = brandedFoodCategory;
    data['gtinUpc'] = gtinUpc;
    data['ingredients'] = ingredients;
    data['marketCountry'] = marketCountry;
    data['servingSize'] = servingSize;
    data['servingSizeUnit'] = servingSizeUnit;
    data['packageWeight'] = packageWeight;
    data['subbrandName'] = subbrandName;
    data['notaSignificantSourceOf'] = notaSignificantSourceOf;
    data['householdServingFullText'] = householdServingFullText;
    return data;
  }
}

class LabelNutrients {
  Fat? fat;
  SaturatedFat? saturatedFat;
  Fat? transFat;
  SaturatedFat? cholesterol;
  Fat? sodium;
  Fat? carbohydrates;
  Fat? fiber;
  Fat? sugars;
  Fat? protein;
  Fat? calcium;
  Fat? iron;
  SaturatedFat? calories;

  LabelNutrients(
      {this.fat,
      this.saturatedFat,
      this.transFat,
      this.cholesterol,
      this.sodium,
      this.carbohydrates,
      this.fiber,
      this.sugars,
      this.protein,
      this.calcium,
      this.iron,
      this.calories});

  LabelNutrients.fromJson(Map<String, dynamic> json) {
    fat = json['fat'] != null ? Fat.fromJson(json['fat']) : null;
    saturatedFat = json['saturatedFat'] != null
        ? SaturatedFat.fromJson(json['saturatedFat'])
        : null;
    transFat = json['transFat'] != null ? Fat.fromJson(json['transFat']) : null;
    cholesterol = json['cholesterol'] != null
        ? SaturatedFat.fromJson(json['cholesterol'])
        : null;
    sodium = json['sodium'] != null ? Fat.fromJson(json['sodium']) : null;
    carbohydrates = json['carbohydrates'] != null
        ? Fat.fromJson(json['carbohydrates'])
        : null;
    fiber = json['fiber'] != null ? Fat.fromJson(json['fiber']) : null;
    sugars = json['sugars'] != null ? Fat.fromJson(json['sugars']) : null;
    protein = json['protein'] != null ? Fat.fromJson(json['protein']) : null;
    calcium = json['calcium'] != null ? Fat.fromJson(json['calcium']) : null;
    iron = json['iron'] != null ? Fat.fromJson(json['iron']) : null;
    calories = json['calories'] != null
        ? SaturatedFat.fromJson(json['calories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fat != null) {
      data['fat'] = fat!.toJson();
    }
    if (saturatedFat != null) {
      data['saturatedFat'] = saturatedFat!.toJson();
    }
    if (transFat != null) {
      data['transFat'] = transFat!.toJson();
    }
    if (cholesterol != null) {
      data['cholesterol'] = cholesterol!.toJson();
    }
    if (sodium != null) {
      data['sodium'] = sodium!.toJson();
    }
    if (carbohydrates != null) {
      data['carbohydrates'] = carbohydrates!.toJson();
    }
    if (fiber != null) {
      data['fiber'] = fiber!.toJson();
    }
    if (sugars != null) {
      data['sugars'] = sugars!.toJson();
    }
    if (protein != null) {
      data['protein'] = protein!.toJson();
    }
    if (calcium != null) {
      data['calcium'] = calcium!.toJson();
    }
    if (iron != null) {
      data['iron'] = iron!.toJson();
    }
    if (calories != null) {
      data['calories'] = calories!.toJson();
    }
    return data;
  }
}

class FoodNutrients {
  String? type;
  int? id;
  FoodNutrientDerivation? foodNutrientDerivation;
  Nutrient? nutrient;
  double? amount;

  FoodNutrients(
      {this.type,
      this.id,
      this.nutrient,
      this.amount,
      this.foodNutrientDerivation});

  FoodNutrients.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = (json['id'] ?? 0).toInt();
    foodNutrientDerivation = json['foodNutrientDerivation'] != null
        ? FoodNutrientDerivation.fromJson(json['foodNutrientDerivation'])
        : null;
    nutrient =
        json['nutrient'] != null ? Nutrient.fromJson(json['nutrient']) : null;
    amount = (json['amount'] ?? 0).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    if (nutrient != null) {
      data['nutrient'] = nutrient!.toJson();
    }
    if (foodNutrientDerivation != null) {
      data['foodNutrientDerivation'] = foodNutrientDerivation!.toJson();
    }
    data['amount'] = amount;
    return data;
  }
}

class FoodNutrientDerivation {
  int? id;
  String? code;
  String? description;

  FoodNutrientDerivation({this.id, this.code, this.description});

  FoodNutrientDerivation.fromJson(Map<String, dynamic> json) {
    id = (json['id'] ?? 0).toInt();
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['description'] = description;
    return data;
  }
}

class Nutrient {
  int? id;
  String? number;
  String? name;
  int? rank;
  String? unitName;

  Nutrient({this.id, this.number, this.name, this.rank, this.unitName});

  Nutrient.fromJson(Map<String, dynamic> json) {
    id = (json['id'] ?? 0).toInt();
    number = json['number'];
    name = json['name'];
    rank = (json['rank'] ?? 0).toInt();
    unitName = json['unitName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['number'] = number;
    data['name'] = name;
    data['rank'] = rank;
    data['unitName'] = unitName;
    return data;
  }
}

class FoodAttributes {
  int? id;
  String? value;
  FoodAttributeType? foodAttributeType;
  int? rank;
  String? name;

  FoodAttributes(
      {this.id, this.value, this.foodAttributeType, this.rank, this.name});

  FoodAttributes.fromJson(Map<String, dynamic> json) {
    id = (json['id'] ?? 0).toInt();
    value = json['value'].toString();
    foodAttributeType = json['foodAttributeType'] != null
        ? FoodAttributeType.fromJson(json['foodAttributeType'])
        : null;
    rank = (json['rank'] ?? 0).toInt();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    if (foodAttributeType != null) {
      data['foodAttributeType'] = foodAttributeType!.toJson();
    }
    data['rank'] = rank;
    data['name'] = name;
    return data;
  }
}

class FoodAttributeType {
  int? id;
  String? name;
  String? description;

  FoodAttributeType({this.id, this.name, this.description});

  FoodAttributeType.fromJson(Map<String, dynamic> json) {
    id = (json['id'] ?? 0).toInt();
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

class WweiaFoodCategory {
  int? wweiaFoodCategoryCode;
  String? wweiaFoodCategoryDescription;

  WweiaFoodCategory(
      {this.wweiaFoodCategoryCode, this.wweiaFoodCategoryDescription});

  WweiaFoodCategory.fromJson(Map<String, dynamic> json) {
    wweiaFoodCategoryCode = (json['wweiaFoodCategoryCode'] ?? 0).toInt();
    wweiaFoodCategoryDescription = json['wweiaFoodCategoryDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wweiaFoodCategoryCode'] = wweiaFoodCategoryCode;
    data['wweiaFoodCategoryDescription'] = wweiaFoodCategoryDescription;
    return data;
  }
}

class FoodPortions {
  int? id;
  MeasureUnit? measureUnit;
  String? modifier;
  int? gramWeight;
  int? sequenceNumber;
  String? portionDescription;

  FoodPortions(
      {this.id,
      this.measureUnit,
      this.modifier,
      this.gramWeight,
      this.sequenceNumber,
      this.portionDescription});

  FoodPortions.fromJson(Map<String, dynamic> json) {
    id = (json['id'] ?? 0).toInt();
    measureUnit = json['measureUnit'] != null
        ? MeasureUnit.fromJson(json['measureUnit'])
        : null;
    modifier = json['modifier'];
    gramWeight = (json['gramWeight'] ?? 0).toInt();
    sequenceNumber = (json['sequenceNumber'] ?? 0).toInt();
    portionDescription = json['portionDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (measureUnit != null) {
      data['measureUnit'] = measureUnit!.toJson();
    }
    data['modifier'] = modifier;
    data['gramWeight'] = gramWeight;
    data['sequenceNumber'] = sequenceNumber;
    data['portionDescription'] = portionDescription;
    return data;
  }
}

class MeasureUnit {
  int? id;
  String? name;
  String? abbreviation;

  MeasureUnit({this.id, this.name, this.abbreviation});

  MeasureUnit.fromJson(Map<String, dynamic> json) {
    id = (json['id'] ?? 0).toInt();
    name = json['name'];
    abbreviation = json['abbreviation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['abbreviation'] = abbreviation;
    return data;
  }
}

class InputFoods {
  int? id;
  String? unit;
  String? portionDescription;
  String? portionCode;
  String? foodDescription;
  int? sequenceNumber;
  int? amount;
  int? ingredientCode;
  String? ingredientDescription;
  int? ingredientWeight;

  InputFoods(
      {this.id,
      this.unit,
      this.portionDescription,
      this.portionCode,
      this.foodDescription,
      this.sequenceNumber,
      this.amount,
      this.ingredientCode,
      this.ingredientDescription,
      this.ingredientWeight});

  InputFoods.fromJson(Map<String, dynamic> json) {
    id = (json['id'] ?? 0).toInt();
    unit = json['unit'];
    portionDescription = json['portionDescription'];
    portionCode = json['portionCode'];
    foodDescription = json['foodDescription'];
    sequenceNumber = (json['sequenceNumber'] ?? 0).toInt();
    amount = (json['amount'] ?? 0).toInt();
    ingredientCode = (json['ingredientCode'] ?? 0).toInt();
    ingredientDescription = json['ingredientDescription'];
    ingredientWeight = (json['ingredientWeight'] ?? 0).toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unit'] = unit;
    data['portionDescription'] = portionDescription;
    data['portionCode'] = portionCode;
    data['foodDescription'] = foodDescription;
    data['sequenceNumber'] = sequenceNumber;
    data['amount'] = amount;
    data['ingredientCode'] = ingredientCode;
    data['ingredientDescription'] = ingredientDescription;
    data['ingredientWeight'] = ingredientWeight;
    return data;
  }
}

class Fat {
  double? value;

  Fat({this.value});

  Fat.fromJson(Map<String, dynamic> json) {
    value = (json['value'] ?? 0).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    return data;
  }
}

class SaturatedFat {
  double? value;

  SaturatedFat({this.value});

  SaturatedFat.fromJson(Map<String, dynamic> json) {
    value = (json['value'] ?? 0).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    return data;
  }
}
