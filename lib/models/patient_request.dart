class PatientRequest {
  String id;
  String bloodType;
  String gender;
  String relation;
  String age;
  String createdAt;
  String phoneNumber;
  String qty;

  PatientRequest({
    required this.id,
    required this.bloodType,
    required this.age,
    required this.createdAt,
    required this.gender,
    required this.phoneNumber,
    required this.relation,
    required this.qty,
  });

  factory PatientRequest.fromMap(Map<String, dynamic> map) {
    return PatientRequest(
      bloodType: map['bloodType'] ?? "",
      age: map['age'] ?? "",
      createdAt: map['createAt'] ?? "",
      gender: map['gender'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      relation: map['relation'] ?? "",
      id: map['id'] ?? "",
      qty: map['qty'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'bloodGroup': bloodType,
      "gender": gender,
      'relation': relation,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
      'id': id,
      'qty': qty,
    };
  }
}
