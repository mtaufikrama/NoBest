class USDASearch {
  int? totalHits;
  int? currentPage;
  int? totalPages;
  List<int>? pageList;
  FoodSearchCriteria? foodSearchCriteria;
  List<Foods>? foods;
  Aggregations? aggregations;

  USDASearch(
      {this.totalHits,
      this.currentPage,
      this.totalPages,
      this.pageList,
      this.foodSearchCriteria,
      this.foods,
      this.aggregations});

  USDASearch.fromJson(Map<dynamic, dynamic> json) {
    totalHits = json['totalHits'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    pageList = (json['pageList'] ?? []).cast<int>();
    foodSearchCriteria = json['foodSearchCriteria'] != null
        ? FoodSearchCriteria.fromJson(json['foodSearchCriteria'])
        : null;
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods!.add(Foods.fromJson(v));
      });
    }
    aggregations = json['aggregations'] != null
        ? Aggregations.fromJson(json['aggregations'])
        : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <String, dynamic>{};
    data['totalHits'] = totalHits;
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['pageList'] = pageList;
    if (foodSearchCriteria != null) {
      data['foodSearchCriteria'] = foodSearchCriteria!.toJson();
    }
    if (foods != null) {
      data['foods'] = foods!.map((v) => v.toJson()).toList();
    }
    if (aggregations != null) {
      data['aggregations'] = aggregations!.toJson();
    }
    return data;
  }
}

class FoodSearchCriteria {
  String? query;
  String? generalSearchInput;
  int? pageNumber;
  int? numberOfResultsPerPage;
  int? pageSize;
  bool? requireAllWords;

  FoodSearchCriteria(
      {this.query,
      this.generalSearchInput,
      this.pageNumber,
      this.numberOfResultsPerPage,
      this.pageSize,
      this.requireAllWords});

  FoodSearchCriteria.fromJson(Map<dynamic, dynamic> json) {
    query = json['query'];
    generalSearchInput = json['generalSearchInput'];
    pageNumber = json['pageNumber'];
    numberOfResultsPerPage = json['numberOfResultsPerPage'];
    pageSize = json['pageSize'];
    requireAllWords = json['requireAllWords'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <String, dynamic>{};
    data['query'] = query;
    data['generalSearchInput'] = generalSearchInput;
    data['pageNumber'] = pageNumber;
    data['numberOfResultsPerPage'] = numberOfResultsPerPage;
    data['pageSize'] = pageSize;
    data['requireAllWords'] = requireAllWords;
    return data;
  }
}

class Foods {
  int? fdcId;
  String? description;
  String? dataType;
  String? gtinUpc;
  String? publishedDate;
  String? brandOwner;
  String? brandName;
  String? ingredients;
  String? marketCountry;
  String? foodCategory;
  String? modifiedDate;
  String? dataSource;
  String? packageWeight;
  String? servingSizeUnit;
  double? servingSize;
  List<String>? tradeChannels;
  String? allHighlightFields;
  double? score;
  dynamic microbes;
  List<FoodNutrients>? foodNutrients;
  List<FinalFoodInputFoods>? finalFoodInputFoods;
  List<FoodMeasures>? foodMeasures;
  dynamic foodAttributes;
  List<FoodAttributeTypes>? foodAttributeTypes;
  dynamic foodVersionIds;
  String? commonNames;
  String? additionalDescriptions;
  int? foodCode;
  int? foodCategoryId;
  int? ndbNumber;

  Foods(
      {this.fdcId,
      this.description,
      this.dataType,
      this.gtinUpc,
      this.publishedDate,
      this.brandOwner,
      this.brandName,
      this.ingredients,
      this.marketCountry,
      this.foodCategory,
      this.modifiedDate,
      this.dataSource,
      this.packageWeight,
      this.servingSizeUnit,
      this.servingSize,
      this.tradeChannels,
      this.allHighlightFields,
      this.score,
      this.microbes,
      this.foodNutrients,
      this.finalFoodInputFoods,
      this.foodMeasures,
      this.foodAttributes,
      this.foodAttributeTypes,
      this.foodVersionIds,
      this.commonNames,
      this.additionalDescriptions,
      this.foodCode,
      this.foodCategoryId,
      this.ndbNumber});

