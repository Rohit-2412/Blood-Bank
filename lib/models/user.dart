class UserModel {
  String uid;
  String name;
  String dob;
  String age;
  String healthConditions;
  String bloodGroup;
  String createdAt;
  String phoneNumber;

  UserModel({
    required this.uid,
    required this.name,
    required this.dob,
    required this.age,
    required this.healthConditions,
    required this.bloodGroup,
    required this.createdAt,
    required this.phoneNumber,
  });

  // data from server to object (deserialization)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'] ?? "",
      dob: map['dob'] ?? '',
      age: map['age'] ?? '',
      healthConditions: map['healthConditions'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
      createdAt: map['createdAt'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

  // object to data from server (serialization)
  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'bloodGroup': bloodGroup,
      'createdAt': createdAt,
      'dob': dob,
      'healthConditions': healthConditions,
      'name': name,
      'phoneNumber': phoneNumber,
      'uid': uid,
    };
  }
}
