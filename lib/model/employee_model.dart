class EmployeeModel {
  String? employeeName;
  String? gender;
  String? joiningDate;
  String? mobileNumber;

  EmployeeModel({
    required this.employeeName,
    required this.gender,
    required this.joiningDate,
    required this.mobileNumber,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> jsonData) {
    return EmployeeModel(
      employeeName: jsonData['name'],
      gender: jsonData['gender'],
      joiningDate: jsonData['joiningDate'],
      mobileNumber: jsonData['mobileNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': employeeName,
        'gender': gender,
        'joiningDate': joiningDate,
        'mobileNumber': mobileNumber,
      };
}