  Foods.fromJson(Map<dynamic, dynamic> json) {
    fdcId = json['fdcId'];
    description = json['description'];
    dataType = json['dataType'];
    gtinUpc = json['gtinUpc'];
    publishedDate = json['publishedDate'];
    brandOwner = json['brandOwner'];
    brandName = json['brandName'];
    ingredients = json['ingredients'];
    marketCountry = json['marketCountry'];
    foodCategory = json['foodCategory'];
    modifiedDate = json['modifiedDate'];
    dataSource = json['dataSource'];
    packageWeight = json['packageWeight'];
    servingSizeUnit = json['servingSizeUnit'];
    servingSize = (json['servingSize'] ?? 100).toDouble();
    tradeChannels = (json['tradeChannels'] ?? []).cast<String>();
    allHighlightFields = json['allHighlightFields'];
    score = (json['score'] ?? 0).toDouble();
    microbes = json['microbes'];
    foodAttributes = json['foodAttributes'];
    if (json['foodNutrients'] != null) {
      foodNutrients = <FoodNutrients>[];
      json['foodNutrients'].forEach((v) {
        foodNutrients!.add(FoodNutrients.fromJson(v));
      });
    }
    if (json['finalFoodInputFoods'] != null) {
      finalFoodInputFoods = <FinalFoodInputFoods>[];
      json['finalFoodInputFoods'].forEach((v) {
        finalFoodInputFoods!.add(FinalFoodInputFoods.fromJson(v));
      });
    }
    if (json['foodMeasures'] != null) {
      foodMeasures = <FoodMeasures>[];
      json['foodMeasures'].forEach((v) {
        foodMeasures!.add(FoodMeasures.fromJson(v));
      });
    }
    if (json['foodAttributeTypes'] != null) {
      foodAttributeTypes = <FoodAttributeTypes>[];
      json['foodAttributeTypes'].forEach((v) {
        foodAttributeTypes!.add(FoodAttributeTypes.fromJson(v));
      });
    }
    foodVersionIds = json['foodVersionIds'];
    commonNames = json['commonNames'];
    additionalDescriptions = json['additionalDescriptions'];
    foodCode = json['foodCode'];
    foodCategoryId = json['foodCategoryId'];
    ndbNumber = json['ndbNumber'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['fdcId'] = fdcId;
    data['description'] = description;
    data['dataType'] = dataType;
    data['gtinUpc'] = gtinUpc;
    data['publishedDate'] = publishedDate;
    data['brandOwner'] = brandOwner;
    data['brandName'] = brandName;
    data['ingredients'] = ingredients;
    data['marketCountry'] = marketCountry;
    data['foodCategory'] = foodCategory;
    data['modifiedDate'] = modifiedDate;
    data['dataSource'] = dataSource;
    data['packageWeight'] = packageWeight;
    data['servingSizeUnit'] = servingSizeUnit;
    data['servingSize'] = servingSize;
    data['tradeChannels'] = tradeChannels;
    data['allHighlightFields'] = allHighlightFields;
    data['score'] = score;
    if (microbes != null) {
      data['microbes'] = microbes!.map((v) => v.toJson()).toList();
    }
    if (foodNutrients != null) {
      data['foodNutrients'] = foodNutrients!.map((v) => v.toJson()).toList();
    }
    if (finalFoodInputFoods != null) {
      data['finalFoodInputFoods'] =
          finalFoodInputFoods!.map((v) => v.toJson()).toList();
    }
    if (foodMeasures != null) {
      data['foodMeasures'] = foodMeasures!.map((v) => v.toJson()).toList();
    }
    if (foodAttributes != null) {
      data['foodAttributes'] = foodAttributes!.map((v) => v.toJson()).toList();
    }
    if (foodAttributeTypes != null) {
      data['foodAttributeTypes'] =
          foodAttributeTypes!.map((v) => v.toJson()).toList();
    }
    if (foodVersionIds != null) {
      data['foodVersionIds'] = foodVersionIds!.map((v) => v.toJson()).toList();
    }
    data['commonNames'] = commonNames;
    data['additionalDescriptions'] = additionalDescriptions;
    data['foodCode'] = foodCode;
    data['foodCategoryId'] = foodCategoryId;
    data['ndbNumber'] = ndbNumber;
    return data;
  }
}

class FoodNutrients {
  int? nutrientId;
  String? nutrientName;
  String? nutrientNumber;
  String? unitName;
  String? derivationCode;
  String? derivationDescription;
  int? derivationId;
  double? value;
  int? foodNutrientSourceId;
  String? foodNutrientSourceCode;
  String? foodNutrientSourceDescription;
  int? rank;
  int? indentLevel;
  int? foodNutrientId;
  int? percentDailyValue;
  int? dataPoints;
  double? min;
  double? max;

