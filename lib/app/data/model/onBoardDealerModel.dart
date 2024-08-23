class OnBoardDealerManagement {
  String name;
  String mobileNumber;
  String email;
  String city;
  String cnic;
  String address;
  String area;
  String education;
  String profession;
  String previousExperience;
  String investmentAmount;
  String dealerType;
  String categoryType;
  String userId;
  String imageFile;
  int isSync;

  OnBoardDealerManagement({
    required this.name,
    required this.isSync,
    required this.mobileNumber,
    required this.email,
    required this.city,
    required this.cnic,
    required this.address,
    required this.area,
    required this.education,
    required this.profession,
    required this.previousExperience,
    required this.investmentAmount,
    required this.dealerType,
    required this.categoryType,
    required this.userId,
    required this.imageFile,
  });

  // Convert a User into a Map. The keys must correspond to the names of the JSON attributes.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isSync': isSync,
      'mobileNumber': mobileNumber,
      'email': email,
      'city': city,
      'cnic': cnic,
      'address': address,
      'area': area,
      'education': education,
      'profession': profession,
      'previousExperience': previousExperience,
      'investmentAmount': investmentAmount,
      'dealerType': dealerType,
      'categoryType': categoryType,
      'userId': userId,
      'imageFile': imageFile,
    };
  }

  // Create a User from JSON data
  factory OnBoardDealerManagement.fromJson(Map<String, dynamic> json) {
    return OnBoardDealerManagement(
      name: json['name'],
      isSync: json['isSync'],
      mobileNumber: json['mobileNumber'],
      email: json['email'],
      city: json['city'],
      cnic: json['cnic'],
      address: json['address'],
      area: json['area'],
      education: json['education'],
      profession: json['profession'],
      previousExperience: json['previousExperience'],
      investmentAmount: json['investmentAmount'],
      dealerType: json['dealerType'],
      categoryType: json['categoryType'],
      userId: json['userId'],
      imageFile: json['imageFile'],
    );
  }
}
