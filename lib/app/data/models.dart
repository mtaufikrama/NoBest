// class FatSecretModels {
//   Foods? foods;

//   FatSecretModels({this.foods});

//   FatSecretModels.fromJson(Map<String, dynamic> json) {
//     foods = json['foods'] != null ? Foods.fromJson(json['foods']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (foods != null) {
//       data['foods'] = foods!.toJson();
//     }
//     return data;
//   }
// }

// class Foods {
//   List<Food>? food;
//   String? maxResults;
//   String? pageNumber;
//   String? totalResults;

//   Foods({this.food, this.maxResults, this.pageNumber, this.totalResults});

//   Foods.fromJson(Map<String, dynamic> json) {
//     if (json['food'] != null) {
//       food = <Food>[];
//       json['food'].forEach((v) {
//         food!.add(Food.fromJson(v));
//       });
//     }
//     maxResults = json['max_results'];
//     pageNumber = json['page_number'];
//     totalResults = json['total_results'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (food != null) {
//       data['food'] = food!.map((v) => v.toJson()).toList();
//     }
//     data['max_results'] = maxResults;
//     data['page_number'] = pageNumber;
//     data['total_results'] = totalResults;
//     return data;
//   }
// }

// class Food {
//   String? brandName;
//   String? foodDescription;
//   String? foodId;
//   String? foodName;
//   String? foodType;
//   String? foodUrl;

//   Food(
//       {this.brandName,
//       this.foodDescription,
//       this.foodId,
//       this.foodName,
//       this.foodType,
//       this.foodUrl});

//   Food.fromJson(Map<String, dynamic> json) {
//     brandName = json['brand_name'];
//     foodDescription = json['food_description'];
//     foodId = json['food_id'];
//     foodName = json['food_name'];
//     foodType = json['food_type'];
//     foodUrl = json['food_url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['brand_name'] = brandName;
//     data['food_description'] = foodDescription;
//     data['food_id'] = foodId;
//     data['food_name'] = foodName;
//     data['food_type'] = foodType;
//     data['food_url'] = foodUrl;
//     return data;
//   }
// }