  FoodNutrients(
      {this.nutrientId,
      this.nutrientName,
      this.nutrientNumber,
      this.unitName,
      this.derivationCode,
      this.derivationDescription,
      this.derivationId,
      this.value,
      this.foodNutrientSourceId,
      this.foodNutrientSourceCode,
      this.foodNutrientSourceDescription,
      this.rank,
      this.indentLevel,
      this.foodNutrientId,
      this.percentDailyValue,
      this.dataPoints,
      this.min,
      this.max});

  FoodNutrients.fromJson(Map<dynamic, dynamic> json) {
    nutrientId = json['nutrientId'];
    nutrientName = json['nutrientName'];
    nutrientNumber = json['nutrientNumber'];
    unitName = json['unitName'];
    derivationCode = json['derivationCode'];
    derivationDescription = json['derivationDescription'];
    derivationId = json['derivationId'];
    value = (json['value'] ?? 0).toDouble();
    foodNutrientSourceId = json['foodNutrientSourceId'];
    foodNutrientSourceCode = json['foodNutrientSourceCode'];
    foodNutrientSourceDescription = json['foodNutrientSourceDescription'];
    rank = json['rank'];
    indentLevel = json['indentLevel'];
    foodNutrientId = json['foodNutrientId'];
    percentDailyValue = json['percentDailyValue'];
    dataPoints = json['dataPoints'];
    min = (json['min'] ?? 0).toDouble();
    max = (json['max'] ?? 0).toDouble();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <String, dynamic>{};
    data['nutrientId'] = nutrientId;
    data['nutrientName'] = nutrientName;
    data['nutrientNumber'] = nutrientNumber;
    data['unitName'] = unitName;
    data['derivationCode'] = derivationCode;
    data['derivationDescription'] = derivationDescription;
    data['derivationId'] = derivationId;
    data['value'] = value;
    data['foodNutrientSourceId'] = foodNutrientSourceId;
    data['foodNutrientSourceCode'] = foodNutrientSourceCode;
    data['foodNutrientSourceDescription'] = foodNutrientSourceDescription;
    data['rank'] = rank;
    data['indentLevel'] = indentLevel;
    data['foodNutrientId'] = foodNutrientId;
    data['percentDailyValue'] = percentDailyValue;
    data['dataPoints'] = dataPoints;
    data['min'] = min;
    data['max'] = max;
    return data;
  }
}

class FinalFoodInputFoods {
  String? foodDescription;
  double? gramWeight;
  int? id;
  String? portionCode;
  String? portionDescription;
  String? unit;
  int? rank;
  int? srCode;
  double? value;

  FinalFoodInputFoods(
      {this.foodDescription,
      this.gramWeight,
      this.id,
      this.portionCode,
      this.portionDescription,
      this.unit,
      this.rank,
      this.srCode,
      this.value});

