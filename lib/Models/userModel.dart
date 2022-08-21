class UserModel{
  String companyName;
  String companyType;
  String ntnNumber;

  UserModel(this.companyName, this.companyType, this.ntnNumber);

  Map<String, dynamic> toJson() => {
    'companyName': companyName,
    'companyType':companyType,
    'NTNNumber':ntnNumber,
  };
}