  FinalFoodInputFoods.fromJson(Map<dynamic, dynamic> json) {
    foodDescription = json['foodDescription'];
    gramWeight = json['gramWeight'].toDouble();
    id = json['id'];
    portionCode = json['portionCode'];
    portionDescription = json['portionDescription'];
    unit = json['unit'];
    rank = json['rank'];
    srCode = json['srCode'];
    value = (json['value'] ?? 0).toDouble();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <String, dynamic>{};
    data['foodDescription'] = foodDescription;
    data['gramWeight'] = gramWeight;
    data['id'] = id;
    data['portionCode'] = portionCode;
    data['portionDescription'] = portionDescription;
    data['unit'] = unit;
    data['rank'] = rank;
    data['srCode'] = srCode;
    data['value'] = value;
    return data;
  }
}

class FoodMeasures {
  String? disseminationText;
  double? gramWeight;
  int? id;
  String? modifier;
  int? rank;
  String? measureUnitAbbreviation;
  String? measureUnitName;
  int? measureUnitId;

  FoodMeasures(
      {this.disseminationText,
      this.gramWeight,
      this.id,
      this.modifier,
      this.rank,
      this.measureUnitAbbreviation,
      this.measureUnitName,
      this.measureUnitId});

  FoodMeasures.fromJson(Map<dynamic, dynamic> json) {
    disseminationText = json['disseminationText'];
    gramWeight = (json['gramWeight'] ?? 0).toDouble();
    id = json['id'];
    modifier = json['modifier'];
    rank = json['rank'];
    measureUnitAbbreviation = json['measureUnitAbbreviation'];
    measureUnitName = json['measureUnitName'];
    measureUnitId = json['measureUnitId'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <String, dynamic>{};
    data['disseminationText'] = disseminationText;
    data['gramWeight'] = gramWeight;
    data['id'] = id;
    data['modifier'] = modifier;
    data['rank'] = rank;
    data['measureUnitAbbreviation'] = measureUnitAbbreviation;
    data['measureUnitName'] = measureUnitName;
    data['measureUnitId'] = measureUnitId;
    return data;
  }
}

class FoodAttributeTypes {
  String? name;
  String? description;
  int? id;
  List<FoodAttributes>? foodAttributes;

  FoodAttributeTypes(
      {this.name, this.description, this.id, this.foodAttributes});

  FoodAttributeTypes.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    description = json['description'];
    id = json['id'];
    if (json['foodAttributes'] != null) {
      foodAttributes = <FoodAttributes>[];
      json['foodAttributes'].forEach((v) {
        foodAttributes!.add(FoodAttributes.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['id'] = id;
    if (foodAttributes != null) {
      data['foodAttributes'] = foodAttributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodAttributes {
  String? value;
  int? id;
  String? name;
  int? sequenceNumber;

  FoodAttributes({this.value, this.id, this.name, this.sequenceNumber});

  FoodAttributes.fromJson(Map<dynamic, dynamic> json) {
    value = json['value'];
    id = json['id'];
    name = json['name'];
    sequenceNumber = json['sequenceNumber'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['id'] = id;
    data['name'] = name;
    data['sequenceNumber'] = sequenceNumber;
    return data;
  }
}

class Aggregations {
  DataType? dataType;
  dynamic nutrients;

  Aggregations({this.dataType, this.nutrients});

  Aggregations.fromJson(Map<dynamic, dynamic> json) {
    dataType =
        json['dataType'] != null ? DataType.fromJson(json['dataType']) : null;
    nutrients = json['nutrients'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <String, dynamic>{};
    if (dataType != null) {
      data['dataType'] = dataType!.toJson();
    }
    data['nutrients'] = nutrients;
    return data;
  }
}

class DataType {
  int? branded;
  int? surveyFNDDS;
  int? sRLegacy;
  int? foundation;

  DataType({this.branded, this.surveyFNDDS, this.sRLegacy, this.foundation});

  DataType.fromJson(Map<dynamic, dynamic> json) {
    branded = json['Branded'];
    surveyFNDDS = json['Survey (FNDDS)'];
    sRLegacy = json['SR Legacy'];
    foundation = json['Foundation'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <String, dynamic>{};
    data['Branded'] = branded;
    data['Survey (FNDDS)'] = surveyFNDDS;
    data['SR Legacy'] = sRLegacy;
    data['Foundation'] = foundation;
    return data;
  }
}
